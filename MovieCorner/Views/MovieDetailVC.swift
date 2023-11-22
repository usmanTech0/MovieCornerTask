//
//  MovieDetailVC.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import UIKit

class MovieDetailVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var detailBgView:UIView!
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var taglineLbl:UILabel!
    @IBOutlet weak var languageLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var popularityLbl:UILabel!
    
    @IBOutlet weak var noInternetBgView:UIView!
    
    // MARK: - Variables and Constant
    
    private var viewModel = MovieDetailViewModel()
    var movieId : Int = 0
    //MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setupBinders()
        viewModel.getMovieDetail(id: Int32(movieId))
        if !Reachability.isConnectedToNetwork() {
            self.noInternetBgView.isHidden = false
        }
    }
    
    // MARK: - IBActions
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func reloadData(_ sender: UIButton){
        viewModel.getMovieDetail(id: Int32(movieId))
    }
    
    // MARK: - Helper Methods
    
    
    // MARK: - #Selectors
    
    
    // MARK: - User Methods
    private func setupBinders() {
        viewModel.moviesDetail.bind { [weak self] movie in
            if let moviesDetail = movie {
                self?.detailBgView.isHidden = false
                self?.noInternetBgView.isHidden = true
                self?.imgView.downloadImage(path: moviesDetail.posterPath ?? "")
                self?.nameLbl.text = moviesDetail.title
                self?.taglineLbl.text = moviesDetail.tagline
                self?.languageLbl.text = moviesDetail.originalLanguage
                self?.dateLbl.text = moviesDetail.releaseDate
                self?.popularityLbl.text = "\(moviesDetail.popularity ?? 0)"
            }
        }
    }
}
