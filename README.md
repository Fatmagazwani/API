# API
Team 1 Backend
1. Ghala AlBarakati
2. Fatma Gazwani
3. Nouf alghamdi

# Solution Concept

An API to help users get, create, update and delete information about movies

## App Statement

An Api to help users get, create, update and delete information about movies

# Feature List

1. Create movies information
2. Get movie list information
2. Update movie information
4. Delete movie information

### Info we nedded:

1. Name
2. Year
3. Story
4. Genre
5. Actors
6. Movie Director


# Get Movie List with CRUD API:

## Create:

    app.post("movies") { req -> EventLoopFuture <MoviesList> in
        let movie = try req.content.decode(MoviesList.self)
        return movie.create(on: req.db).map {movie}
    }
    
    try app.register(collection: MoviesListController())}

## Read:

    app.get("movies", ":movieID") { req -> EventLoopFuture <MoviesList> in
        MoviesList.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
  
## Update:
  
     app.put("movies") { req -> EventLoopFuture <HTTPStatus> in
        let movie = try req.content.decode(MoviesList.self)
        return MoviesList.find(movie.id, on:req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                
                $0.moviename = movie.moviename
                $0.movieyear = movie.movieyear
                $0.moviestory = movie.moviestory
                $0.moviegenre = movie.moviegenre
                $0.movieactor1 = movie.movieactor1
                $0.movieactor2 = movie.movieactor2
                $0.moviedirector = movie.moviedirector
                
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
  
## Delete:
    
    app.delete("movies", ":movieID") { req -> EventLoopFuture <HTTPStatus> in
        MoviesList.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db).transform(to: .ok)
            }
    }
  


# Database Schema
<img width="1800" alt="Screenshot 1444-08-29 at 9 58 54 AM" src="https://user-images.githubusercontent.com/115143290/226539119-a01d8536-5100-44b4-919a-c3e6e5062b71.png">



### Deployment Server (if any)
