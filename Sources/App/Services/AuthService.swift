//
// Created by Alyx Mote on 7/23/22.
//

import Foundation
import Vapor
import Fluent
import Argon2Swift
import UAParserSwift

struct AuthService {
    /// Creates a new account, saves it to the database, then returns a valid session for this user.
    ///
    /// - Throws: when a new account fails to be created for any reason, or when a session fails to be created
    static func register(via req: Request, with registerForm: User.RegisterForm) async throws -> Session.ClientPackage {
        let newUser = try User(with: registerForm)
        try await newUser.save(on: req.db)
        return try await createSession(for: newUser, via: req, session: true)
    }

    /// Logs in an existing user by first verifying that the account exists, then verifying the password
    /// matches our records.
    ///
    /// - Throws: if login fails for any reason, or if creating a session fails for any reason
    static func login(via req: Request, with loginForm: User.LoginForm) async throws -> Session.ClientPackage {
        guard let existingUser = try await User.query(on: req.db).filter(\.$email == loginForm.email).first() else {
            throw Abort(.notFound)
        }

        guard let compareResult = try? Argon2Swift.verifyHashString(
            password: loginForm.password,
            hash: existingUser.password,
            type: Argon2Type.id
        ) else {
            throw Abort(.notFound)
        }

        if compareResult == true {
            return try await createSession(for: existingUser, via: req, session: loginForm.rememberMe)
        } else {
            throw Abort(.notFound)
        }
    }

    /// Logs out a user and erases any `accessKey`. Any cookie erasure should happen on the client,
    /// but we check if the `accessKey` cookie exists anyway.
    ///
    /// - Throws: when a token fails to be verified, when a user cannot be found,
    /// or when something goes wrong removing a session from the database
    static func logout(via req: Request, with res: Response) async throws -> Response {
        guard let existingToken = req.cookies["accessKey"] else {
            res.status = .ok
            return res
        }

        guard let verifiedToken = try? req.jwt.verify(existingToken.string, as: Session.TokenPayload.self) else {
            throw Abort(.badRequest)
        }

        guard let user = try await User.find(verifiedToken.userId, on: req.db) else {
            throw Abort(.notFound)
        }

        try await user.$sessions.query(on: req.db).filter(\.$id == verifiedToken.accessKey).delete()
        res.status = .ok
        return res
    }

    /// Creates a new session for the specified account, saving it to the database.
    ///
    /// - Throws: when a new session fails to be created, or when signing the JWT fails
    private static func createSession(for user: User, via req: Request, session: Bool) async throws -> Session.ClientPackage {
        let sessionId = UUID()
        let expiration = session
            ? Date(timeInterval: 60.0 * 60.0 * 24.0 * 30.0, since: .now)
            : Date(timeInterval: 60.0 * 60.0 * 24.0, since: .now)
        let newSession = Session(id: sessionId, with: getUserAgent(from: req), expires: expiration)
        try await user.$sessions.create(newSession, on: req.db)

        let token = try req.jwt.sign(
            Session.TokenPayload(
                subject: "hasjam",
                expiration: .init(value: expiration),
                userId: user.id,
                accessKey: sessionId
            )
        )

        return Session.ClientPackage(user: .init(from: user), token: token)
    }

    /// Gets the user agent from request headers.
    private static func getUserAgent(from req: Request) -> Session.DeviceInfo {
        let parsedInfo = UAParser(agent: req.headers.first(name: .userAgent).unsafelyUnwrapped)
        return Session.DeviceInfo(
            browserName: parsedInfo.browser?.name ?? "unknown name",
            browserVer: parsedInfo.browser?.version ?? "unknown version",
            ipAddr: req.remoteAddress?.ipAddress ?? "unknown",
            osName: parsedInfo.os?.name ?? "unknown name",
            osVer: parsedInfo.os?.version ?? "unknown version"
        )
    }
}
