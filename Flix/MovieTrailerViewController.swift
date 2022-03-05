//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by lika on 3/2/22.
//  Copyright © 2022 lika. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var trailerView: UIView!
    @IBOutlet weak var trailerWindow: WKWebView!

    var id: Int!
    private var key: String! {
        didSet {
            let myURL = URL(string:"https://www.youtube.com/watch?v=\(key!)")
            let myRequest = URLRequest(url: myURL!)
            trailerWindow.load(myRequest)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTrailer(id: id){
            trailerKey in
            self.key = trailerKey
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
