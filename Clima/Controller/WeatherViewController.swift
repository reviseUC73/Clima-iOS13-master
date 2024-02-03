//
//  ViewController.swift
//  Clima
//
//  Created by ReviseUC73 on 1/2/2567 BE.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController  {
    
    //MARK: - IBOutlet
    @IBOutlet weak var searchTextFiled: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    //MARK: - Delegate Manager
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        searchTextFiled.delegate = self // able to detect ex.able to know when textfield start editor by user
        weatherManager.delegate = self // ตั่งค่า class ปัจจุบันเป็น class ตัวแทน(เชื่ิอม) (ตัว delegate) ช่วยบอกเชื่อมกับweatherManager
        // setค่าของthis class -> weatherManger.delegate = ins(class-struct: WeatherViewController)
        // then .delegate(?) จะได้ไม่เป็น nil และ ถ้าdataที่ดึงมีปัญหาเนื่องจาก delegate
        // self.delegate?.didUpdateWeather(weather: weatherModel) ดังนั้นมันก็จะpassข้่าม dataที่มีปัญหาหานั้น
        // เพราะ delegate คือ การส่ง data จาก Manager -> Controller ผ่านfunction in rule of protocal them
        // เพื่อ update data ใน controller ที่มีการเชื่อต่อกับ Manager
        
        // sumary delegate
        // สิ่งที่เราต้องทำเพื่อเชื่อต่อเพื่อใช้บริการผ่านManagerClass คือ <ทำfunction รับข้อมูลสภาพอากาศ>
        // ManagerClass เราต้องเขียน featchWeather ซึ่งเป็น fuction ที่ดึงข้อมูลล่าสุด(doSomeThing)และมีการเรียกใช้
        // function ภายใต้เงื่อนไขของ protocal   self.delegate?.didUpdateWeather(weather: weatherModel)
        // เพื่อเป็นการ auto run -> function of class(WeatherVC) ที่เป็นตัวเชื่อมตัอทั้งหมดของ
        // WeatherMangaer  ผ่าน function เงื่อนไขของ protocal
        //      ตัวทำข้อมูล และ ส่ง                     ตัวรับข้อมูล(หลายตัว)
        // WeatherMangaer (SERVER)<-- (CLIENT) WeatherVC1:PT(WeatherDelegate)
        //<-- (CLIENT) WeatherVC2:PT(WeatherDelegate)
        //<-- (CLIENT) WeatherVC3:PT(WeatherDelegate)
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        //MARK: MY PROBLEM
        //        print(searchTextFiled.text)
        
        /// SOLUTION TO -> sovle Optinal
        ///
        //MARK: - Guard
        /// 100per can bring varible to use out of statement || need wrtite return
        guard let safeGuardSearchText = searchTextFiled.text else { print("guard : Not data"); return}
        print("guard : \(safeGuardSearchText)")
        
        //MARK: - if let
        /// 100per can bring varible to use out of statement , easy read || need wrtite return ,long
        if let safeLetSearchText = searchTextFiled.text {
            print("if let : \(safeLetSearchText)")}
        else {
            print("if let : Not data"); }
        
        //MARK: - != nil
        /// esay to read  || long , can not pass var exit condition
        if searchTextFiled.text != nil {
            print("!= nil : \(searchTextFiled.text!)")}
        else {
            print("!= nil : Not data") ; return}
        
        //MARK: - ?? Do
        ///   short and easy to read || it can not use return to pass variable exit function
        print(searchTextFiled.text ?? "?? : Not data")
        
        //MARK: - Result
        print(safeGuardSearchText,safeGuardSearchText)
        searchTextFiled.endEditing(true)
        
    }
    
    @IBAction func weatherLocationPresss(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - WeatherDelegate
// Before set Delegate to UIcontroller -> you need to set CG_NUMERICS_SHOW_BACKTRACE environmental variable.(loadview)
// action btw keyboard with pressding "GO"
extension WeatherViewController : WeatherDelegate {
    // เอา func พวกนี้ไปเรียหใช้ใน Manager
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel) {
        temperatureLabel.text = weather.temperatureString
        cityLabel.text = weather.cityName
        conditionImageView.image = UIImage(systemName: weather.conditionName)
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate{
    
    // do this action then -> ..
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiled.endEditing(true)
        return true
    }
    
    // notify to textfield end -> hi viewcontrller pls stop everything (when i pressd go in keyboard )
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(searchTextFiled.text!)
        if let cityName = searchTextFiled.text {
            weatherManager.featchWeather(cityName: cityName)
        }
        searchTextFiled.text = ""
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextFiled.text != "" {
            return true
        }
        else{
            textField.placeholder = "Type sth"
            return false
        }
    }
    
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locatiion")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("Latitude: \(lat), Longitude: \(lon)")
            weatherManager.featchWeather(latitude:lat , longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
