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

extension DataSource {
    func addEmoji(_ emoji: String, to category: Emoji.Category) {
        guard var emojiData = self.emojiData.data[category] else {
            return
        }
        
        emojiData.append(emoji)
        self.emojiData.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmojis(at indexPaths: [IndexPath]) {
        let sections = indexPaths.map({ $0.section })
        let sectionsSet = Set(sections)
        
        for (_, section) in sectionsSet.enumerated().sorted(by: >) {
            let category = emojiData.sections[section]
            guard var emojiData = emojiData.data[category] else {
                return
            }

            let indices = indexPaths.filter({ $0.section == section }).map({ $0.item })
            for idx in indices.reversed() {
                emojiData.remove(at: idx)
                self.emojiData.data.updateValue(emojiData, forKey: category)
            }

        }
    }
}
