//
//  Protocols.swift
//  Music
//
//  Created by Shoval Hazan on 01/06/2022.
//

import Foundation

protocol PlaylistDelegate {
    func nextTrack(_ index: Int) -> Int
    func prevTrack(_ index: Int) -> Int
}

protocol RefreshDelegate {
    func refresh()
}
