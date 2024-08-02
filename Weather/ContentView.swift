//
//  ContentView.swift
//  Weather
//
//  Created by Parth Patel on 2024-07-31.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject private var weatherNetwork = WeatherNetwork()
    @State private var cityName: String = ""
    @State private var screenMode: Bool = false
    
    var body: some View {
            ZStack {
                Image(screenMode ? "light" : "dark")
                    .resizable()
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        VStack {
                            HStack {
                                TextField("Enter city name ", text: $cityName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button {
                                    weatherNetwork.fetchWeather(cityName: cityName)
                                    cityName = ""
                                    hideKeyboard()
                                } label: {
                                    Text("Search")
                                        .font(.system(size: 15))
                                        .frame(width: 75, height: 35)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(.rect(cornerRadius: 8))
                                }
                            }
                            .frame(maxWidth: 360)
                            Spacer()
                        }
                        .padding()
                        //.ignoresSafeArea(.keyboard)
                        Spacer()
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Image(systemName: screenMode ? "sun.max.fill" : "moon.stars.fill")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 20)
                                    
                                    if let temp = weatherNetwork.weatherModel?.main.temp {
                                        Text("\(String(format: "%.2f", temp-273))°")
                                            .font(.system(size: 35))
                                            .fontWeight(.semibold)
                                            .fontDesign(.monospaced)
                                    }
                                }
                                .padding()
                                Spacer()
                                VStack(alignment: .trailing) {
                                    if let city = weatherNetwork.weatherModel?.name {
                                        Text(city)
                                            //.minimumScaleFactor(0.25)
                                    }
//                                    if let country = weatherNetwork.weatherModel?.sys.country {
//                                        Text(country)
//                                    }
                                }
                                .padding()
                                .foregroundStyle(.black)
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.black)
                            }
                            .frame(maxWidth: 370)
                            .background(.regularMaterial.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 20)).shadow(radius: 20)
                            .padding()
                            
                            withAnimation(.smooth(duration: 2)) {
                                ExtraInfoView(weatherModel: $weatherNetwork.weatherModel)
                            }
                            
                            Spacer()
                            Button {
                                withAnimation(.easeIn(duration: 2)) {
                                                        screenMode.toggle()
                                                    }
                            } label: {
                                Text(screenMode ? "Change To Dark Mode" : "Change To Light Mode")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20))
                                    .fontDesign(.monospaced)
                                    .padding()
                                    .frame(width: 290, height: 70)
                                    .background(Color.indigo).opacity(0.9)
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                            .padding()
                        }
                        .onAppear {
                            let latitude: CLLocationDegrees = 50.00
                            let longitude: CLLocationDegrees = -78.86
                            weatherNetwork.fetchWeather(latitude: latitude, longitude: longitude)
                        }
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .ignoresSafeArea(.keyboard)
            }
    }
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
}

#Preview {
    ContentView()
}


