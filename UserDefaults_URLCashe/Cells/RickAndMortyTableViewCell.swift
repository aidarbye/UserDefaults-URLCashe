//
//  RickAndMortyTableViewCell.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var picture: CharachterImageView! {
        didSet {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
