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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(character:Character){
        labelName.text = character.name
        imageCharacter.loadImageUsingCache(withUrl: character.thumbnail.url)
        imageCharacter.contentMode = .scaleToFill
        imageCharacter.makeRounded()
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
