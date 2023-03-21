//
//  File.swift
//  
//
//  Created by Fatma Gazwani on 27/08/1444 AH.
//

import Foundation
import Fluent
import Vapor
import FluentPostgresDriver

struct CreateMoviesList: AsyncMigration {
    
    //
    func prepare(on database: Database) async throws {
        try await database.schema("MoviesList")
            .id()
            .field("moviename", .string, .required)
            .field("movieyear", .string)
            .field("moviestory", .string)
            .field("moviegenre", .string)
            .field("movieactor1", .string)
            .field("movieactor2", .string)
            .field("moviedirector", .string)
            .create()
    }
    
    //undo
    func revert(on database: Database) async throws {
        try await database.schema("MoviesList").delete()
    }
}

