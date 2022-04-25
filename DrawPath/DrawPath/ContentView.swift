//
//  ContentView.swift
//  DrawPath
//
//  Created by Rion on 24.4.22.
//

import SwiftUI
import MapKit





struct ContentView2: View {
   
    @State var requestLocation = CLLocationCoordinate2D(latitude: 42.6619, longitude:  21.1501)
    
    @State var requestLocation2 = CLLocationCoordinate2D(latitude: 42.6619, longitude:  21.1501)
 
    @State var destinationLocation = CLLocationCoordinate2D(latitude: 42.6919, longitude: 21.1701)
  
    @State var destination2 = CLLocationCoordinate2D(latitude: 42.6619, longitude: 21.1701)
    var body: some View {
        VStack{
            MyMapView(requestLocation: $requestLocation,
                      requestLocation2:$requestLocation2, destinationLocation: $destinationLocation,destination2: $destination2)
           
                .edgesIgnoringSafeArea(.all)
    }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
