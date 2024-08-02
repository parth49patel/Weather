//
//  ExtraInfoView.swift
//  Weather
//
//  Created by Parth Patel on 2024-07-31.
//


import SwiftUI

struct ExtraInfoView: View {
    @Binding var weatherModel: WeatherModel?
    var body: some View {
        VStack {
            ForEach(weatherModel?.weather ?? [], id: \.self) { item in
                Text(item.description)
            }
        }
        .font(.system(size: 25))
        .fontWeight(.semibold)
        .fontDesign(.monospaced)
        .frame(width: 325)
        .padding()
        .background(.ultraThinMaterial).opacity(0.9)
        .shadow(radius: 20)
        .clipShape(.rect(cornerRadius: 20))
        //.transition(.slide)
        Spacer(minLength: 20)
        LazyVGrid(columns: [GridItem(.fixed(170)),
                            GridItem(.fixed(170))], spacing: 50){
            VStack{
                Text("Feels Like\(Image(systemName: "thermometer.variable.and.figure"))")
                    //.symbolRenderingMode(.palette)
                if let feelsLike = weatherModel?.main.feels_like {
                    Text("\(String(format: "%.2f", feelsLike-273))°")
                }
            }
            VStack{
                Text("Wind Speed\(Image(systemName: "wind"))")
                if let windSpeed = weatherModel?.wind.speed {
                    Text("\(String(format: "%.2f", windSpeed)) km/h")
                }
            }
            VStack{
                Text("Humidity\(Image(systemName: "humidity.fill"))")
                if let humidity = weatherModel?.main.humidity {
                    Text("\(humidity)%")
                }
            }
            VStack{
                Text("Pressure")
                if let pressure = weatherModel?.main.pressure {
                    Text("\(pressure) hPa")
                }
            }
            VStack{
                Text("Sunrise\(Image(systemName: "sunrise.fill"))")
                if let sunRise = weatherModel?.sys.sunrise {
                    Text(formatUnixTime(sunRise))
                }
            }
            VStack{
                Text("Sunset\(Image(systemName: "sunset.fill"))")
                if let sunSet = weatherModel?.sys.sunset {
                    Text(formatUnixTime(sunSet))
                }
            }
        }
        .font(.system(size: 20))
        .fontWeight(.semibold)
        .fontDesign(.monospaced)
        .frame(width: 325)
        .padding()
        .background(.ultraThinMaterial).opacity(0.9)
        .shadow(radius: 20)
        .clipShape(.rect(cornerRadius: 20))
        //.transition(.slide)
    }

    func formatUnixTime(_ unixTime: Int) -> String {
            let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            return dateFormatter.string(from: date)
        }
}

struct ExtraInfoView_Previews: PreviewProvider {
    @State static var weatherModel: WeatherModel? = nil

    static var previews: some View {
        ExtraInfoView(weatherModel: $weatherModel)
            .transition(.slide)
    }
}
