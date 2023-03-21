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
    @Field(key: "movieactor1")
    var movieactor1: String
    @Field(key: "movieactor2")
    var movieactor2: String
    @Field(key: "moviedirector")
    var moviedirector: String
      
    init() { }

    init(id: UUID? = nil, moviename: String, movieyear: String, moviestory: String, moviegenre: String, movieactor1: String, movieactor2: String,moviedirector: String) {
        self.id = id
        self.moviename = moviename
        self.movieyear = movieyear
        self.moviestory = moviestory
        self.moviegenre = moviegenre
        self.movieactor1 = movieactor1
        self.movieactor2 = movieactor2
        self.moviedirector = moviedirector

    }
}
