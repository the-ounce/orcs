//
//  DetailsViewController.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 04.07.2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var detailsManager = DetailsManager()
    var orcsManager = OrcsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(detailsManager.nameOfSubject!):"
        amountLabel.text = detailsManager.numberOfLosses
        imageView.image = UIImage(named: detailsManager.subjectImage!)
        
        textView.text = detailsManager.getDetailsText()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
