import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) throws {
    app.logger.notice("Starting hasJam API...")

    // Setting up JWT signing
    app.logger.notice("Assigning secret key...")
    app.jwt.signers.use(.hs256(key: Environment.get("JWT_SECRET") ?? "aSecret"))

    // Establishing DB Connection
    app.logger.notice("Establishing database connection...")
    let databaseUrl = Environment.get("POSTGRES_URL") ?? "postgresql://postgres@localhost/hasjam"
    try app.databases.use(.postgres(url: databaseUrl), as: .psql)

    // Establishing migrations for `vapor run migrate`
    app.logger.notice("Adding migrations...")
    app.migrations.add(CreateUser())
    app.migrations.add(CreateSession())

    // CORS configuration
    app.logger.notice("Assigning CORS configuration...")
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: CORSMiddleware.AllowOriginSetting.any([
            "http://localhost:3000",
            "http://127.0.0.1:3000",
            "https://hasjam.dev",
            "https://www.hasjam.dev",
        ]),
        allowedMethods: [.GET, .POST, .PUT, .PATCH, .OPTIONS],
        allowedHeaders: [
            .accept,
            .authorization,
            .contentType,
            .origin,
            .xRequestedWith,
            .userAgent,
            .accessControlAllowOrigin
        ]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(cors, at: .beginning)

    // Register routes
    app.logger.notice("Acknowledging routes...")
    try routes(app)

    // Show all routes
    for route in app.routes.all {
        let pathArr = route.path.map { item in
            String(item.description)
        }
        app.logger.info("Route acknowledged: /\(pathArr.joined(separator: "/"))")
    }
}
