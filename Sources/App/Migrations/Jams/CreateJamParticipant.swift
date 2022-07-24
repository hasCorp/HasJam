//
// Created by Alyx Mote on 7/23/22.
//

import Fluent

struct CreateJamParticipant: AsyncMigration {
    func prepare(on database: Database) async throws {
        return try await database.schema("jam_participants")
            .id()
            .field("jam_id", .uuid, .required, .references("jams", "id", onDelete: .cascade))
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        return try await database.schema("jam_participants").delete()
    }
}
