//
//  SongCell.swift
//  Music
//
//  Created by Shoval Hazan on 28/06/2022.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUpElements() {
        coverImage.layer.cornerRadius = 5
        coverImage.layer.masksToBounds = true
    }
}
