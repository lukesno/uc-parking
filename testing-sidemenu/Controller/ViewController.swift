//
//  ViewController.swift
//  testing-annotation
//
//  Created by Luke Son on 2020-01-08.
//  Copyright © 2020 Luke Son. All rights reserved.
//

import Mapbox
import UIKit
import MapboxAnnotationExtension
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

// Example view controller
class ViewController: UIViewController, MGLMapViewDelegate, MGLCalloutViewDelegate {
    
 

    @IBOutlet weak var legendButton: UIButton!
    var mapView: NavigationMapView!
    var polygonAnnotationController : MGLPolygonAnnotationController!
    var directionsRoute: Route?
    var navigateButton: UIButton!
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //Allow map view to display user's location
        mapView = NavigationMapView(frame: view.bounds)
        mapView.showsUserLocation = true
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.darkStyleURL
        mapView.setCenter(CLLocationCoordinate2D(latitude: 51.077624, longitude:  -114.136868), zoomLevel: 11, animated: false)
        
        view.addSubview(mapView)
    
        // Add button on top of map
        let margins = view.layoutMarginsGuide
        
//        legendButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant:15).isActive = true
//        legendButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 54)
//        legendButton.widthAnchor.constraint(equalToConstant: 700).isActive = true
//        legendButton.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        
        legendButton.layer.cornerRadius = 10
        legendButton.clipsToBounds = true
        self.view.addSubview(legendButton)
        
        // Add a point for university
        let university = MGLPointAnnotation()
        university.coordinate = CLLocationCoordinate2D(latitude: 51.077550, longitude:  -114.140709)
        university.title = "University of Calgary"
        mapView.addAnnotation(university)
        
        //Set up so that we can set up a delegate method to return a callout when user taps on annotation
        mapView.delegate = self
        
        addButton()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertMessage()
    }

    //Delegate method to zoom into marker (annotation) when tapped, and logs longitude and latitude of location for navigation feature
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 4500, pitch: 15, heading: 0) //Heading 0 makes rotation degrees clock wise from true north 0
        
        latitude = annotation.coordinate.latitude
        longitude = annotation.coordinate.longitude
        
        calculateRoute(from: mapView.userLocation!.coordinate, to: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) { (route, error) in
            if error != nil {
                print("error getting route")
            }
        }
//        mapView.fly(to: camera, withDuration: 4, peakAltitude: 3000, completionHandler: nil)
    }
    

    
    func alertMessage(){
        let alert = UIAlertController(title: "Disclaimer Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

    }

    
}

//MARK: - Making circle annotations and callout functionality
extension ViewController {
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
      polygonAnnotationController = MGLPolygonAnnotationController(mapView: self.mapView)
        
        showAnnotation() //Showing annotation from Database.swift

    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true;
    }

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return MGLAnnotationView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    //Changes highlight color when annotation is selected
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }

}





var message = "UC Parking is in no way affiliated, sponsored or partnered with the University Of Calgary, or any of its entities. The information contained on UC Parking app (the Service) is for general information purposes only. The creators behind UC Parking assumes no responsibility for errors or omissions in the contents on the Service. In no event shall UC Parking be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever, whether in an action of contract, negligence or other tort, arising out of or in connection with the use of the Service or the contents of the Service. UC Parking reserves the right to make additions, deletions, or modification to the contents on the Service at any time without prior notice. UC Parking app may contain links to external websites that are not provided or maintained by or in any way affiliated with UC Parking Please note that the UC Parking does not guarantee the accuracy, relevance, timeliness, or completeness of any information on these external websites."
