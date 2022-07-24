//
// Created by Alyx Mote on 7/23/22.
//

import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        return try await database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("avatar", .string)
            .field("cover_pic", .string)
            .field("terms_agree", .bool, .required)
            .field("email_confirmed", .bool, .required)
            .field("roles", .array(of: .string))
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "email")
            .unique(on: "username")
            .create()
    }

    func revert(on database: Database) async throws {
        return try await database.schema("users").delete()
    }
}
