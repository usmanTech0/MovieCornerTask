//
//  DbHandler.swift
//  MovieCorner
//
//  Created by M Usman on 22/11/2023.
//

import Foundation
import SQLite3
class DbHandler {
    
    static let shared = DbHandler()
    
    init()
    {
        db = openDatabase()
        createTable()
    }
    
    let dbPath: String = "movies.db"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS movies_popular(id INTEGER PRIMARY KEY,poster_path TEXT, release_date TEXT, title TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("table created.")
            } else {
                print("table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(movieList : [Movie]){
            for movie in movieList {
                let insertStatementString = "INSERT INTO movies_popular(id, poster_path, release_date,title) VALUES (?,?,?,?);"
                var insertStatement: OpaquePointer? = nil
                if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                    sqlite3_bind_int(insertStatement, 1, Int32(movie.id ?? 0))
                    sqlite3_bind_text(insertStatement, 2, (movie.posterPath! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 3, (movie.releaseDate! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 4, (movie.title! as NSString).utf8String, -1, nil)
                    
                    if sqlite3_step(insertStatement) == SQLITE_DONE {
                        print("Successfully inserted row.")
                    } else {
                        print("Could not insert row.")
                    }
                } else {
                    print("INSERT statement could not be prepared.")
                }
                sqlite3_finalize(insertStatement)
            }
        }
    
    func read() -> [Movie] {
            let queryStatementString = "SELECT * FROM movies_popular;"
            var queryStatement: OpaquePointer? = nil
            var movieList : [Movie] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let postarPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let releaseDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    movieList.append(Movie(adult: nil, backdropPath: nil, genreIDS: nil, id: Int(id), originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: postarPath, releaseDate: releaseDate, title: title, video: nil, voteAverage: nil, voteCount: nil))
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return movieList
        }
}
