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
        
        // Define didTap methd
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))

        // Attach it to posterView
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        // Show trailer screen
        performSegue(withIdentifier : "showTrailer", sender: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass movie id to the trailer view controller
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.id = movie.id
    }
}
