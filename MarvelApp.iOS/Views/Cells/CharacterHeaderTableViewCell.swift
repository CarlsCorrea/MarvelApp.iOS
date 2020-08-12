//
//  CharacterHeaderTableViewCell.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 11/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import UIKit

class CharacterHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    var favorite=false
    var characterId=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(character:Character){
        
        self.characterId = String(character.id)
        self.favorite = UserDefaults.standard.bool(forKey: self.characterId)
        
        if (self.favorite) {
            favoriteImage.image = UIImage(named: "favoriteTrue")
        } else {
            favoriteImage.image = UIImage(named: "favoriteFalse")
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tapGestureRecognizer)
                
        characterLabel.text = character.name
        characterImage.loadImageUsingCache(withUrl: character.thumbnail.url)
        characterImage.contentMode = .scaleToFill
        characterImage.makeRounded()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        self.favorite = UserDefaults.standard.bool(forKey: self.characterId)
        if (self.favorite) {
            tappedImage.image = UIImage(named: "favoriteFalse")
            UserDefaults.standard.set(false, forKey: self.characterId)
            UserDefaults.standard.synchronize()
        } else {
            tappedImage.image = UIImage(named: "favoriteTrue")
            UserDefaults.standard.set(true, forKey: self.characterId)
            UserDefaults.standard.synchronize()
        }
        
    }
    
}

