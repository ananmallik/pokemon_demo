//
//  DetailViewController.swift
//  PokemonDemo
//
//  Created by Anan K. Mallik on 09/04/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var heightDetail: UILabel!
    @IBOutlet weak var weightDetail: UILabel!
    @IBOutlet weak var orderDetail: UILabel!
    @IBOutlet weak var baseExperienceDetail: UILabel!
    
    var detailURL = ""
    
    //Label variables:
    var name = ""
    var height = 0
    var weight = 0
    var order = 0
    var base_experience = 0
     

    override func viewDidLoad() {
        
        super.viewDidLoad()
        getURL()
        
        //Set labels with values:
        getdetailData(){
            
            self.nameLabel.text = self.name.capitalized
            self.nameDetail.text = "Name: " + self.name.capitalized
            self.heightDetail.text = "Height: " + String(self.height)
            self.weightDetail.text = "Weight: " + String(self.weight)
            self.orderDetail.text = "Order: " + String(self.order)
            self.baseExperienceDetail.text = "Base Experience: " + String(self.base_experience)
            
        }

    
    }
    
    func getURL() {
        
        let defaults = UserDefaults.standard
        self.detailURL = defaults.string(forKey:"url")!
        
    }

    func getdetailData(completed: @escaping () -> ()) {
        
        if let url = URL(string: self.detailURL) {
            
            
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                 if let jsonString = String(data: data, encoding: .utf8) {
                    let data = Data(jsonString.utf8)

                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            
                            if true {
                                
                                self.name = json["name"]! as! String
                                self.height = json["height"]! as! Int
                                self.weight = json["weight"]! as! Int
                                self.order = json["order"]! as! Int
                                self.base_experience = json["base_experience"]! as! Int
                                
                                DispatchQueue.main.async {
                                    completed()
                                }
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                 }
               }
           //Make the API Call:
           }.resume()
        }

    }
}
