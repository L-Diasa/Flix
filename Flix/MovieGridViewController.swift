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
    private var layout: UICollectionViewFlowLayout!
    
    private var portraitCellWidth: CGFloat!
    private var portraitCellHeight: CGFloat!
    private var landscapeCellWidth: CGFloat!
    private var landscapeCellHeight: CGFloat!
    
    private var portraitWidth: CGFloat!
    private var portraitHeight: CGFloat!
    
    private var movies = [Movie]() {
       didSet {
           collectionView.reloadData()
       }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let posterPerRowPortrait = 2
        let posterPerRowLandscape = 5
        
        var viewWidth = UIApplication.shared.windows[0].safeAreaLayoutGuide.layoutFrame.width
        var viewHeight = UIApplication.shared.windows[0].safeAreaLayoutGuide.layoutFrame.height
        if(viewWidth > viewHeight) {
            let tempWidth = viewHeight
            viewHeight = viewWidth
            viewWidth = tempWidth
        }
        
        portraitCellWidth = ((viewWidth - layout.minimumInteritemSpacing * CGFloat((posterPerRowPortrait - 1))) / CGFloat(posterPerRowPortrait))
        portraitCellHeight = portraitCellWidth * 3 / 2
        landscapeCellWidth = ((viewHeight - layout.minimumInteritemSpacing * CGFloat((posterPerRowLandscape - 1))) / CGFloat(posterPerRowLandscape))
        landscapeCellHeight = landscapeCellWidth * 3 / 2

        if UIDevice.current.orientation.isLandscape
        {
            layout.itemSize = CGSize(width: landscapeCellWidth!, height: landscapeCellHeight!)
        }
        else {
            layout.itemSize = CGSize(width: portraitCellWidth!, height: portraitCellHeight!)
        }

        
         fetchMovies(link: "https://api.themoviedb.org/3/movie/1771/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"
         ) {
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
