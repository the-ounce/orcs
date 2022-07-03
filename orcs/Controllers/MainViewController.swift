//
//  ViewController.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var orcsManager = OrcsManager()
    var orcsLossesInfo: [Equipment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orcsManager.delegate = self
        orcsManager.getData()

//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 150, height: 150)
//
//        collectionView.collectionViewLayout = layout
        
        collectionView.register(CollectionViewCell.nib() , forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }

    
    

    @IBAction func goButtonPressed(_ sender: Any) {
        orcsManager.getData()
    }
    

    
}
//MARK: - OrcsManagerDelegate
extension MainViewController: OrcsManagerDelegate {
    
    func didUpdateOrcsLossesInfo(_ orcsLossesInfo: [Equipment]) {
        self.orcsLossesInfo = orcsLossesInfo
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
        return CGSize(width: collectionWidth - 20, height: collectionHeight / 5)
    }
    
}

