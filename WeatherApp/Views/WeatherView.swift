//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Vika Zvonaryova on 25.12.2021.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name).bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack{
                    HStack {
                        VStack(spacing: 20){
                            Image(systemName: "sun.max.fill").font(.system(size:40))
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer().frame(height: 80)
                    AsyncImage(url: URL(string:"https://wolfart.studio/images/Wien-by-Vuk-Vuckovic-Wolf-2018.jpg")) {
                        image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }.padding()
                .frame(minWidth: 0, alignment: .leading)
            VStack{
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Now")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min Tempreture", value: (weather.main.tempMin.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max Tempreture", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(red: 0.5201848149, green: 0.3129968643, blue: 0.4161118269))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 0.5201848149, green: 0.3129968643, blue: 0.4161118269))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
