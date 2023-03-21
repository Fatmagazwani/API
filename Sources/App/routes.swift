import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: MoviesListController())
    //local host http://127.0.0.1:8080
    
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("movies") { req in
        MoviesList.query(on: req.db).all()
    }
    
    app.get("movies", ":movieID") { req -> EventLoopFuture <MoviesList> in
        MoviesList.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    app.put("movies") { req -> EventLoopFuture <HTTPStatus> in
        let movie = try req.content.decode(MoviesList.self)
        return MoviesList.find(movie.id, on:req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                
                $0.moviename = movie.moviename
                $0.movieyear = movie.movieyear
                $0.moviegenre = movie.moviegenre
                $0.movieactor1 = movie.movieactor1
                $0.movieactor2 = movie.movieactor2
                $0.moviedirector = movie.moviedirector
                
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    app.delete("movies", ":movieID") { req -> EventLoopFuture <HTTPStatus> in
        MoviesList.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db).transform(to: .ok)
            }
    }
    app.post("movies") { req -> EventLoopFuture <MoviesList> in
        let movie = try req.content.decode(MoviesList.self)
        return movie.create(on: req.db).map {movie}
    }
    
    try app.register(collection: MoviesListController())
}





