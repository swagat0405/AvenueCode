//
//  GoogleAPILocationsHomeViewController.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import UIKit

class GoogleAPILocationsHomeViewController: UIViewController {

    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var locationSearchResults = [Location]()
    
    var noResultsLabel: UILabel! {
        didSet {
            noResultsLabel.text = "No Results Found."
            noResultsLabel.textColor     = UIColor.red
            noResultsLabel.textAlignment = .center
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noResultsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (self.resultsTableView.bounds.size.width), height: (self.resultsTableView.bounds.size.height)))
    }
    
    private func search(location: String) {
        NetworkManager().search(location: location) {[weak self] (locations) in
            print(locations)
            self?.locationSearchResults = locations
            DispatchQueue.main.async {
                if locations.count == 0 {
                    //Display No results message
                    self?.resultsTableView.backgroundView = self?.noResultsLabel
                }
                else {
                    self?.resultsTableView.backgroundView = nil
                }
                self?.resultsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            if segue.identifier == "DisplayLocationSegue" {
                destination.showOnMap(locations: [self.locationSearchResults[(self.resultsTableView.indexPathForSelectedRow?.row)!]])
            }
            else {
                destination.showOnMap(locations: self.locationSearchResults)
            }
            self.resultsTableView.deselectRow(at: self.resultsTableView.indexPathForSelectedRow!, animated: false)
        }
    }

}

extension GoogleAPILocationsHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let location = searchBar.text{
            if !location.isEmpty {
                search(location: location)
            }
            else {
                self.locationSearchResults.removeAll()
                self.resultsTableView.backgroundView = nil
                self.resultsTableView.reloadData()
            }
        }
    }
}

extension GoogleAPILocationsHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.locationSearchResults.count > 1) ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.locationSearchResults.count > 0 {
            switch section {
            case 0:
                return 1
            case 1:
                return self.locationSearchResults.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.locationSearchResults.count > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayAllOnMapCellIdentifier")
                cell?.textLabel?.text = "Display all on Map"
                return cell!
            }
            else { fallthrough }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCellIdentifier")
            cell?.textLabel?.text = self.locationSearchResults[indexPath.row].formattedAddress
            return cell!
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
