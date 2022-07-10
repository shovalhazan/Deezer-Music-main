//
//  HomeViewController.swift
//  Music
//
//  Created by Shoval Hazan on 08/07/2022.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
