//
//  WeatherModel.swift
//  Clima
//
//  Created by ReviseUC73 on 1/2/2567 BE.
//

import Foundation
//https://api.openweathermap.org/data/2.5/weather?q=london&appid=f11f83cfb4666257b1b4d73e8b9fb4f6
protocol WeatherDelegate {
    func didUpateWeather(weather: WeatherModel)
}
struct WeatherManager  {
//    let delegate: WeatherDelegate?
    let  weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f11f83cfb4666257b1b4d73e8b9fb4f6&units=metric"
    
    func featchWeather (cityName :  String)  {
        let urlString =  "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    func performRequest(urlString : String){
        if let url = URL(string: urlString){
            let session  = URLSession(configuration: .default)
            // let task  = session.dataTask(with: url, completionHandler: handle(data:response:error:)) // FUll-CAll
            let task  = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!); return
                }
                
                if let safeDate = data {
                    if let weatherModel = parseJSON(weatherData: safeDate){
                        let weatherVC = WeatherViewController()
                        weatherVC.didUpdateWeather(weather: weatherModel)
//                        delegate?.didUpateWeather(weather: weatherModel)
                    }
                }
            }
            
            //4. Start Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self,from:weatherData) // WeatherData.self call for get type (in case -> Decodeable)
            //            print(decodeData.name)
            
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditionId:id, cityName: name, temperature: temp)
            //            print(weather.getConditionName(weatherID: id))
            print("--------")
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
}








//    func handle(data : Data?, response : URLResponse?, error : Error?){
//        if error != nil {
//            print(error!)
//            return
//        }
////        guard let data = data else {
////            print("data fail")
////            return
////        }
////        if let safeData = data , let dataString = String(data: safeData, encoding: .utf8) {
////            print(dataString)
////        }
//        if let safeData = data {
//            if let dataString = String(data: safeData, encoding: .utf8){
//                print(dataString)
//            }
//        }
//    }

