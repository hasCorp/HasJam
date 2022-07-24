//
// Created by Alyx Mote on 7/23/22.
//

import Fluent

struct CreatePrompt: AsyncMigration {
    func prepare(on database: Database) async throws {
        return try await database.schema("prompts")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("jam_id", .uuid, .required, .references("jams", "id", onDelete: .cascade))
            .field("prompt", .string, .required)
            .field("desc", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        return try await database.schema("prompts").delete()
    }
}
