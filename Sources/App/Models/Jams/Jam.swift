//
// Created by Alyx Mote on 7/23/22.
//

import Vapor
import Fluent

final class Jam: Model, Content {
    static let schema = "jams"

    @ID(key: .id)
    var id: UUID?
}

extension Jam {
    enum Stages: String, Codable {
        case promptSubmission
        case promptVoting
        case prep
        case inProgress
        case firstRound
        case secondRound
        case completed
    }
}
