//
//  Artist.swift
//  Music
//
//  Created by Shoval Hazan on 01/06/2022.
//

import UIKit

struct SearchArtist: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let picture_medium: String
}

class Artist {
    var name: String?
    var image: UIImage?
    var songs: [Song]?
}

enum MyError: Error {
    case artistNotFound
}
