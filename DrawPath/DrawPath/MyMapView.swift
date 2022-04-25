//
//  MyMapView.swift
//  DrawPath
//
//  Created by Rion on 25.4.22.
//

import Foundation
import SwiftUI
import MapKit

struct MyMapView: UIViewRepresentable {

    @Binding var requestLocation: CLLocationCoordinate2D
    @Binding var requestLocation2: CLLocationCoordinate2D
    @Binding var destinationLocation: CLLocationCoordinate2D
    @Binding var destination2 : CLLocationCoordinate2D

    private let mapView = WrappableMapView()

    func makeUIView(context: UIViewRepresentableContext<MyMapView>) -> WrappableMapView {
        mapView.delegate = mapView
        return mapView
    }

    func updateUIView(_ uiView: WrappableMapView, context: UIViewRepresentableContext<MyMapView>) {

        let requestAnnotation = MKPointAnnotation()
        requestAnnotation.coordinate = requestLocation
        requestAnnotation.title = "Package Title"
        uiView.addAnnotation(requestAnnotation)
        
       let requestAnnotation2 = MKPointAnnotation()
        requestAnnotation2.coordinate = requestLocation2
        requestAnnotation2.title = "Package Title"
        uiView.addAnnotation(requestAnnotation2)

        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationLocation
        destinationAnnotation.title = "Destination"
        uiView.addAnnotation(destinationAnnotation)

       let destinationAnnotation3 = MKPointAnnotation()
        destinationAnnotation3.coordinate = destination2
        destinationAnnotation3.title = "Loc4"
       uiView.addAnnotation(destinationAnnotation3)

        let requestPlacemark = MKPlacemark(coordinate: requestLocation)
        let requestPlacemark1 = MKPlacemark(coordinate: requestLocation2)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
       let destination2Placemark = MKPlacemark(coordinate: destination2)

        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: requestPlacemark)
        
     //   directionRequest.source = MKMapItem(placemark: requestPlacemark1)
       directionRequest.destination = MKMapItem(placemark: requestPlacemark1)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
      // directionRequest.destination = MKMapItem(placemark: destination2Placemark)
        directionRequest.transportType = .automobile
      

  
        let directionRequest2 = MKDirections.Request()
          directionRequest2.source = MKMapItem(placemark: requestPlacemark1)
        directionRequest2.destination = MKMapItem(placemark: destination2Placemark)
        
        
        
           let directions2 = MKDirections(request: directionRequest2)
                 directions2.calculate { response, error in
                     guard let response = response else { return }

                     let route = response.routes[0]
                     uiView.addOverlay(route.polyline, level: .aboveRoads)
                     
                     let routezs = response.routes[0]
                     uiView.addOverlay(route.polyline, level: .aboveRoads)

                     let rect = route.polyline.boundingMapRect
                     uiView.setRegion(MKCoordinateRegion(rect), animated: true)
                     
                     
                     let rect2 = routezs.polyline.boundingMapRect
                     uiView.setRegion(MKCoordinateRegion(rect), animated: true)

                     // if you want insets use this instead of setRegion
                      uiView.setVisibleMapRect(rect2, edgePadding: .init(top: 10.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
                     
                 }
        
        
     
        let directions = MKDirections(request: directionRequest)
              directions.calculate { response, error in
                  guard let response = response else { return }

                  let route = response.routes[0]
                  uiView.addOverlay(route.polyline, level: .aboveRoads)
                  
                  let routezs = response.routes[0]
                  uiView.addOverlay(route.polyline, level: .aboveRoads)

                  let rect = route.polyline.boundingMapRect
                  uiView.setRegion(MKCoordinateRegion(rect), animated: true)
                  
                  
                  let rect2 = routezs.polyline.boundingMapRect
                  uiView.setRegion(MKCoordinateRegion(rect), animated: true)

                  // if you want insets use this instead of setRegion
                   uiView.setVisibleMapRect(rect, edgePadding: .init(top: 10.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
                  
              }

          }
    func setMapRegion(_ region: CLLocationCoordinate2D){
        mapView.region = MKCoordinateRegion(center: region, latitudinalMeters: 60000, longitudinalMeters: 60000)
    }
    
    
      }

class WrappableMapView: MKMapView, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandomColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    
    
    func getRandomColor() -> UIColor{
         let randomRed = CGFloat.random(in: 0...1)
         let randomGreen = CGFloat.random(in: 0...1)
         let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
  
}
