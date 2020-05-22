//
//  ViewController.swift
//  Example Api
//
//  Created by TaniaLebed on 5/10/20.
//  Copyright © 2020 TaniaLebed. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photos: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY"
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            let data = data
            let pictures = try? JSONDecoder().decode(Pictures.self, from: data!)
            self.photos = pictures!.photos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = self.photos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
       
        if let date = row.earth_date! as? String{
            cell.date.text = date
        }
        
        var httpsUrl = row.img_src!
        httpsUrl.insert("s", at: httpsUrl.index(httpsUrl.startIndex, offsetBy: 4))
        
        if let urlToImage = httpsUrl as? String{
            cell.image.sd_setImage(with: URL(string: urlToImage))
        }
        
        return cell
    }

}

