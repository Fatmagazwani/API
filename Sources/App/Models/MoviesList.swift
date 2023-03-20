import Fluent
import Vapor

final class MoviesList: Model, Content {
    static let schema = "MoviesList"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "moviename")
    var moviename: String
    @Field(key: "movieyear")
    var movieyear: String
    @Field(key: "moviestory")
    var moviestory: String
    @Field(key: "moviegenre")
    var moviegenre: String
    @Field(key: "movieactors")
    var movieactors: Actors
    @Field(key: "moviedirector")
    var moviedirector: String
      
    init() { }

    init(id: UUID? = nil, moviename: String, movieyear: String, moviestory: String, moviegenre: String, movieactors: Actors, moviedirector: String) {
        self.id = id
        self.moviename = moviename
        self.movieyear = movieyear
        self.moviestory = moviestory
        self.moviegenre = moviegenre
        self.movieactors = movieactors
        self.moviedirector = moviedirector

    }
}
