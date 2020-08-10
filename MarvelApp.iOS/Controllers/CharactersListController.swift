//
//  ViewController.swift
//  MarvelApp.iOS
//
//  Created by Carlos Correa on 09/08/2020.
//  Copyright © 2020 marvelinc. All rights reserved.
//

import UIKit

class CharactersListController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CharactersListViewModelDelegate {
    
    let activityView = UIActivityIndicatorView(style: .large)
    let cellIdentifier = "CharacterCell"
    private var viewModel = CharactersListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    var isFiltered: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.viewModel.delegate = self
    
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Marvel App"
    }
    
    private func setupUI() {
        self.collectionView?.autoresizesSubviews = true;
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false;
        self.collectionView?.backgroundColor = .white
        self.collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CharacterCell")
        
        self.view.addSubview(activityView)
        self.activityView.hidesWhenStopped = true
        self.activityView.center = self.view.center
        self.activityView.color = .black
        self.activityView.startAnimating()
        
        self.searchController.searchResultsUpdater = self as UISearchResultsUpdating
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Characters"
        self.searchController.searchBar.delegate = self
    
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadCharacters(searchCharacters: nil)
    }

    func charactersLoaded() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
            self.viewModel.loadingCharacters = false
            self.collectionView.reloadData()
        }
    }
}

extension CharactersListController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered {
            return viewModel.filteredCharacter.count
        }
        return viewModel.characters.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        let character: Character
        if isFiltered {
            character = viewModel.filteredCharacter[indexPath.row]
        } else {
            character = viewModel.characters[indexPath.row]
        }
        cell.configureCell(character: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(view.frame.width-30)/2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count - 10 && !viewModel.loadingCharacters && viewModel.characters.count != viewModel.total {
            viewModel.currentPage += 1
            viewModel.loadCharacters(searchCharacters: nil)
            self.activityView.startAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredCharacter: Int
        if isFiltered {
            filteredCharacter = viewModel.filteredCharacter[indexPath.row].id
        } else {
            filteredCharacter = viewModel.characters[indexPath.row].id
        }
    }
}

extension CharactersListController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchCharacter = searchBar.text!
        if !searchCharacter.isEmpty && searchCharacter.count >= 3 {
            viewModel.loadCharacters(searchCharacters: searchCharacter)
        }
        self.collectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.collectionView.reloadData()
    }
    
}

extension CharactersListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchCharacter = searchController.searchBar.text!
        if !searchCharacter.isEmpty && searchCharacter.count >= 3 {
            viewModel.loadCharacters(searchCharacters: searchCharacter)
        }
        self.collectionView.reloadData()
    }

}

