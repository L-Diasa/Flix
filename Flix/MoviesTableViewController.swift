//
//  MoviesViewController.swift
//  Flix
//
//  Created by lika on 2/24/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies = [Movie]() {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies(link: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed" ) {
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
            as? MovieTableCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexpath = movieTableView.indexPath(for: cell)!
        let movie = movies[indexpath.row]
        // Pass it to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        // Deselect movie
        movieTableView.deselectRow(at: indexpath, animated: true)
    }
}
