//
//  BookViewController.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import UIKit


class BookViewController: UIViewController {
    
    
    
    // MARK: - Components
    private let searchController = UISearchController()
    private var collectionView : UICollectionView?
    private let animationDuration: Double = 0.5
    private let kDetailViewIdentifier: String = "DetailBookController"
    lazy var viewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        setupCollectionView()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar(){
        searchController.loadViewIfNeeded()
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    fileprivate func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        collectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.keyboardDismissMode = .onDrag
        view.addSubview(collectionView ?? UICollectionViewCell())
        self.collectionView?.register(UINib.init(nibName: String(describing: BookCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: "bookCell")
        setupViewModel()
    }
    
    func setupViewModel(){
        //fetch info from ebay API
        viewModel.didFetchBooks = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        viewModel.didSearchResults = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        viewModel.fetch()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        //1
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let fullHeaderItem = NSCollectionLayoutItem(layoutSize: itemSize)
        //2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullHeaderItem,
            count: 1)
        //3
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

extension BookViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getBooksCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as?
                BookCollectionViewCell else {return UICollectionViewCell()}
        
        guard let currentBook = self.viewModel.getCurrentBook(index: indexPath.item)
        else {return UICollectionViewCell()}
        cell.setupCell(with: currentBook)
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: animationDuration, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
            cell.alpha = 1
            cell.transform = .identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedBook = self.viewModel.getCurrentBook(index: indexPath.item) else {return}
        showBookInfo(selectedBook)
    }
    
    fileprivate func showBookInfo(_ selectedBook : Book) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        if let vc = storyboard.instantiateViewController(withIdentifier: kDetailViewIdentifier) as? BookDetailViewController {
            vc.book = selectedBook
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BookViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterBooks(searchCriteria: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.resetSearchFilter()
    }
}
