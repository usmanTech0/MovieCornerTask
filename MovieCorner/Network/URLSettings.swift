//
//  URLSettings.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

public class URLSettings {
    
    //Base URL
    static let domain:String = "api.themoviedb.org"
    static let PROTOCOL:String = "https"
    static let apiVersion:Int = 3
    public static let baseURL:String = "\(PROTOCOL)://\(domain)/\(apiVersion)/movie/"
    
    //Image BaseURL
    public static let imageBaseURL = "https://image.tmdb.org/t/p/"
    

    /************** Movie API ****************/
    public static func moviesPopular(page : Int32 = 1) -> String{
        return "\(baseURL)popular?page=\(page)"
    }
    public static func movieDetail(id : Int32) -> String{
        return "\(baseURL)\(id)"
    }
}
