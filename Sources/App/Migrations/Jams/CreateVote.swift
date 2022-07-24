//
// Created by Alyx Mote on 7/23/22.
//

import Fluent

struct CreateVote: AsyncMigration {
    func prepare(on database: Database) async throws {
        return try await database.schema("votes")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("prompt_id", .uuid, .required, .references("prompts", "id", onDelete: .cascade))
            .create()
    }

    func revert(on database: Database) async throws {
        return try await database.schema("votes").delete()
    }
}
