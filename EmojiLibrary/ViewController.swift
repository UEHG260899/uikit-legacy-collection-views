//
//  ViewController.swift
//  EmojiLibrary
//
//  Created by Uriel Hernandez Gonzalez on 20/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiCollectionView.dataSource = dataSource
        emojiCollectionView.delegate = delegate
        emojiCollectionView.allowsMultipleSelection = true
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        emojiCollectionView.indexPathsForVisibleItems.forEach {
            guard let emojiCell = emojiCollectionView.cellForItem(at: $0) as? EmojiCell else {
                return
            }
            
            emojiCell.isEditing = editing
        }
        
        emojiCollectionView.indexPathsForSelectedItems?.compactMap({ $0 }).forEach({
            emojiCollectionView.deselectItem(at: $0, animated: true)
        })
        
        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing && identifier == "ShowEmojiDetail" {
            return false
        }
        
        return true
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
    
    @IBAction func deleteEmoji(_ sender: UIBarButtonItem) {
        guard let indexPaths = emojiCollectionView.indexPathsForSelectedItems else {
            return
        }
        
        dataSource.deleteEmojis(at: indexPaths)
        emojiCollectionView.deleteItems(at: indexPaths.reversed())
    }
}

