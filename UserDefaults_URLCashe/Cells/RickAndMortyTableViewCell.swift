//
//  RickAndMortyTableViewCell.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {

    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var picture: CharachterImageView! {
        didSet {
            picture.contentMode = .scaleAspectFit
            picture.clipsToBounds = true
            picture.layer.cornerRadius = picture.bounds.height / 2
        }
    }
    func configure(with result: Result?) {
        nameTextLabel.text = result?.name
        if let imageURL = result?.image {
            picture.fetchImage(from: imageURL)
        }
    }

}
