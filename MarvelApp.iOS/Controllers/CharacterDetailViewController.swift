//
//  CharacterDetailViewController.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 10/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UITableViewController, CharacterDetailViewModelDelegate {
    
    var indexDetails = ["","Comics", "Events", "Stories", "Series" ]
    let characterDetailCellIdentifier = "CharacterDetailCell"
    let characterHeaderCellIdentifier = "CharacterHeaderTableViewCell"
    
    let activityView = UIActivityIndicatorView(style: .large)
    public var viewModel = CharactersDetailViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel.delegate = self
    
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Character Detail"
    }
    
    private func setupUI() {
        self.tableView?.autoresizesSubviews = true;
        self.tableView?.translatesAutoresizingMaskIntoConstraints = false;
        self.tableView?.backgroundColor = .white
        self.tableView.register(UINib(nibName: "CharacterDetailTableViewCell", bundle: nil), forCellReuseIdentifier: characterDetailCellIdentifier)
        self.tableView.register(UINib(nibName: "CharacterHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: characterHeaderCellIdentifier)
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        self.view.addSubview(activityView)
        self.activityView.hidesWhenStopped = true
        self.activityView.center = self.view.center
        self.activityView.color = .black
        self.activityView.startAnimating()
        definesPresentationContext = true
        
        viewModel.loadCharacterDetail()
    }

    func characterDetailLoaded() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
}

extension CharacterDetailViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(indexDetails[section])"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comicsArray = viewModel.result?.comics.items.prefix(3)
        let eventsArray = viewModel.result?.events.items.prefix(3)
        let storiesArray = viewModel.result?.stories.items.prefix(3)
        let seriesArray = viewModel.result?.series.items.prefix(3)
        
        switch section {
            case 0:
                return 1
            case 1:
                return comicsArray?.count ?? 0
            case 2:
                return eventsArray?.count ?? 0
            case 3:
                return storiesArray?.count ?? 0
            default:
                return seriesArray?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
           return 295
        } else {
           return 160
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: characterHeaderCellIdentifier, for: indexPath) as! CharacterHeaderTableViewCell
            
            (cell as! CharacterHeaderTableViewCell).configureCell(character: viewModel.character!)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: characterDetailCellIdentifier, for: indexPath) as! CharacterDetailTableViewCell
            if let item = viewModel.result?.comics.items[indexPath.row] {
                (cell as! CharacterDetailTableViewCell).configureCell(element: item)
            }
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: characterDetailCellIdentifier, for: indexPath) as! CharacterDetailTableViewCell
            if let item = viewModel.result?.events.items[indexPath.row] {
                (cell as! CharacterDetailTableViewCell).configureCell(element: item)
            }
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: characterDetailCellIdentifier, for: indexPath) as! CharacterDetailTableViewCell
            if let item = viewModel.result?.stories.items[indexPath.row] {
                (cell as! CharacterDetailTableViewCell).configureCell(element: item)
            }
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: characterDetailCellIdentifier, for: indexPath) as! CharacterDetailTableViewCell
            if let serie = viewModel.result?.series.items[indexPath.row] {
                (cell as! CharacterDetailTableViewCell).configureCell(element: serie)
            }
        }
        
        return cell
    }
    
}

