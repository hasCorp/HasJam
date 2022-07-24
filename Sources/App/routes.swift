import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "HasJam API ready!"
    }

    try app.register(collection: AuthController())
}
