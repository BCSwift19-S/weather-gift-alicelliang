//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Alice Liang on 3/6/19.
//  Copyright © 2019 Alice Liang. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
     
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentPage != 0 {
            self.locationsArray[currentPage].getWeather {
                self.updateUserInterface()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        let location = locationsArray[currentPage]
        locationLabel.text = location.name
        let dateString = formatTimeForTimeZone(unixDate: location.currentTime, timeZone: location.timeZone)
        dateLabel.text = dateString
        temperatureLabel.text = location.currentTemp
        summaryLabel.text = location.currentSummary
        currentImage.image = UIImage(named: location.currentIcon)
    }
    
    func formatTimeForTimeZone(unixDate: TimeInterval, timeZone: String)-> String {
        let usableDate = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd, y"
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}

extension DetailVC: CLLocationManagerDelegate{
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways,.authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("I'm sorry - can't show location. User has not authorized it.")
        case .restricted:
            print("Access denied. Likely parental control are restricting location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude),\(currentLongitude)"
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler:
            {placemarks, error in
                if placemarks != nil {
                    let placemark = placemarks?.last
                    place = (placemark?.name)!
                } else {
                    print("Error retriving place. Error code: \(error!)")
                    place = "Unknown Weather Location"
                }
                self.locationsArray[0].name = place
                self.locationsArray[0].coordinates = currentCoordinates
                self.locationsArray[0].getWeather {
                    self.updateUserInterface()
                }
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail to get user location.")
    }
}

