//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vika Zvonaryova on 17.12.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack  {
            
            if let location = locationManager.location {
                if weather != nil {
                    WeatherView(weather: weather!)
                } else {
                    LoadingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(latitude:location.latitude,longitude:location.longitude)
                        } catch {
                            print("Error getting weather: \(error)")
                        }
                    }
                }
            } else {
                         if (locationManager.isLoading) {
                             LoadingView()
                         } else {
                             WelcomeView().environmentObject(locationManager)
                         }
                }
            }
        .background(Color(red: 0.5201848149, green: 0.3129968643, blue: 0.4161118269))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
