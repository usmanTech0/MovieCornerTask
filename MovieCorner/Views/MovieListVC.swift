//
//  MovieListVC.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import UIKit

class MovieListVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView:UITableView!
    
    
    // MARK: - Variables and Constant
    
    private var viewModel = MovieListViewModel()
    
    
    //MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        viewModel.getMovies()
        tableView.register(UINib(nibName: "MovietableCell", bundle: nil), forCellReuseIdentifier: "MovietableCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - IBActions
    
    
    // MARK: - Helper Methods
    
    
    // MARK: - #Selectors
    
    // MARK: - User Methods
    private func setupBinders() {
        viewModel.moviesData.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}


extension MovieListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesData.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovietableCell", for: indexPath) as? MovietableCell else {return UITableViewCell()}
        guard let movie = self.viewModel.moviesData.value?[indexPath.row] else {return UITableViewCell()}
        cell.imgView.downloadImage(withWidth: .w200, path: movie.posterPath ?? "")
        cell.titlelbl.text = movie.title ?? ""
        cell.detaillbl.text = movie.releaseDate
            //load more pages
        if indexPath.row >= self.viewModel.moviesData.value!.count-5 {
            viewModel.getMovies()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = self.viewModel.moviesData.value?[indexPath.row].id else {return}
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as? MovieDetailVC {
            vc.movieId = movieID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
