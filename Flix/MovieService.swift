//
//  MovieService.swift
//  Flix
//
//  Created by lika on 2/25/22.
//  Copyright © 2022 lika. All rights reserved.
//

import Foundation

func fetchMovies(link: String, completion: @escaping ([Movie]) -> Void) {
    let url = URL(string:  link)!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
         // This will run when the network request returns
         if let error = error {
                print(error.localizedDescription)
         } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            let moviesRawData  = dataDictionary["results"] as! [[String: Any]]
            var movies = [Movie]()
            for rawData in moviesRawData {
                let movie = Movie(title: rawData["title"] as! String,
                                  synopsis: rawData["overview"] as! String,
                                  posterURL: rawData["poster_path"] as! String,
                                  backdropURL: rawData["backdrop_path"] as! String,
                                  id: rawData["id"] as! Int)
                movies.append(movie)
            }
            completion(movies)
         }
    })
    task.resume()
}

func fetchTrailer(id: Int, completion: @escaping (String) -> Void) {
    let url = URL(string:  "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
         // This will run when the network request returns
         if let error = error {
                print(error.localizedDescription)
         } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let trailerRawData  = dataDictionary["results"] as! [[String: Any]]
            let trailerKey = trailerRawData[0]["key"] as! String
            completion(trailerKey)
         }
    })
    task.resume()
}
