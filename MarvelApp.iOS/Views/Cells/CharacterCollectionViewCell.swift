//
//  CharacterCollectionViewCell.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageFavorite: UIImageView!
    var character:Character?
    var favorite=false
    var characterId=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(character:Character){
        
        self.character = character
        self.characterId = String(self.character!.id)
        
        self.favorite = UserDefaults.standard.bool(forKey: self.characterId)
        
        if (self.favorite) {
            imageFavorite.image = UIImage(named: "favoriteTrue")
        } else {
            imageFavorite.image = UIImage(named: "favoriteFalse")
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageFavorite.isUserInteractionEnabled = true
        imageFavorite.addGestureRecognizer(tapGestureRecognizer)
        
        labelName.text = character.name
        imageCharacter.loadImageUsingCache(withUrl: character.thumbnail.url)
        imageCharacter.contentMode = .scaleToFill
        imageCharacter.makeRounded()
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

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
