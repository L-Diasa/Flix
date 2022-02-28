//
//  MovieGridCell.swift
//  Flix
//
//  Created by lika on 2/28/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {
    
    @IBOutlet weak var posterView: UIImageView!
    
    func configure(with movie: Movie) {
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.posterURL)!
        posterView.af.setImage(withURL: posterUrl)
    }
}
