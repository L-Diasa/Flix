//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by lika on 2/26/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        synopsisLabel.text = movie.synopsis
        synopsisLabel.sizeToFit()
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.posterURL)!
        posterView.af.setImage(withURL: posterUrl)
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + movie.backdropURL)!
        backdropView.af.setImage(withURL: backdropURL)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
