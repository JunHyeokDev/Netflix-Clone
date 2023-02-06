//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/24.
//

import UIKit


protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewContollerDidtapItem(_ viewModel : TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var titles : [Title] = []

    public weak var delegate : SearchResultViewControllerDelegate? // Optional cuz i dont wwanna init it rn
    
    public let searchResultCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }


}


extension SearchResultsViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .blue
        let title = titles[indexPath.row]
        
        cell.configure(with: title.poster_path ?? "")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                    self?.delegate?.searchResultViewContollerDidtapItem(TitlePreviewViewModel(title: title.original_name ?? "", youtubeView: videoElement, titleOverview: title.overview ?? ""))
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
