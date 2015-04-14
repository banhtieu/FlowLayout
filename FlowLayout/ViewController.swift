//
//  ViewController.swift
//  FlowLayout
//
//  Created by Tran Thien Khiem on 4/14/15.
//  Copyright (c) 2015 Tran Thien Khiem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, FlowCollectionViewLayoutDelegate {

    // test with 5 sections
    var sections = 5
    
    // data for each sections
    var data = [
        UIImage(named: "image0")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
    ]
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? FlowCollectionViewLayout {
            layout.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // get the image size
    func sizeForCellAtIndexPath(indexPath: NSIndexPath) -> CGSize {
        let image = data[indexPath.row]
        return image.size
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sections
    }

    // return count
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    // return the cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let image = data[indexPath.row]
        let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as ImageCollectionViewCell
        imageCell.image.image = image
        return imageCell
    }

}

