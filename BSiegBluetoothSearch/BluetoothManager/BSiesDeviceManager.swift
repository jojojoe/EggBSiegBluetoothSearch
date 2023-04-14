//
//  BSiesDeviceManager.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/10.
//

import UIKit
import Alertift

class BSiesDeviceManager {
    static let `default` = BSiesDeviceManager()
    
    
    let repository = DeviceRepository()
    
    var scannedDevices: [Device] = []
    var trackedDevices: [Device] = []
    var currentMyDevices: [Device] = []
    var otherTrackedDevices: [Device] = []

    var deviceScanningBlock: (()->Void)?
    
    
    private init() {
        
        BSiesBluetoothManager.default.delegate = self
    }
    
    func getTrackedDevices() {
        self.trackedDevices = self.repository.getAll()
    }
    
    
    func loadScannedDevices() {
        self.getTrackedDevices()
        let trackedDevices = self.trackedDevices
//        let scannedDevices = scannedDevices
        var currenttMyDevices: [Device] = []
        var otherDevices: [Device] = []
        for device in scannedDevices {
            if device.name == "BJ🤣cbYq😝R2R🎱" {
                debugPrint("BJ🤣cb -deviDress - \(device)")
            }
            if trackedDevices.contains(device) {
                device.isTracking = true
                currenttMyDevices.append(device)
//        updateDeviceLocation(device: device)
            } else {
                device.isTracking = false
                otherDevices.append(device)
            }
        }
        
//        self.scannedDevices = scannedDevices
        
        self.otherTrackedDevices = otherDevices
        self.currentMyDevices = currenttMyDevices
        
        self.deviceScanningBlock?()
    }
    
    private func updateDeviceLocation(device: Device) {
        
        LocationManager.default.getLocation { (location) in
            guard let location = location else { return }
            device.location = location
            device.lastScanned = Date()
            self.repository.update(a: device)
        }
    }
    
    func deleteTracker(device: Device) {
        self.repository.delete(a: device)
        self.getTrackedDevices()
    }
    
}

extension BSiesDeviceManager: BluetoothManagerDelegate {
    func didUpdateDevices() {
        
        self.loadScannedDevices()
        
    }
}



class Device {
    let locationManager = LocationManager()
    var repository = DeviceRepository()
    
    let id: UUID
    let name: String
    var givenName: String?
    var rssi: Int?
    var location: Location?
    var isTracking: Bool = false
    var user_id: String?
    var lastScanned: Date?
    
    init(id: UUID, name: String, rssi: Int?, isTracking: Bool?, givenName: String?, location: Location?, user_id: String?) {
        self.id = id
        self.name = name
        self.rssi = rssi
        self.givenName = givenName
        self.location = location
        if let isTracking = isTracking {
            self.isTracking = isTracking
        }
        self.user_id = user_id
    }
    
    func deviceDistancePercent() -> Double {
        if let rssi_m = rssi {
            var persValue: Double = 0
            
            let distance = calculateDistance(rssi: rssi_m)
            
            if distance.isLessThanOrEqualTo(1.0) {
                persValue = 1
            }
            if !distance.isLess(than: 1.0) && distance.isLess(than: 2.0) {
                persValue = 0.90
            }
            if !distance.isLess(than: 2.0) && distance.isLess(than: 3.0) {
                persValue = 0.80
            }
            if !distance.isLess(than: 3.0) && distance.isLess(than: 4.0) {
                persValue = 0.70
            }
            if !distance.isLess(than: 4.0) && distance.isLess(than: 5.0) {
                persValue = 0.60
            }
            if !distance.isLess(than: 5.0) && distance.isLess(than: 6.0) {
                persValue = 0.55
            }
            if !distance.isLess(than: 5.0) && distance.isLess(than: 7.0) {

                persValue = 0.50
            }
            if !distance.isLess(than: 7.0) && distance.isLess(than: 8.0) {

                persValue = 0.40
            }
            if !distance.isLess(than: 8.0) && distance.isLess(than: 9.0) {

                persValue = 0.30
            }
            if !distance.isLess(than: 9.0) && distance.isLess(than: 10.0) {

                persValue = 0.20
            }
            if !distance.isLess(than: 10.0) && distance.isLess(than: 15.0) {

                persValue = 0.15
            }
            if !distance.isLess(than: 15.0) && distance.isLess(than: 20.0) {

                persValue = 0.10
            }
            if !distance.isLess(than: 20.0) && distance.isLess(than: 30.0) {

                persValue = 0.05
            }
            if !distance.isLess(than: 30.0) {

                persValue = 0.03
            }
            return persValue
        }
        return 0
    }
    
    func deviceDistancePercentStr() -> String {
        return "\(Int(deviceDistancePercent() * 100))%"
    }
    
    func deviceTagIconName(isSmall: Bool = false) -> String {
        var iconStr = "device_bluetooth"
        if name.lowercased().contains("iphone") {
            iconStr = "device_phone"
        } else if name.lowercased().contains("mac") {
            iconStr = "device_mac"
        } else if name.lowercased().contains("airpod") {
            iconStr = "device_airpod"
        } else if name.lowercased().contains("watch") {
            iconStr = "device_watch"
        } else if name.lowercased().contains("book") {
            iconStr = "device_mbp"
        } else if name.lowercased().contains("pad") {
            iconStr = "device_pad"
        } else {
            iconStr = "device_bluetooth"
        }
        if isSmall {
            return iconStr + "_s"
        }
        return iconStr
    }
    
    func fetchDistanceString() -> String {
        if let rssi_m = rssi {
            var string = "Cannot calculate distance."
            let distance = calculateDistance(rssi: rssi_m)
            
            if distance.isLessThanOrEqualTo(1.0) {
              string = "0 - 1 meter"
            }
            if !distance.isLess(than: 1.0) && distance.isLess(than: 5.0) {
              string = "1 - 5 meters"
            }
            if !distance.isLess(than: 5.0) && distance.isLess(than: 10.0) {
              string = "5 - 10 meters"
            }
            if !distance.isLess(than: 10.0) {
              string = "10+ meters"
            }
            return string
        }
        return "Cannot calculate distance."
    }
    
    func calculateDistance(rssi: Int) -> Double {
      var txPower =  -59
      if (rssi == 0) {
        return -1.0
      }
      
      var ratio = (Double(rssi) * 1.0) / Double(txPower)
      if (ratio < 1.0) {
        return pow(ratio, 10)
      } else {
        var disatance = (0.89976) * pow(ratio, 7.7095) + 0.111
        return disatance
      }
    }
    
    func startTracking(_ completion: @escaping (Error?) -> Void) {
        
        self.isTracking = true
        
        self.repository.create(a: self)
        
        completion(nil)
    }
    
    func fetchLocation(_ completion: @escaping (Error?) -> Void) {
        self.getLocation() { error in
            guard error == nil else {
                completion(error)
                return
            }
        }
    }
    
//    func startTracking(_ completion: @escaping (Error?) -> Void) {
//
//
//        self.getLocation() { error in
//
//            guard error == nil else {
//                completion(error)
//                return
//            }
//
//            self.getUserId { error in
//                guard error == nil else {
//                    completion(error)
//                    return
//                }
//                self.isTracking = true
//
//                self.repository.create(a: self)
//
//                completion(nil)
//            }
//        }
//    }
    
    func stopTracking(_ completion: @escaping (Error?) -> Void) {
        self.isTracking = false
        self.repository.delete(a: self)
    }
    
    private func getLocation(_ completion: @escaping (Error?) -> Void) {
        locationManager.getLocation { (location) in
            if let location = location {
                self.location = location
                completion(nil)
            } else {
                
                //                Alertift.alert(title: "Location Needed", message: "Please enable location services under Settings > Privacy so the app can help you locate your bluetooth devices.")
                //                    .action(.cancel(""))
                //                    .show(on: self, completion: nil)
                
            }
        }
    }
    
    private func getUserId(_ completion: @escaping (Error?) -> Void) {
        completion(nil)
        //        User().getUserId { (user_id, error) in
        //            guard let user_id = user_id,
        //                  error == nil else {
        //                completion(error)
        //                return
        //            }
        //            self.user_id = user_id
        //            completion(nil)
        //        }
    }
}

extension Device: Equatable {
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id
    }
}
