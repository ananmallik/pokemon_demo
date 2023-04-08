//
//  ViewController.swift
//  PokemonDemo
//
//  Created by Anan K. Mallik on 05/04/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var pokemons = [results]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getData{
            
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = pokemons[indexPath.row].name.capitalized
        
        return cell
    }
    
    
    func getData(completed: @escaping () -> ()) {
        
        //Initial API Endpoint:
        let urlString = "https://pokeapi.co/api/v2/pokemon/"
        let url = URL(string: urlString)
        
        guard url != nil else {
            debugPrint("URL is nil")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            //check for errors:
            if error  == nil && data != nil {
                //parse JSON:
                let decoder = JSONDecoder()
                do {
                    let pokemonFeed = try decoder.decode(Pokemon.self, from: data!)
                    self.pokemons = pokemonFeed.results
                    completed()
                    
                } catch {
                    debugPrint("Error")
                }
            }
        }
        //Make the API Call:
        dataTask.resume()
    }
}

