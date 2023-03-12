//
//  CasheTableViewController.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import UIKit

class CasheTableViewController: UITableViewController {
    private var rickAndMorty: RickAndMorty?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        fetchData(from: URLS.rickandmortyapi.rawValue)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "url_cell", for: indexPath) as! RickAndMortyTableViewCell
        if let results = rickAndMorty?.results[indexPath.row] {
            print(results.image)
            cell.configure(with: results)
        }
        return cell
    }
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.tableView.reloadData()
        }
    }
}
