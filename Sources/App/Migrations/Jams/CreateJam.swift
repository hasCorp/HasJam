//
// Created by Alyx Mote on 7/23/22.
//

import Fluent

struct CreateJam: AsyncMigration {
    func prepare(on database: Database) async throws {
        return try await database.schema("jams")
            .id()
            .field("creator_id", .uuid, .references("users", "id", onDelete: .setNull))
            .field("prompt_id", .uuid, .references("prompts", "id", onDelete: .setNull))
            .field("title", .string, .required)
            .field("stage", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        return try await database.schema("jams").delete()
    }
}
