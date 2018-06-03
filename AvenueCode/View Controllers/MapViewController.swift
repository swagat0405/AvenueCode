//
//  MapViewController.swift
//  AvenueCode
//
//  Created by Swagat Mishra on 6/2/18.
//  Copyright © 2018 Swagat Mishra. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locations: [Location]!
    
    @IBOutlet weak var saveLocationBarButton: UIBarButtonItem!
    
    var container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.locations.count > 1 {
            self.navigationItem.rightBarButtonItems = []
        }
        else {
            checkLocationInDatabase()
        }
        updateMap()
    }
    
    private func checkLocationInDatabase() {
        if let context = container?.viewContext {
            if Address.searchInDatabase(location: self.locations![0], inContext: context) > 0 {
                //Location exists in DB. Change bar button name to delete
                self.saveLocationBarButton.title = "Delete"
            }
            else {
                self.saveLocationBarButton.title = "Save"
            }
        }
    }
    
    private func updateMap() {
        mapView.removeAnnotations(mapView.annotations)
        var annotations = [MKPointAnnotation]()
        locations?.forEach({ (location) in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake((location.geometry?.location?.lat)!, (location.geometry?.location?.lng)!)
            annotation.title = location.formattedAddress
            annotation.subtitle = location.geometry?.location?.description
            annotations.append(annotation)
        })
        mapView.addAnnotations(annotations)
        if annotations.count == 1 {
            let coordinate = annotations.first!.coordinate
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
            mapView.region = region
        }
    }
    
    func showOnMap(locations: [Location]) {
        self.locations = locations
    }
    
    private func save() {
        container?.performBackgroundTask({[weak self] (context) in
            do {
                if let location = self?.locations.first {
                    try Address.addToDatabase(location: location, context: context)
                    try context.save()
                }
            } catch {
                //Perform error handling
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error!!!", message: "Unable to save the location.", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    private func delete() {
        container?.performBackgroundTask({[weak self] (context) in
            do {
                if let location = self?.locations.first {
                    try Address.delete(location: location, context: context)
                    try context.save()
                }
            } catch {
                //Perform error handling
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error!!!", message: "Unable to delete the location.", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func saveLocation(_ sender: UIBarButtonItem) {
        if sender.title == "Save" {
            save()
        }
        else if sender.title == "Delete" {
            let alert = UIAlertController(title: "Delete Location", message: "Are you sure you want to delete the location?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] (action) in
                self?.delete()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
