import Foundation
import Fluent
import Vapor

struct Movies: Content{
    let moviename: String
    let movieyear: String
    let moviestory: String
    let moviegenre: String
    let movieactor1: String
    let movieactor2: String
    let moviedirector: String
}

struct MoviesListController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let movieslistapi = routes.grouped("movieslistapi")
        movieslistapi.get(use: index)
        movieslistapi.post(use: create)
        movieslistapi.group(":MoviesListID") { movieslist in
            movieslist.delete(use: delete)
        }
        movieslistapi.group(":MoviesListID") { movieslist in
            movieslist.put(use: update)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture <[MoviesList]> {
        return MoviesList.query(on: req.db).all()
    }
    
    
    func create(req: Request) throws -> EventLoopFuture <MoviesList> {
        let movieslist = try req.content.decode(MoviesList.self)
        return movieslist.save(on: req.db).map { movieslist }
    }
    
    func delete(req: Request) throws -> EventLoopFuture <HTTPStatus> {
        return MoviesList.find(req.parameters.get("MoviesListID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {$0.delete(on: req.db)}
            .transform(to: .ok)
    }
    
    
    
    func update(req: Request) throws -> EventLoopFuture <HTTPStatus> {
        let newmovie = try req.content.decode (MoviesList.self)
        return MoviesList.find(newmovie.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.moviename = newmovie.moviename
                $0.movieyear = newmovie.movieyear
                $0.moviegenre = newmovie.moviegenre
                $0.movieactor1 = newmovie.movieactor1
                $0.movieactor2 = newmovie.movieactor2
                $0.moviedirector = newmovie.moviedirector
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
}


