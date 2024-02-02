//
//  ViewController.swift
//  Clima
//
//  Created by ReviseUC73 on 1/2/2567 BE.
//

import UIKit

class WeatherViewController: UIViewController  {
    
    @IBOutlet weak var searchTextFiled: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherManageer = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextFiled.delegate = self // able to detect ex.able to know when textfield start editor by user
//        weatherManageer.delegate = self
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
    
    func didUpdateWeather(weather:WeatherModel){
        print(weather.temperature)
        
    }
    
}
// Before set Delegate to UIcontroller -> you need to set CG_NUMERICS_SHOW_BACKTRACE environmental variable.(loadview)
// action btw keyboard with pressding "GO"
extension WeatherViewController : WeatherDelegate {
    func didUpateWeather(weather: WeatherModel) {
        print("")
    }
    
    
}


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
            weatherManageer.featchWeather(cityName: cityName)
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
