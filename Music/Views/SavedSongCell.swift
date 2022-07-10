//
//  SavedSongCell.swift
//  Music
//
//  Created by Shoval Hazan on 01/06/2022.
//

import UIKit

class SavedSongCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var currentSong: CoreSong?
    var refreshDelegate: RefreshDelegate?
    
    func setUpElements() {
        coverImage.layer.cornerRadius = 5
        coverImage.layer.masksToBounds = true
    }
    
    @IBAction func heartTapped(_ sender: UIButton) {
        CoreDB.shared.removeSong(currentSong)
        refreshDelegate?.refresh()
    }
}
