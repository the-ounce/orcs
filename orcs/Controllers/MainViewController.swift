//
//  ViewController.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var personnelLossesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var orcsManager = OrcsManager()
    var orcsLossesInfo: [Equipment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orcsManager.delegate = self
        orcsManager.getData()

        
        collectionView.register(CollectionViewCell.nib() , forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }

    
}
//MARK: - OrcsManagerDelegate
extension MainViewController: OrcsManagerDelegate {
    
    func didUpdateOrcsLossesInfo(_ orcsLossesInfo: (Personnel, [Equipment])) {
        self.orcsLossesInfo = orcsLossesInfo.1
        personnelLossesLabel.text = orcsLossesInfo.0.stringAmount
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        
    }
}


//MARK: - UICollectionView

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You Tapped me!")
    }
    
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orcsLossesInfo!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.configure(with: orcsLossesInfo![indexPath.row])

        return cell
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        let collectionHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth - 20, height: collectionHeight / 3)
    }
    
}

