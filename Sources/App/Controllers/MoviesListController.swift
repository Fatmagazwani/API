import Foundation
import Fluent
import Vapor

struct Movies: Content{
    let moviename: String
    let movieyear: Int
    let moviestory: String
    let moviegenre: String
    let movieactors: Actors
    let moviedirector: String

}
struct Actors: Content{
    let actor1: String
    let actor2: String
    let actor3: String?
    let actor4: String?

}


struct MoviesListController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let movieslist = routes.grouped("MoviesList")
        movieslist.get("movies", use: getMoviesList)
        movieslist.post("prayer", use: create)
//        prayer.group(":prayerId") { prayer in
//            prayer.delete(use: delete)
//        }
    }
    
    func create (req: Request) throws -> HTTPStatus {
        
        //http://127.0.0.1:8080
        let movies = try req.content.decode(Movies.self)
        print(movies)
        return HTTPStatus.ok
    
    }
    
    
    func getMoviesList(req: Request) throws -> [Movies] {
        
        let movieactors = Actors(actor1:"actor one", actor2: "actor two", actor3:"actor three", actor4: "actor four")
        let Movies = Movies(moviename:"How to", movieyear: 2033,moviestory:"a dragon runs and hide to a mounton", moviegenre:"comedy", movieactors: movieactors, moviedirector:"me")
        return [Movies]

    }
    }
