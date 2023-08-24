import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    app.databases.use(.mysql(
        hostname: Environment.get("MYSQLHOSTNAME") ?? "",
        port: Environment.get("MYSQLPORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("MYSQLUSER") ?? "",
        password: Environment.get("MYSQLPASSWORD") ?? "",
        database: Environment.get("MYSQLSCHEME") ?? "",
        tlsConfiguration: nil
    ), as: .mysql)
    
    app.http.server.configuration.hostname = "0.0.0.0"
    app.http.server.configuration.port = 8080

    // register routes
    try routes(app)
}
