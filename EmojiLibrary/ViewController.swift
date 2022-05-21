//
//  ViewController.swift
//  EmojiLibrary
//
//  Created by Uriel Hernandez Gonzalez on 20/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiCollectionView.dataSource = dataSource
        emojiCollectionView.delegate = delegate
    }


}

