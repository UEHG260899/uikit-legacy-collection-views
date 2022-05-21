//
//  DataSiurce.swift
//  EmojiLibrary
//
//  Created by Uriel Hernandez Gonzalez on 20/05/22.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
    
    let emojiData = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        emojiData.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = emojiData.sections[section]
        let emojis = emojiData.data[category]
        
        return emojis?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let emojiCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiCell.reuseIdentifier,
            for: indexPath) as? EmojiCell else {
            fatalError("Cell cannot be created")
        }
        
        let category = emojiData.sections[indexPath.section]
        let emoji = emojiData.data[category]?[indexPath.item] ?? ""
        
        emojiCell.emojiLabel.text = emoji
        
        return emojiCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let emojiHederView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: EmojiHeaderView.reuseIdentifier,
                                                                                   for: indexPath) as? EmojiHeaderView else {
            fatalError("Cannot create EmojiHeaderView")
        }
        
        emojiHederView.headerTitleLabel.text = emojiData.sections[indexPath.section].rawValue
        
        return emojiHederView
    }
}
