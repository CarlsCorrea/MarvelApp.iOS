//
//  CharacterDetailTableViewCell.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell, ComicViewModelDelegate {

    func comicLoaded() {
        DispatchQueue.main.async {
            if let labelDesc = self.labelDescription.text {
                if (labelDesc.isEmpty) {
                    self.labelDescription.text = self.comicViewModel.comic?.description
                }
            }
        }
    }

    public var comicViewModel = ComicViewModel()
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(element:ComicResource){
        
        self.comicViewModel.delegate = self
        self.comicViewModel.comicUrl = element.resourceURI

        if (self.labelDescription.text == "") {
            self.comicViewModel.loadComicInfo()
        }
        labelName.text = element.name
    }
    
}
