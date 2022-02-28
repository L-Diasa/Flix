//
//  MovieGridViewController.swift
//  Flix
//
//  Created by lika on 2/27/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController,
                                UICollectionViewDataSource,
                                    UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var movies = [Movie]() {
       didSet {
           collectionView.reloadData()
       }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
         fetchMovies(link: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed") {
                    movies in
                    self.movies = movies
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        cell.configure(with: movies[indexPath.item])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexpath = collectionView.indexPath(for: cell)!
        let movie = movies[indexpath.item]
        // Pass it to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        // Deselect movie
        collectionView.deselectItem(at: indexpath, animated: true)
    }
}
