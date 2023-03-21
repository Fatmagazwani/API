import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ movieslist: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    movieslist.databases.use(
        .postgres( hostname: "localhost",
                   username: "fatmagazwani",
                   password: "vapor",
                   database: "movieslist")
        , as: .psql)

    movieslist.migrations.add(CreateMoviesList())

    // register routes
    try routes(movieslist)
}
