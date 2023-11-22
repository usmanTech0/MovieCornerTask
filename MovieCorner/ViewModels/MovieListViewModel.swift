//
//  MovieListViewModel.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

class MovieListViewModel {
    var pageNumber : Int32 = 0
    var moviesData : ObservableObject<[Movie]?> = ObservableObject(nil)
    
    func getMovies(){
        //if internet not connected
        if !Reachability.isConnectedToNetwork() && moviesData.value == nil {
            let moviesList = DbHandler.shared.read()
            if  moviesList.count > 0 {
                self.moviesData.value = moviesList
            }
            return
        }
        pageNumber += 1
        MovieRest.popularMovies(pageNumber: pageNumber).sendHTTPRequest { (response) in
            if self.moviesData.value == nil {
                self.moviesData.value = response?.movies
            }else{
                self.moviesData.value! += response?.movies ?? [Movie]()
            }
            // offline support
            DbHandler.shared.insert(movieList: self.moviesData.value ?? [Movie]())
        } failed: { responseCode, error in
            print(error)
        }
    }
}
