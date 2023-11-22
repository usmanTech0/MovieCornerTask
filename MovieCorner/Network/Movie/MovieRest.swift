//
//  MovieRest.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//


import Alamofire

class MovieRest {
    static func popularMovies(pageNumber:Int32)->NetworkRequest<String,PopularMoviesModel>{
        let httpReqModel = NetworkRequest<String,PopularMoviesModel>(
            method : HTTPMethod.get,
            url: URLSettings.moviesPopular(page: pageNumber)
        )
        return httpReqModel
    }
    static func movieDetail(id:Int32)->NetworkRequest<String,MovieDetailModel>{
        let httpReqModel = NetworkRequest<String,MovieDetailModel>(
            method : HTTPMethod.get,
            url: URLSettings.movieDetail(id: id)
        )
        return httpReqModel
    }
}
