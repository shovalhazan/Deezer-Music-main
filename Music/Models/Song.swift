//
//  Song.swift
//  Music
//
//  Created by Shoval Hazan on 28/06/2022.
//

import Foundation

struct SongsResponse: Codable {
    let data: [Song]
}

struct Song: Codable {
    let title: String
    let album: Album
    let preview: String
}
