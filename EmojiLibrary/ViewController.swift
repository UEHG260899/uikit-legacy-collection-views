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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowEmojiDetail",
              let emojiCell = sender as? EmojiCell,
              let emojiDetailController = segue.destination as? EmojiDetailController,
              let indexPath = emojiCollectionView.indexPath(for: emojiCell),
              let emoji = Emoji.shared.emoji(at: indexPath) else {
            return
        }
        
        emojiDetailController.emoji = emoji
    }

    @IBAction func addEmoji(_ sender: UIBarButtonItem) {
        let (category, randomEmoji) = Emoji.randomEmoji()
        dataSource.addEmoji(randomEmoji, to: category)
        
        
        let emojiCount = emojiCollectionView.numberOfItems(inSection: 0)
        let insertedIndex = IndexPath(item: emojiCount, section: 0)
        
        
        emojiCollectionView.insertItems(at: [insertedIndex])
    }
    
}

