//
// Created by Alyx Mote on 7/23/22.
//

import Vapor

struct ClientUser: Content {
    var id: UUID?
    var username: String
    var avatar: String?
    var coverPic: String?
    var termsAgree: Bool
    var emailConfirmed: Bool
    var createdAt: Date?
    var updatedAt: Date?

    init(from user: User) {
        id = user.id
        username = user.username
        avatar = user.avatar
        coverPic = user.coverPic
        termsAgree = user.termsAgree
        emailConfirmed = user.emailConfirmed
        createdAt = user.createdAt
        updatedAt = user.updatedAt
    }
}
