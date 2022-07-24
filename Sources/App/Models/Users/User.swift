//
// Created by Alyx Mote on 7/23/22.
//

import Vapor
import Fluent
import Argon2Swift

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @OptionalField(key: "avatar")
    var avatar: String?

    @OptionalField(key: "cover_pic")
    var coverPic: String?

    @Field(key: "terms_agree")
    var termsAgree: Bool

    @Field(key: "email_confirmed")
    var emailConfirmed: Bool

    @Field(key: "roles")
    var roles: [Roles]

    @Children(for: \.$user)
    var sessions: [Session]

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(id: UUID? = nil, with formInfo: RegisterForm) throws {
        guard let hashedPassword = try? Argon2Swift.hashPasswordString(password: formInfo.password, salt: Salt.newSalt(), type: Argon2Type.id) else {
            throw Abort(.internalServerError)
        }

        self.id = id
        email = formInfo.email
        username = formInfo.username
        password = hashedPassword.encodedString()
        avatar = nil
        coverPic = nil
        termsAgree = formInfo.termsAgree
        emailConfirmed = false
        roles = [.user]
    }
}

extension User {
    struct LoginForm: Codable {
        var email: String
        var password: String
        var rememberMe: Bool
    }

    struct RegisterForm: Codable {
        var email: String
        var username: String
        var password: String
        var termsAgree: Bool
    }

    enum Roles: String, Codable {
        case user = "User"
        case verified = "Verified"
        case moderator = "Moderator"
        case admin = "Admin"
    }
}

extension User.LoginForm: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)

        validations.add("password", as: String.self, is: .alphanumeric)
        validations.add("password", as: String.self, is: .count(...32))

        validations.add("rememberMe", as: Bool.self, is: .valid)
    }
}

extension User.RegisterForm: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)

        validations.add("username", as: String.self, is: .alphanumeric)
        validations.add("username", as: String.self, is: .count(3...16))

        validations.add("password", as: String.self, is: .alphanumeric)
        validations.add("password", as: String.self, is: .count(...32))

        validations.add("termsAgree", as: Bool.self, is: .valid)
    }
}