import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public enum APIError: Error {
    case credentialsDB
}

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    if let databaseURL = Environment.get("DATABASE_URL") {
        var tlsConfig: TLSConfiguration = .makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        let nioSSLContext = try NIOSSLContext(configuration: tlsConfig)

        var postgresConfig = try SQLPostgresConfiguration(url: databaseURL)
        postgresConfig.coreConfiguration.tls = .require(nioSSLContext)

        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        throw APIError.credentialsDB
    }
    
//    app.databases.use(.postgres(configuration: .init(
//        hostname: "c7u1tn6bvvsodf.cluster-czz5s0kz4scl.eu-west-1.rds.amazonaws.com",
//        port: SQLPostgresConfiguration.ianaPortNumber,
//        username: "u5pmff728aifiv",
//        password: "pc2d9b19f5b41ecc6583732fdbaeb12896be95b0a2c14e88993316c06771a1553",
//        database: "d41nojgan65gpk",
//        tls: .prefer(try .init(configuration: .clientDefault)))
//    ), as: .psql )

    app.migrations.add(CreateStyle())

    app.views.use(.leaf)


    // register routes
    try routes(app)
}
