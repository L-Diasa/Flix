//
//  MovieCell.swift
//  Flix
//
//  Created by lika on 2/25/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    let baseUrl = "https://image.tmdb.org/t/p/w185"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        synopsisLabel.text = movie.synopsis
        let posterUrl = URL(string: baseUrl + movie.imageURL)!
        posterView.af.setImage(withURL: posterUrl)
    }

}
