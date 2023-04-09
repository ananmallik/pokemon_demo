//
//  DetailViewController.swift
//  PokemonDemo
//
//  Created by A. Mallik on 09/04/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setLabels()
        
    }
    
    func setLabels() {
        
        let defaults = UserDefaults.standard
        
        self.nameLabel.text = defaults.object(forKey:"name") as? String
        
    }

}
