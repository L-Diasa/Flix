//
//  MovieCell.swift
//  Flix
//
//  Created by lika on 2/25/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        synopsisLabel.text = movie.synopsis
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.posterURL)!
        posterView.af.setImage(withURL: posterUrl)
    }

}
