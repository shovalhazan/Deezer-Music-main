//
//  SearchController.swift
//  Music
//
//  Created by Shoval Hazan on 01/06/2022.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    @IBOutlet weak var topStackHeight: NSLayoutConstraint!
    @IBOutlet weak var artistImageHeight: NSLayoutConstraint!
    @IBOutlet weak var artistImageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var songsCV: UICollectionView!
    
    var artist: Artist?
    var playerController: PlayerController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        playerController = storyboard?.instantiateViewController(identifier: "PlayerVC")
    }
    
    private func setUpElements() {
        topStackView.alpha = 0
        bottomStackView.alpha = 0
        artistImage.layer.cornerRadius = artistImage.frame.height / 2
        artistImage.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension SearchController: PlaylistDelegate {
    func nextTrack(_ index: Int) -> Int {
        let index = (index == (artist?.songs?.count ?? 0) - 1) ? 0 : index + 1
        playerController.song = artist?.songs?[index]
        return index
    }
    
    func prevTrack(_ index: Int) -> Int {
        let index = (index == 0) ? ((artist?.songs?.count ?? 0) - 1) : index - 1
        playerController.song = artist?.songs?[index]
        return index
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(artist?.songs?.count ?? 0)
        return artist?.songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.setUpElements()
        
        let song = artist?.songs?[indexPath.row]
        
        cell.titleLabel.text = song?.title
        if let urlString = song?.album.cover_medium {
            MusicDataProvider.shared.downloadImage(from: urlString) { (image) in
                cell.coverImage.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        playerController.artist = artist
        playerController.song = artist?.songs?[indexPath.item]
        playerController.index = indexPath.item
        playerController.playlistDelegate = self
        
        present(playerController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 10 {
            topStackHeight.constant = 200
            topStackView.axis = .vertical
            topStackView.spacing = 8
            artistImageHeight.constant = 160
            artistImageWidth.constant = 160
            
            UIView.animate(withDuration: 0.5) {
                self.artistImage.layer.cornerRadius = 80
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        topStackHeight.constant = 50
        topStackView.axis = .horizontal
        topStackView.spacing = 24
        artistImageHeight.constant = 50
        artistImageWidth.constant = 50
        
        UIView.animate(withDuration: 0.5) {
            self.artistImage.layer.cornerRadius = 25
            self.view.layoutIfNeeded()
        }
    }
}


extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, searchText != "" else { return }
        
        MusicDataProvider.shared.artistSearch(searchText: searchText) { (artist, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.artistName.text = "Artist not found.. 🤷‍♀️"
                    self.artistImage.alpha = 0
                    self.topStackView.alpha = 1
                    self.bottomStackView.alpha = 0
                }
                
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.artist = artist
                self.artistImage.image = artist?.image
                self.artistName.text = artist?.name
                
                self.topStackView.alpha = 1
                self.bottomStackView.alpha = 1
                self.artistImage.alpha = 1
                
                self.songsCV.reloadData()
            }
        }
    }
}
