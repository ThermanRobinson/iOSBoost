//
//  MovieViewModel.swift
//  AppBoost
//
//  Created by Therman Robinson on 6/15/21.

import UIKit

protocol MovieViewModelProtocol {
    
    var movieDidChanges: ((Bool, Bool) -> Void)? { get set }
    
    func fetchMovieList()
}
class MovieViewModel: MovieViewModelProtocol {

    //MARK: - Internal Properties
    
    var movieDidChanges: ((Bool, Bool) -> Void)?
    
    var movies: [Movie]? {
        didSet {
            self.movieDidChanges!(true, false)
        }
    }
    
    func fetchMovieList() {
        
        self.movies = [Movie]()
        
        MovieAPIService.instance.fetchMovies { result in
            
            switch result {
                
            case .success(let data):
                
                let mappedModel = try? JSONDecoder().decode(MovieResponseModel.self, from: data) as MovieResponseModel
                
                self.movies = mappedModel?.movie ?? []
                
                break
            case .failure(let error):
                
                print(error.description)
            }
        }
    }
    
}
