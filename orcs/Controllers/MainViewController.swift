//
//  ViewController.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 01.07.2022.

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var dayOfInvasionLabel: UILabel!
    @IBOutlet weak var personnelLossesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var orcsManager = OrcsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minumumDateComponents = orcsManager.minimumInfoDateComponents()
        orcsManager.delegate = self
        orcsManager.getData(for: minumumDateComponents)
        
        
        let maximumDate = orcsManager.maximumInfoDate()
        let minumumDate = orcsManager.minimumInfoDate()
        
// Date Picker:
        datePicker.date = minumumDate
        datePicker.maximumDate = maximumDate
        // Date Picker request; Updating UI data
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
// Collectiong View:
        collectionView.register(CollectionViewCell.nib() , forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

//MARK: - UIDatePicker (concrete extension)

extension MainViewController {
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let date = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        orcsManager.getData(for: date)
    }
}


//MARK: - OrcsManagerDelegate
extension MainViewController: OrcsManagerDelegate {
    
    func didUpdateOrcsLossesInfo(_ orcsLossesInfo: (Personnel, [Equipment])) {
      //  self.orcsLossesInfo = orcsLossesInfo.1
        dayOfInvasionLabel.text = orcsLossesInfo.0.stringDay
        personnelLossesLabel.text = orcsLossesInfo.0.stringAmount
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}


//MARK: - UICollectionView

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // need to save index for transfering the precise data
        orcsManager.idForSelectedCard = indexPath.item
        
   //     print(orcsLossesInfo![Int(indexPath.item)])
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goToDetailsScreen", sender: nil)
        }
        
    }
    
}


extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // (Personnel, [Equipment])
        return orcsManager.infoForChosenDay!.1.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.configure(with: orcsManager.infoForChosenDay!.1[indexPath.row])

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

//MARK: - Segue

extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsScreen" {
            let destinationVC = segue.destination as! DetailsViewController
            if let elementId = orcsManager.idForSelectedCard {
                
                // (Personnel, [Equipment])
                destinationVC.detailsManager.nameOfSubject = orcsManager.infoForChosenDay?.1[elementId].title
                destinationVC.detailsManager.numberOfLosses = orcsManager.infoForChosenDay?.1[elementId].stringAmount
                destinationVC.detailsManager.subjectImage = orcsManager.infoForChosenDay?.1[elementId].image
            }
            
        }
    }
}
