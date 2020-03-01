//
//  Database.swift
//  testing-annotation
//
//  Created by Luke Son on 2020-01-19.
//  Copyright © 2020 Luke Son. All rights reserved.
//

import Foundation
import Mapbox
import MapboxAnnotationExtension
import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

extension ViewController { //Placed in annotation data placed in Database.swift, and navigation functionality
    

    
    //Add navigation button
    func addButton(){
        
        navigateButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 75, y: view.frame.height - 80, width: 150, height: 50))
        navigateButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigateButton.setTitle("Navigate", for: .normal)
        navigateButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        navigateButton.addTarget(self, action: #selector(navigateButtonWasPressed(_ :)), for: .touchUpInside)
        navigateButton.layer.cornerRadius = 25
        
        view.addSubview(navigateButton)
    }
    
    @objc func navigateButtonWasPressed(_ sender: UIButton) {
           mapView.setUserTrackingMode(.none, animated: true)
           
        if let direction = directionsRoute{
            let navigationVC = NavigationViewController(for: directionsRoute!)
            present(navigationVC, animated: true, completion: nil)
        }
        else {
            print("please select a map!")
        }
        
    }
    
    
    func calculateRoute(from originCoor: CLLocationCoordinate2D, to destinationCoor: CLLocationCoordinate2D, completion: (Route?, Error?) -> Void) {
            let origin = Waypoint(coordinate: originCoor, coordinateAccuracy: -1, name: "Start")
            let destination = Waypoint(coordinate: destinationCoor, coordinateAccuracy: -1, name: "Finish")
    
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic) //automobile makes it so that route is for car
        _ = Directions.shared.calculate(options, completionHandler: { (waypoints, routes, error) in
            self.directionsRoute = routes?.first
            //draw line to show direction
            self.drawRoute(route: self.directionsRoute!)
            
            //zooms out map to showcase area that is relavant to user location and destination
//            let coordinateBounds = MGLCoordinateBounds(sw: destinationCoor, ne: originCoor)
//            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
//            let routeCam = self.mapView.cameraThatFitsCoordinateBounds(coordinateBounds, edgePadding: insets)
//            self.mapView.setCamera(routeCam, animated: true)
        })
        
    }
    
    
    func drawRoute(route: Route) {
        guard route.coordinateCount > 0 else {return}
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
        
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(mglJSONObject: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
            lineStyle.lineWidth = NSExpression(mglJSONObject: 4.0)
            
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
    }
    
    

    

    
    func showAnnotation() {

                /*          No Limit            */
                let montegomeryCoordinates = [
                    CLLocationCoordinate2DMake(51.081518, -114.164428),
                    CLLocationCoordinate2DMake(51.081257, -114.155670),
                    CLLocationCoordinate2DMake(51.079358, -114.153003),
                    CLLocationCoordinate2DMake(51.068202, -114.153688),
                    CLLocationCoordinate2DMake(51.074098, -114.164442),
                    CLLocationCoordinate2DMake(51.081518, -114.164428)
                ]
                
                let montegomery = MGLPolygonStyleAnnotation(coordinates: montegomeryCoordinates, count: UInt(montegomeryCoordinates.count))
                montegomery.fillColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                montegomery.fillOutlineColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.4196078431, alpha: 1)
                montegomery.fillOpacity = 0.3
                montegomery.title = "Free Parking"
                montegomery.subtitle = "No limit"
                polygonAnnotationController.addStyleAnnotation(montegomery)
                
                
                let triwoodCoordinates = [
                    CLLocationCoordinate2DMake(51.082881, -114.112538),
                    CLLocationCoordinate2DMake(51.082101, -114.111853),
                    CLLocationCoordinate2DMake(51.082443, -114.110730),
                    CLLocationCoordinate2DMake(51.081739, -114.109985),
                    CLLocationCoordinate2DMake(51.082006, -114.108950),
                    
                    CLLocationCoordinate2DMake(51.081945, -114.108911),
                    CLLocationCoordinate2DMake(51.081641, -114.110002),
                    CLLocationCoordinate2DMake(51.082307, -114.110775),
                    CLLocationCoordinate2DMake(51.082029, -114.111915),
                    CLLocationCoordinate2DMake(51.082881, -114.112538)
                ]
                
                let triwood = MGLPolygonStyleAnnotation(coordinates: triwoodCoordinates, count: UInt(triwoodCoordinates.count))
                triwood.fillColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                triwood.fillOutlineColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.4196078431, alpha: 1)
                triwood.fillOpacity = 0.3
                triwood.title = "Free Parking"
                triwood.subtitle = "No limit"
                polygonAnnotationController.addStyleAnnotation(triwood)
                
                
                let brentwoodSmallCoordinates = [
                    CLLocationCoordinate2DMake(51.093024, -114.127334),
                    CLLocationCoordinate2DMake(51.094369, -114.125859),
                    CLLocationCoordinate2DMake(51.093084, -114.122768),
                    CLLocationCoordinate2DMake(51.091643, -114.124348),
                    CLLocationCoordinate2DMake(51.093003, -114.127394),

                ]
                
                let brentwoodSmall = MGLPolygonStyleAnnotation(coordinates: brentwoodSmallCoordinates, count: UInt(brentwoodSmallCoordinates.count))
                brentwoodSmall.fillColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                brentwoodSmall.fillOutlineColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.4196078431, alpha: 1)
                brentwoodSmall.fillOpacity = 0.3
                brentwoodSmall.title = "Free Parking"
                brentwoodSmall.subtitle = "No limit"
                polygonAnnotationController.addStyleAnnotation(brentwoodSmall)

                
                /*          City Free   (ex brentwood lrt)      */
                let brentwoodLRTCoordinates = [
                    CLLocationCoordinate2DMake(51.085374, -114.129624),
                    CLLocationCoordinate2DMake(51.084897, -114.131586),
                    CLLocationCoordinate2DMake(51.085497, -114.132714),
                    CLLocationCoordinate2DMake(51.086056, -114.132778),
                    CLLocationCoordinate2DMake(51.086898, -114.134387),
                    CLLocationCoordinate2DMake(51.087397, -114.133775),
                    CLLocationCoordinate2DMake(51.087229, -114.133314),
                    CLLocationCoordinate2DMake(51.086959, -114.133271),
                    CLLocationCoordinate2DMake(51.086362, -114.131938),
                    CLLocationCoordinate2DMake(51.086409, -114.131493),
                    CLLocationCoordinate2DMake(51.085374, -114.129624)

                    

                ]
                
                let brentwoodLRT = MGLPolygonStyleAnnotation(coordinates: brentwoodLRTCoordinates, count: UInt(brentwoodLRTCoordinates.count))
                brentwoodLRT.fillColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                brentwoodLRT.fillOutlineColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                brentwoodLRT.fillOpacity = 0.3
                brentwoodLRT.title = "Free Parking"
                brentwoodLRT.subtitle = "Brentwood LRT"
                polygonAnnotationController.addStyleAnnotation(brentwoodLRT)
                
                
                /*          2 Hours Free         */
                let uniheightsCoordinates = [
                    CLLocationCoordinate2DMake(51.070596, -114.140493),
                    CLLocationCoordinate2DMake(51.070630, -114.137886),
                    CLLocationCoordinate2DMake(51.069288, -114.137918),
                    CLLocationCoordinate2DMake(51.068991, -114.139002),
                    CLLocationCoordinate2DMake(51.070521, -114.139002),
                    CLLocationCoordinate2DMake(51.070494, -114.140289), //
                    CLLocationCoordinate2DMake(51.068296, -114.140214),
                    CLLocationCoordinate2DMake(51.068296, -114.140439),
                    CLLocationCoordinate2DMake(51.070596, -114.140493)

                ]
                
                let uniheights = MGLPolygonStyleAnnotation(coordinates: uniheightsCoordinates, count: UInt(uniheightsCoordinates.count))
                uniheights.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                uniheights.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                uniheights.fillOpacity = 0.3
                uniheights.title = "Free Parking"
                uniheights.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(uniheights)
                

                let cathedralCoordinates = [
                    CLLocationCoordinate2DMake(51.081407, -114.119531),
                    CLLocationCoordinate2DMake(51.080248, -114.120936),
                    CLLocationCoordinate2DMake(51.079729, -114.120560),
                    CLLocationCoordinate2DMake(51.079742, -114.118629),
                    CLLocationCoordinate2DMake(51.080288, -114.118554),
                    CLLocationCoordinate2DMake(51.080706, -114.118060),
                    CLLocationCoordinate2DMake(51.081407, -114.119531)

                ]
                
                let cathedral = MGLPolygonStyleAnnotation(coordinates: cathedralCoordinates, count: UInt(cathedralCoordinates.count))
                cathedral.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                cathedral.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                cathedral.fillOpacity = 0.3
                cathedral.title = "Free Parking"
                cathedral.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(cathedral)
                
                
                let banfftrailCoordinates = [
                    CLLocationCoordinate2DMake(51.077041, -114.117926),
                    CLLocationCoordinate2DMake(51.076995, -114.112916),
                    CLLocationCoordinate2DMake(51.074691, -114.112914),
                    CLLocationCoordinate2DMake(51.074704, -114.117813),
                    CLLocationCoordinate2DMake(51.077041, -114.117926)

                ]
                
                let banfftrail = MGLPolygonStyleAnnotation(coordinates: banfftrailCoordinates, count: UInt(banfftrailCoordinates.count))
                banfftrail.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                banfftrail.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                banfftrail.fillOpacity = 0.3
                banfftrail.title = "Free Parking"
                banfftrail.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(banfftrail)
                
                
                let mallfrontCoordinates = [
                    CLLocationCoordinate2DMake(51.083894, -114.150467),
                    CLLocationCoordinate2DMake(51.083891, -114.147566),
                    CLLocationCoordinate2DMake(51.082214, -114.146954),
                    CLLocationCoordinate2DMake(51.082228, -114.142070),
                    CLLocationCoordinate2DMake(51.081992, -114.142059),
                    CLLocationCoordinate2DMake(51.082092, -114.149512),
                    CLLocationCoordinate2DMake(51.083894, -114.150467)

                ]
                
                let mallfront = MGLPolygonStyleAnnotation(coordinates: mallfrontCoordinates, count: UInt(mallfrontCoordinates.count))
                mallfront.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                mallfront.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                mallfront.fillOpacity = 0.3
                mallfront.title = "Free Parking"
                mallfront.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(mallfront)
                
                
                let smartCoordinates = [
                    CLLocationCoordinate2DMake(51.087137, -114.139053),
                    CLLocationCoordinate2DMake(51.084199, -114.139053),
                    CLLocationCoordinate2DMake(51.084172, -114.134279),
                    CLLocationCoordinate2DMake(51.084300, -114.134311),
                    CLLocationCoordinate2DMake(51.084342, -114.138826),
                    CLLocationCoordinate2DMake(51.087139, -114.138805),
                    CLLocationCoordinate2DMake(51.087137, -114.139053)

                ]
                
                let smart = MGLPolygonStyleAnnotation(coordinates: smartCoordinates, count: UInt(smartCoordinates.count))
                smart.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                smart.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                smart.fillOpacity = 0.3
                smart.title = "Free Parking"
                smart.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(smart)
                
                
                let coopCoordinates = [
                    CLLocationCoordinate2DMake(51.089244, -114.132681),
                    CLLocationCoordinate2DMake(51.092021, -114.128510),
                    CLLocationCoordinate2DMake(51.090547, -114.125401),
                    CLLocationCoordinate2DMake(51.089899, -114.126879),
                    CLLocationCoordinate2DMake(51.087531, -114.126188),
                    CLLocationCoordinate2DMake(51.087359, -114.127748),
                    CLLocationCoordinate2DMake(51.088884, -114.128493),
                    CLLocationCoordinate2DMake(51.090012, -114.130972),
                    CLLocationCoordinate2DMake(51.089244, -114.132681)

                ]
                
                let coop = MGLPolygonStyleAnnotation(coordinates: coopCoordinates, count: UInt(coopCoordinates.count))
                coop.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                coop.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                coop.fillOpacity = 0.3
                coop.title = "Free Parking"
                coop.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(coop)
                
                
                let charleswoodCoordinates = [
                    CLLocationCoordinate2DMake(51.078083, -114.118093),
                    CLLocationCoordinate2DMake(51.085601, -114.118150),
                    CLLocationCoordinate2DMake(51.086790, -114.119984),
                    CLLocationCoordinate2DMake(51.086938, -114.119780),
                    CLLocationCoordinate2DMake(51.085725, -114.117774),
                    CLLocationCoordinate2DMake(51.078373, -114.117799),
                    CLLocationCoordinate2DMake(51.078083, -114.118093)

                ]
                
                let charleswood = MGLPolygonStyleAnnotation(coordinates: charleswoodCoordinates, count: UInt(charleswoodCoordinates.count))
                charleswood.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                charleswood.fillOutlineColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                charleswood.fillOpacity = 0.3
                charleswood.title = "Free Parking"
                charleswood.subtitle = "2 Hours"
                polygonAnnotationController.addStyleAnnotation(charleswood)
                
                
                /*          1 Hour Free           */
        //        let ave32Coordinates = [
        //            CLLocationCoordinate2DMake(51.077041, -114.117926),
        //            CLLocationCoordinate2DMake(51.076995, -114.112916),
        //            CLLocationCoordinate2DMake(51.074691, -114.112914),
        //            CLLocationCoordinate2DMake(51.074704, -114.117813),
        //            CLLocationCoordinate2DMake(51.077041, -114.117926)
        //
        //        ]
        //
        //        let ave32 = MGLPolygonStyleAnnotation(coordinates: ave32Coordinates, count: UInt(ave32Coordinates.count))
        //        ave32.fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        //        ave32.fillOutlineColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        //        ave32.fillOpacity = 0.3
        //        ave32.title = "Free Parking"
        //        ave32.subtitle = "1 Hours"
        //        polygonAnnotationController.addStyleAnnotation(ave32)
                
                
                let varalRDCoordinates = [
                    CLLocationCoordinate2DMake(51.083884, -114.143809),
                    CLLocationCoordinate2DMake(51.083857, -114.141320),
                    CLLocationCoordinate2DMake(51.083736, -114.141320),
                    CLLocationCoordinate2DMake(51.083756, -114.143766),
                    CLLocationCoordinate2DMake(51.083884, -114.143809)

                ]
                
                let varalRD = MGLPolygonStyleAnnotation(coordinates: varalRDCoordinates, count: UInt(varalRDCoordinates.count))
                varalRD.fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                varalRD.fillOutlineColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                varalRD.fillOpacity = 0.3
                varalRD.title = "Free Parking"
                varalRD.subtitle = "1 Hour"
                polygonAnnotationController.addStyleAnnotation(varalRD)
                
                
                let canmoreparkCoordinates = [
                    CLLocationCoordinate2DMake(51.081543, -114.115001),
                    CLLocationCoordinate2DMake(51.077277, -114.106468),
                    CLLocationCoordinate2DMake(51.077095, -114.106511),
                    CLLocationCoordinate2DMake(51.081419, -114.115375),
                    CLLocationCoordinate2DMake(51.081543, -114.115001)

                ]

                let canmorepark = MGLPolygonStyleAnnotation(coordinates: canmoreparkCoordinates, count: UInt(canmoreparkCoordinates.count))
                canmorepark.fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                canmorepark.fillOutlineColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                canmorepark.fillOpacity = 0.3
                canmorepark.title = "Free Parking"
                canmorepark.subtitle = "1 Hour"
                polygonAnnotationController.addStyleAnnotation(canmorepark)
                
                
                /*          4 Hour Paid           */
                let paidCoordinates = [
                    CLLocationCoordinate2DMake(51.086523, -114.134463),
                    CLLocationCoordinate2DMake(51.081731, -114.134324),
                    CLLocationCoordinate2DMake(51.081771, -114.134045),
                    CLLocationCoordinate2DMake(51.083126, -114.134077),
                    CLLocationCoordinate2DMake(51.083126, -114.131513),
                    CLLocationCoordinate2DMake(51.083261, -114.131438),
                    CLLocationCoordinate2DMake(51.083281, -114.134120),
                    CLLocationCoordinate2DMake(51.086577, -114.134141),
                    CLLocationCoordinate2DMake(51.086523, -114.134463)

                ]

                let paid = MGLPolygonStyleAnnotation(coordinates: paidCoordinates, count: UInt(paidCoordinates.count))
                paid.fillColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                paid.fillOutlineColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                paid.fillOpacity = 0.3
                paid.title = "Paid Parking"
                paid.subtitle = "4 Hours"
                polygonAnnotationController.addStyleAnnotation(paid)
        
        
                universityParking()
        

        
    }
    
    func universityParking() {
        /* UNIVERSITY PARKING SPACES */
        
                // 1
        
                let oneCoordinates = [
                    CLLocationCoordinate2DMake(51.081024, -114.140149),
                    CLLocationCoordinate2DMake(51.081050, -114.138031),
                    CLLocationCoordinate2DMake(51.079075, -114.138020),
                    CLLocationCoordinate2DMake(51.079122, -114.139586),
                    CLLocationCoordinate2DMake(51.080025, -114.139715),
                    CLLocationCoordinate2DMake(51.080146, -114.140176),
                    CLLocationCoordinate2DMake(51.081024, -114.140149)
                ]

                let one = MGLPolygonStyleAnnotation(coordinates: oneCoordinates, count: UInt(oneCoordinates.count))
                one.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                one.fillOutlineColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                one.fillOpacity = 0.3
                one.title = "Paid Parking"
                one.subtitle = "$8/day"
                polygonAnnotationController.addStyleAnnotation(one)

    
                // 2
        
                let twoCoordinates = [
                    CLLocationCoordinate2DMake(51.080963, -114.137012),
                    CLLocationCoordinate2DMake(51.080943, -114.135767),
                    CLLocationCoordinate2DMake(51.079514, -114.135767),
                    CLLocationCoordinate2DMake(51.079494, -114.137054),
                    CLLocationCoordinate2DMake(51.080963, -114.137012)
                ]

                let two = MGLPolygonStyleAnnotation(coordinates: twoCoordinates, count: UInt(twoCoordinates.count))
                two.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                two.fillOutlineColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                two.fillOpacity = 0.3
                two.title = "Paid Parking"
                two.subtitle = "$8/day"
                polygonAnnotationController.addStyleAnnotation(two)
        
        
                // 8
        
                let eightCoordinates = [
                    CLLocationCoordinate2DMake(51.077169, -114.122973),
                    CLLocationCoordinate2DMake(51.077479, -114.121492),
                    CLLocationCoordinate2DMake(51.075760, -114.121535),
                    CLLocationCoordinate2DMake(51.075726, -114.123155),
                    CLLocationCoordinate2DMake(51.077169, -114.122973)
                ]

                let eight = MGLPolygonStyleAnnotation(coordinates: eightCoordinates, count: UInt(eightCoordinates.count))
                eight.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                eight.fillOutlineColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                eight.fillOpacity = 0.3
                eight.title = "Paid Parking"
                eight.subtitle = "$8/day"
                polygonAnnotationController.addStyleAnnotation(eight)
        
        
        
                // 12
        
                let twelveCoordinates = [
                    CLLocationCoordinate2DMake(51.076010, -114.128987),
                    CLLocationCoordinate2DMake(51.076391, -114.127791),
                    CLLocationCoordinate2DMake(51.076156, -114.127397),
                    CLLocationCoordinate2DMake(51.075731, -114.128702),
                    CLLocationCoordinate2DMake(51.076010, -114.128987)
                ]

                let twelve = MGLPolygonStyleAnnotation(coordinates: twelveCoordinates, count: UInt(twelveCoordinates.count))
                twelve.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                twelve.fillOutlineColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                twelve.fillOpacity = 0.3
                twelve.title = "Paid Parking"
                twelve.subtitle = "$8/day"
                polygonAnnotationController.addStyleAnnotation(twelve)
        
        
                // 13
        
                let thirteenCoordinates = [
                    CLLocationCoordinate2DMake(51.075816, -114.132245),
                    CLLocationCoordinate2DMake(51.075988, -114.131707),
                    CLLocationCoordinate2DMake(51.075661, -114.131380),
                    CLLocationCoordinate2DMake(51.075459, -114.131986),
                    CLLocationCoordinate2DMake(51.075816, -114.132245)
                ]

                let thirteen = MGLPolygonStyleAnnotation(coordinates: thirteenCoordinates, count: UInt(thirteenCoordinates.count))
                thirteen.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                thirteen.fillOutlineColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                thirteen.fillOpacity = 0.3
                thirteen.title = "Paid Parking"
                thirteen.subtitle = "$8/day"
                polygonAnnotationController.addStyleAnnotation(thirteen)
        
        
        //3,4,6,7,9,10,11
        
                // 3
        
                let threeCoordinates = [
                    CLLocationCoordinate2DMake(51.080969, -114.135402),
                    CLLocationCoordinate2DMake(51.080989, -114.134554),
                    CLLocationCoordinate2DMake(51.079681, -114.134457),
                    CLLocationCoordinate2DMake(51.079701, -114.135455),
                    CLLocationCoordinate2DMake(51.080969, -114.135402)
                ]

                let three = MGLPolygonStyleAnnotation(coordinates: threeCoordinates, count: UInt(threeCoordinates.count))
                three.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                three.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                three.fillOpacity = 0.3
                three.title = "Paid Parking"
                three.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(three)
        
        
              // 4
        
                let fourCoordinates = [
                    CLLocationCoordinate2DMake(51.079787, -114.134082),
                    CLLocationCoordinate2DMake(51.079787, -114.133342),
                    CLLocationCoordinate2DMake(51.079120, -114.133396),
                    CLLocationCoordinate2DMake(51.079066, -114.134088),
                    CLLocationCoordinate2DMake(51.079787, -114.134082)
                ]

                let four = MGLPolygonStyleAnnotation(coordinates: fourCoordinates, count: UInt(fourCoordinates.count))
                four.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                four.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                four.fillOpacity = 0.3
                four.title = "Paid Parking"
                four.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(four)
        
        
                //6
        
                let sixCoordinates = [
                    CLLocationCoordinate2DMake(51.080730, -114.127729),
                    CLLocationCoordinate2DMake(51.080757, -114.125889),
                    CLLocationCoordinate2DMake(51.080295, -114.126028),
                    CLLocationCoordinate2DMake(51.080271, -114.127251),
                    CLLocationCoordinate2DMake(51.080730, -114.127729)
                ]

                let six = MGLPolygonStyleAnnotation(coordinates: sixCoordinates, count: UInt(sixCoordinates.count))
                six.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                six.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                six.fillOpacity = 0.3
                six.title = "Paid Parking"
                six.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(six)
        
        
                //7
        
                let sevenCoordinates = [
                    CLLocationCoordinate2DMake(51.079232, -114.125387),
                    CLLocationCoordinate2DMake(51.079407, -114.124868),
                    CLLocationCoordinate2DMake(51.078976, -114.124482),
                    CLLocationCoordinate2DMake(51.078956, -114.125179),
                    CLLocationCoordinate2DMake(51.079232, -114.125387)
                ]

                let seven = MGLPolygonStyleAnnotation(coordinates: sevenCoordinates, count: UInt(sevenCoordinates.count))
                seven.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                seven.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                seven.fillOpacity = 0.3
                seven.title = "Paid Parking"
                seven.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(seven)
        
                //9
        
                let nineCoordinates = [
                    CLLocationCoordinate2DMake(51.076707, -114.125297),
                    CLLocationCoordinate2DMake(51.076987, -114.124487),
                    CLLocationCoordinate2DMake(51.076633, -114.124079),
                    CLLocationCoordinate2DMake(51.076249, -114.125109),
                    CLLocationCoordinate2DMake(51.076707, -114.125297)
                ]

                let nine = MGLPolygonStyleAnnotation(coordinates: nineCoordinates, count: UInt(nineCoordinates.count))
                nine.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                nine.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                nine.fillOpacity = 0.3
                nine.title = "Paid Parking"
                nine.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(nine)
        
        
                //10
        
                let tenCoordinates = [
                    CLLocationCoordinate2DMake(51.075481, -114.126193),
                    CLLocationCoordinate2DMake(51.076098, -114.124401),
                    CLLocationCoordinate2DMake(51.075808, -114.124176),
                    CLLocationCoordinate2DMake(51.075211, -114.126021),
                    CLLocationCoordinate2DMake(51.075481, -114.126193)
                ]

                let ten = MGLPolygonStyleAnnotation(coordinates: tenCoordinates, count: UInt(tenCoordinates.count))
                ten.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                ten.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                ten.fillOpacity = 0.3
                ten.title = "Paid Parking"
                ten.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(ten)
        
        
                //11
        
                let elevenCoordinates = [
                    CLLocationCoordinate2DMake(51.075791, -114.127346),
                    CLLocationCoordinate2DMake(51.076121, -114.126311),
                    CLLocationCoordinate2DMake(51.075882, -114.126091),
                    CLLocationCoordinate2DMake(51.075501, -114.127126),
                    CLLocationCoordinate2DMake(51.075791, -114.127346)
                ]

                let eleven = MGLPolygonStyleAnnotation(coordinates: elevenCoordinates, count: UInt(elevenCoordinates.count))
                eleven.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                eleven.fillOutlineColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                eleven.fillOpacity = 0.3
                eleven.title = "Paid Parking"
                eleven.subtitle = "$8/day, public after 3:30"
                polygonAnnotationController.addStyleAnnotation(eleven)
    }
}
