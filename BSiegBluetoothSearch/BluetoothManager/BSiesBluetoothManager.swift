//
//  BSiesBluetoothManager.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/10.
//

import UIKit
import CoreBluetooth


class Peripheral: Equatable {
    let peripheral: CBPeripheral
    var rssi: NSNumber
    init(peripheral: CBPeripheral, rssi: NSNumber) {
        self.peripheral = peripheral
        self.rssi = rssi
    }
    static func == (lhs: Peripheral, rhs: Peripheral) -> Bool {
        return lhs.peripheral.identifier == rhs.peripheral.identifier
    }
}

protocol BluetoothManagerDelegate {
    func didUpdateDevices()
}

class BSiesBluetoothManager: NSObject {
    
    static let `default` = BSiesBluetoothManager()
    var centralManager: CBCentralManager!
    var peripherals: [Peripheral] = []
    var txPower: Double?
    var delegate: BluetoothManagerDelegate?
    let queue = DispatchQueue(label: "test", qos: .background)//DispatchQueue.init(label: "test")
    var isStartScaning: Bool = false
    var centralManagerStatus: Bool?
    
    var deviceBluetoothDeniedBlock: (()->Void)?
    
    override init() {
        super.init()
        
        
        
    }
    
    func setupCentral() {
        centralManager = CBCentralManager(delegate: self, queue: queue)
    }
    
    func startScan(deviceUUId: UUID? = nil) {
        isStartScaning = true
//        peripherals = []
//        BSiesDeviceManager.default.scannedDevices = []
        DispatchQueue.global().async {
            [weak self] in
            guard let `self` = self else {return}
            self.centralManager.scanForPeripherals(withServices: nil)
//            if let uuidstr = deviceUUId {
//                self.centralManager.scanForPeripherals(withServices: [CBUUID(nsuuid: uuidstr)])
//            } else {
//                self.centralManager.scanForPeripherals(withServices: nil)
//            }

        }
    }
    
    func stopScan() {
        isStartScaning = false
        centralManager.stopScan()
    }
    
    func getConnectedPeriperals() {
        var connected = centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: "0x1800")])
        
        for peripheral in connected {
            print("connected yoyo \(peripheral)")
        }
    }
    
    func getDevices() {
        
        var devices: [Device] = []
        debugPrint("peripherals count = \(peripherals.count)")
        
        for peripheral in peripherals {
            if let deviceName = peripheral.peripheral.name {
                if let devi = BSiesDeviceManager.default.scannedDevices.first(where: { dev in
                    dev.id == peripheral.peripheral.identifier
                }) {
                    devi.rssi = Int(peripheral.rssi)
                    if deviceName == "BJ🤣cbYq😝R2R🎱" {
                        debugPrint("BJ🤣cb -deviDress - \(devi)")
                    }
                    
                } else {
                    let de = Device(id: peripheral.peripheral.identifier, name: deviceName, rssi: Int(peripheral.rssi), isTracking: nil, givenName: nil, location: nil, user_id: nil)
                    BSiesDeviceManager.default.scannedDevices.append(de)
                    if deviceName == "BJ🤣cbYq😝R2R🎱" {
                        debugPrint("BJ🤣cb -deviDress - \(de)")
                    }
                }
                
                
            }
            
                
        }
        
        debugPrint("")
        debugPrint("devices count - \(devices.count)")
        debugPrint("BSiesDeviceManager.default.scannedDevices count = \(BSiesDeviceManager.default.scannedDevices.count)")
    }
    
}

extension BSiesBluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        centralManagerStatus = false
        switch central.state {
        case .unknown:
            debugPrint("central.state is .unknown")
            self.deviceBluetoothDeniedBlock?()
        case .resetting:
            debugPrint("central.state is .resetting")
            self.deviceBluetoothDeniedBlock?()
        case .unsupported:
            debugPrint("central.state is .unsupported")
            self.deviceBluetoothDeniedBlock?()
        case .unauthorized:
            debugPrint("central.state is .unauthorized")
            self.deviceBluetoothDeniedBlock?()
        case .poweredOff:
            debugPrint("central.state is .poweroff")
            self.deviceBluetoothDeniedBlock?()
        case .poweredOn:
            debugPrint("central.state is .poweredOn")
            self.centralManagerStatus = true
            self.isStartScaning = true
            self.centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            
            debugPrint("central.state is .@unknown default")
        }
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        debugPrint("peripheral - \(peripheral)")
        debugPrint("advertisementData - \(advertisementData)")
        debugPrint("RSSI - \(RSSI)")
        
        if let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double {
            self.txPower = power
        }
        debugPrint("current  txPower - \(txPower)")
        if let txPower = self.txPower {
            debugPrint("Distance is ", pow(10, ((txPower - Double(truncating: RSSI))/20)))
        }
        
        if let name = peripheral.name {
            
            if let servis = peripheral.services, servis.count >= 1 {
                for servione in servis {
                    debugPrint("name = \(name) - characteristics = \(servione.characteristics)")
                }
            }
            debugPrint("peripheral.name = \(peripheral.name)")
            let _peripheral = Peripheral(peripheral: peripheral, rssi: RSSI)
            
            if self.peripherals.contains(_peripheral) {
                if let indexp = self.peripherals.firstIndex(of: _peripheral) {
                    let peri = self.peripherals[indexp]
                    peri.rssi = RSSI
                    debugPrint("fix rssi - \(RSSI)")
                    if name == "BJ🤣cbYq😝R2R🎱" {
                        debugPrint("fix BJ🤣cb rssi - \(RSSI)")
                    }
                    getDevices()
                    self.delegate?.didUpdateDevices()
                }
                return
            } else {
                debugPrint("device name = \(peripheral.name) - deviceid = \(peripheral.identifier)")
                if name == "BJ🤣cbYq😝R2R🎱" {
                    debugPrint("fix BJ🤣cb rssi - \(RSSI)")
                }
                self.peripherals.append(_peripheral)
                getDevices()
                self.delegate?.didUpdateDevices()
            }
        }
        
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        debugPrint("did connect \(peripheral)")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
}

extension BSiesBluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
    }
}



