//
//  MovieDetailViewModel.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

class MovieDetailViewModel {
    var moviesDetail : ObservableObject<MovieDetailModel?> = ObservableObject(nil)
    
    func getMovieDetail(id:Int32) {
        MovieRest.movieDetail(id: id).sendHTTPRequest { [weak self]response in
            self?.moviesDetail.value = response
        } failed: { responseCode, error in
            print(error)
        }
    }
    
}
