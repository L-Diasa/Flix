//
//  MoviesViewController.swift
//  Flix
//
//  Created by lika on 2/24/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies = [Movie]() {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieService.shared.fetchMovies {
            movies in
            self.movies = movies
        }
        movieTableView.dataSource = self
        movieTableView.delegate = self
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")
            as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
}
