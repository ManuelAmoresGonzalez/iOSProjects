//
//  ContentView.swift
//  WeatherApp
//
//  Created by Manuel Enrique Amores Gonzalez on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isDayTime: Bool = true
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                colors: [
                    isDayTime ? Color.blue : Color.black,
                    isDayTime ? Color("lightBlue") : Color.gray
                ]
            ),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("London")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                
                VStack(spacing: 40) {
                    Image(systemName: isDayTime ? "cloud.sun.fill" : "moon.stars")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("20°")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                }
                
            HStack() {
                
                DayWatherContainer(dayName: "MON", imageName: "cloud.sun.fill", degressTemperature: 20)
                DayWatherContainer(dayName: "TUE", imageName: "sun.max.fill", degressTemperature: 18)
                DayWatherContainer(dayName: "WED", imageName: "wind.snow", degressTemperature: 15)
                DayWatherContainer(dayName: "THU", imageName: "sunset.fill", degressTemperature: 10)
                DayWatherContainer(dayName: "FRI", imageName: "snow", degressTemperature: 9)
                DayWatherContainer(dayName: "SAT", imageName: "cloud.sun.fill", degressTemperature: 12)
                DayWatherContainer(dayName: "SUN", imageName: "wind.snow", degressTemperature: 23)
            }
                Spacer()
                
                Button(action: {
                    isDayTime ? (isDayTime = false) : (isDayTime = true)
                    print("Button Tapped")
                }, label: {
                    Text("Change Day Time")
                        .frame(width: 280, height: 50)
                        .background(.white)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct DayWatherContainer: View {
    
    var dayName: String
    let imageName: String
    let degressTemperature: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Text(dayName)
                .font(.system(size: 20))
                .foregroundColor(.white)
            
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fit)
            
            Text("\(degressTemperature)°")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}
