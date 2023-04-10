//
//  BSiesBluetoothManager.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/10.
//

import UIKit
import CoreBluetooth


struct Peripheral: Equatable {
    let peripheral: CBPeripheral
    let rssi: NSNumber
    
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
    var centralManagerStatus: Bool = false
    override init() {
        super.init()
        
        
        
    }
    
    func setupCentral() {
        centralManager = CBCentralManager(delegate: self, queue: queue)
    }
    
    func startScan() {
        isStartScaning = true
        if centralManagerStatus {
            peripherals = []
            DispatchQueue.global().async {
                [weak self] in
                guard let `self` = self else {return}
                self.centralManager.scanForPeripherals(withServices: nil)
            }
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
    
    func getDevices() -> [Device] {
        
        var devices: [Device] = []
        
        for peripheral in peripherals {
            if let deviceName = peripheral.peripheral.name {
                let de = Device(id: peripheral.peripheral.identifier, name: deviceName, rssi: Int(peripheral.rssi), isTracking: nil, givenName: nil, location: nil, user_id: nil)
                devices.append(de)
            }
            
        }
        
        return devices
    }
    
}

extension BSiesBluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        centralManagerStatus = false
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweroff")
        case .poweredOn:
            print("central.state is .poweredOn")
            self.centralManagerStatus = true
            if self.isStartScaning {
                self.centralManager.scanForPeripherals(withServices: nil)
            }
            
        @unknown default:
            print("central.state is .@unknown default")
        }
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("peripheral - \(peripheral)")
        print("advertisementData - \(advertisementData)")
        print("RSSI - \(RSSI)")
        
        if let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double {
            self.txPower = power
        }
        
        if let txPower = self.txPower {
            print("Distance is ", pow(10, ((txPower - Double(truncating: RSSI))/20)))
        }
        
        if let name = peripheral.name {
            
            if let servis = peripheral.services, servis.count >= 1 {
                for servione in servis {
                    debugPrint("name = \(name) - characteristics = \(servione.characteristics)")
                }
            }
            
            let _peripheral = Peripheral(peripheral: peripheral, rssi: RSSI)
            
            
            
            if self.peripherals.contains(_peripheral) {
                return
            } else {
                debugPrint("device name = \(peripheral.name) - deviceid = \(peripheral.identifier)")
                self.peripherals.append(_peripheral)
                //centralManager.connect(_peripheral.peripheral, options: nil)
                self.delegate?.didUpdateDevices()
            }
        }
        
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("did connect \(peripheral)")
    }
    
}



