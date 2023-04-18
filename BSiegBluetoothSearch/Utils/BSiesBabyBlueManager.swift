//
//  BSiesBabyBlueManager.swift
//  BSiegBluetoothSearch
//
//  Created by Joe on 2023/4/15.
//

import Foundation
import CoreBluetooth



class BSiesBabyBlueManager: NSObject {
    
    static let `default` = BSiesBabyBlueManager()
    var peripheralItemList: [PeripheralItem] = []
    var cachaedPeripheralItemList: [PeripheralItem] = []
    
    var centralManager: CBCentralManager!
    let queue = DispatchQueue(label: "test", qos: .background)
    var centralManagerStatus: Bool?
    var deviceBluetoothDeniedBlock: (()->Void)?
    var favoriteDevicesIdList: [String] = []
    
    let discoverDeviceNotiName: NSNotification.Name = NSNotification.Name.init("not_ScaningDeviceUpdate")
    let trackingDeviceNotiName: NSNotification.Name = NSNotification.Name.init("trackingDeviceUpdate")
    
    var currentTrackingItem: PeripheralItem?
    var currentTrackingItemRssi: Double?
    var currentTrackingItemName: String?
    
    override init() {
        super.init()
        fetchUserFavorites()
    }
    
    func prepare() {
        centralManager = CBCentralManager(delegate: self, queue: queue)
    }
    
    
    func startScan() {
//        peripheralItemList = []
        DispatchQueue.global().async {
            [weak self] in
            guard let `self` = self else {return}
            self.centralManagerScan()
        }
    }
    
    func stopScan() {
        cachaedPeripheralItemList = peripheralItemList
        centralManager.stopScan()
    }
    
    
    
}

extension BSiesBabyBlueManager {
    func fetchUserFavorites() {
        
        favoriteDevicesIdList = UserDefaults.standard.object(forKey: "ud_favoriteDevicesId") as? [String] ?? []
        debugPrint("favoriteDevicesIdList = \(favoriteDevicesIdList.count)")
    }
    
    func addUserFavorite(deviceId: String) {
        favoriteDevicesIdList.append(deviceId)
        UserDefaults.standard.set(favoriteDevicesIdList, forKey: "ud_favoriteDevicesId")
        UserDefaults.standard.synchronize()
    }
    
    func removeUserFavorite(deviceId: String) {
        if favoriteDevicesIdList.contains(deviceId) {
            favoriteDevicesIdList.removeAll { item in
                item == deviceId
            }
            UserDefaults.standard.set(favoriteDevicesIdList, forKey: "ud_favoriteDevicesId")
            UserDefaults.standard.synchronize()
        }
    }
    
}



extension BSiesBabyBlueManager {
    
     func centralManagerScan() {
        self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
    }
    
    func sendDiscoverDeviceNotification() {
        NotificationCenter.default.post(name: discoverDeviceNotiName, object: nil)
    }
    
    func sendTrackingDeviceNotification() {
        NotificationCenter.default.post(name: trackingDeviceNotiName, object: nil)
    }
    
}

extension BSiesBabyBlueManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        centralManagerStatus = false
        switch central.state {
        case .unknown, .resetting, .unsupported, .unauthorized, .poweredOff:
            debugPrint("central.state is .unknown")
            self.deviceBluetoothDeniedBlock?()
        case .poweredOn:
            debugPrint("central.state is .poweredOn")
            self.centralManagerStatus = true
            centralManagerScan()
        @unknown default:
            debugPrint("central.state is .@unknown default")
        }
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        debugPrint("peripheral.name - \(peripheral.name ?? "?")")
        debugPrint("advertisementData - \(advertisementData)")
        debugPrint("RSSI - \(RSSI)")
        
        if let deviceName = peripheral.name {
            
            if let peItem = peripheralItemList.first(where: { perItem in
                perItem.identifier == peripheral.identifier.uuidString
            }) {
                peItem.rssi = Double(truncating: RSSI)
                debugPrint("peItem addr = \(peItem)")
                debugPrint("peItem.rssi = \(peItem.rssi)")
                
                if let currentTrack = currentTrackingItem, currentTrack.identifier == peItem.identifier {
                    currentTrackingItemName = currentTrack.deviceName ?? ""
                    currentTrackingItemRssi = Double(truncating: RSSI)
                    
                    sendTrackingDeviceNotification()
                    
                }
            } else {
                if let peItem = cachaedPeripheralItemList.first(where: { perItem in
                    perItem.identifier == peripheral.identifier.uuidString
                }) {
                    peItem.rssi = Double(truncating: RSSI)
                    peripheralItemList.append(peItem)
                } else {
                    let item = PeripheralItem(identifier: peripheral.identifier.uuidString, deviceName: deviceName, rssi: Double(truncating: RSSI))
                    peripheralItemList.append(item)
                }
                
                
            }
            sendDiscoverDeviceNotification()
            
            
        }
        
        
        
    }
    
    
}
