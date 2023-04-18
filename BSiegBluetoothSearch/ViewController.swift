//
//  ViewController.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/7.
//

import UIKit
import SnapKit
import SwifterSwift

class ViewController: UIViewController {
    let settingBtn = UIButton()
    let searchLaunchPageV = UIView()
    let scanCollectionV = BSiegBlueDeviceCollectionView()
    let searchingBottomV = BSiegSearchingBottomV()
    let feedvis = UIImpactFeedbackGenerator.init(style: .light)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlueCentral()
        setupV()
        
        scanCollectionV.isHidden = false
        showSearchingBanner(isShow: true)
//        showSearchingBanner(isShow: false)
        
        //
//        addtestAudio()
        
        
        
        
    }
    
//    func addtestAudio() {
//        //
////        let audioPlayBtn = UIButton()
////        view.addSubview(audioPlayBtn)
////        audioPlayBtn.setTitle("Play", for: .normal)
////        audioPlayBtn.setTitleColor(UIColor.black, for: .normal)
////        audioPlayBtn.setTitleColor(UIColor.blue, for: .selected)
////        audioPlayBtn.snp.makeConstraints {
////            $0.center.equalToSuperview()
////            $0.width.height.equalTo(200)
////        }
////        audioPlayBtn.addTarget(self, action: #selector(audioPlayBtnClick(sender: )), for: .touchUpInside)
//
//
////        let degreeWidth: CGFloat = 240
////        let mapDegree = BSiegMapDegreeScaleV(frame: CGRect(x: (UIScreen.main.bounds.size.width - degreeWidth)/2, y: (UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width) / 2, width: degreeWidth, height: degreeWidth))
////        view.addSubview(mapDegree)
////        mapDegree.isUserInteractionEnabled = false
////        mapDegree.backgroundColor = .clear
//    }
    
    @objc func audioPlayBtnClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        
        if sender.isSelected {
//            BSiesAudioVibManager.default.playAudio()
        } else {
//            BSiesAudioVibManager.default.stopAudio()
        }
    }
    
    
    
    func showSearchingBanner(isShow: Bool) {
        if isShow {
            searchingBottomV.isHidden = false
            searchingBottomV.startScanRotateAnimal()
            
        } else {
            searchingBottomV.isHidden = true
            searchingBottomV.stopScanRotateAnimal()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scanCollectionV.refreshWating = false
        self.scanCollectionV.updateContentDevice()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNoti()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNoti()
    }
    
    func setupBlueCentral() {
        
        BSiesBabyBlueManager.default.prepare()
        
    }
    
    deinit {
        removeNoti()
    }
    
}

extension ViewController {
    
    
    func addNoti() {
        NotificationCenter.default.addObserver(self, selector:#selector(discoverDeviceUpdate(notification:)) , name: BSiesBabyBlueManager.default.discoverDeviceNotiName, object: nil)
        
    }
    
    func removeNoti() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func discoverDeviceUpdate(notification: Notification) {
        DispatchQueue.main.async {
            self.scanCollectionV.updateContentDevice()
            self.searchingBottomV.updateSearingCountInfoLabel()
        }
    }
    
    
}

extension ViewController {
    func setupV() {
        let bgImgV = UIImageView()
        view.addSubview(bgImgV)
        bgImgV.image = UIImage(named: "home")
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        setupTopBanner()
        //
        setupDeviceCollectionPage()
        //
//        setupSearchLaunchPage()
        //
        setupSearchingBottomBanner()
        
    }
    
    func setupTopBanner() {
        
        //
        let blueLabel1 = UILabel()
        view.addSubview(blueLabel1)
        blueLabel1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.width.height.greaterThanOrEqualTo(17)
        }
        blueLabel1.text = "Bluetooth Scanner"
        blueLabel1.textColor = UIColor(hexString: "#242766")
        blueLabel1.font = UIFont(name: "Poppins-Bold", size: 24)
        
        //
        
        settingBtn.setImage(UIImage(named: "settingb"), for: .normal)
        view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints {
            $0.centerY.equalTo(blueLabel1.snp.centerY)
            $0.right.equalToSuperview().offset(-24)
            $0.width.height.equalTo(40)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
    }
    
    func setupSearchingBottomBanner() {
        
        view.addSubview(searchingBottomV)
        searchingBottomV.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
//            $0.height.equalTo(362)
        }
        searchingBottomV.searchingCloseBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.stopScaningAction()
                
            }
        }
    }
    
    func setupDeviceCollectionPage() {
        
        view.addSubview(scanCollectionV)
        scanCollectionV.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(settingBtn.snp.bottom)
        }
        scanCollectionV.itemclickBlock = {
            [weak self] theDevice in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                 
                self.showContentSearchVC(bluetoothDevice: theDevice)
            }
        }
        
        scanCollectionV.searchAgainClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.searchAgainAction()
                
            }
        }
    }
}



extension ViewController {
    
    @objc func settingBtnClick(sender: UIButton) {
//        let vc = BSiegDeSettingVC()
//        let vc = BSiegDeSubscVC()
        let vc = BSiegDeSettingVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     
   
    func stopScaningAction() {
        
        showSearchingBanner(isShow: false)
        BSiesBabyBlueManager.default.stopScan()
//        BSiesBluetoothManager.default.stopScan()
    }
    
    func showContentSearchVC(bluetoothDevice: PeripheralItem) {
        if searchingBottomV.isHidden == false {
            showSearchingBanner(isShow: false)
        }
        
        let vc = BSiegDeviceContentVC(bluetoothDevice: bluetoothDevice)
        vc.fatherVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchAgainAction() {
        
        showSearchingBanner(isShow: true)
        if BSiesBabyBlueManager.default.centralManagerStatus == true {
            BSiesBabyBlueManager.default.peripheralItemList = []
            BSiesBabyBlueManager.default.startScan()
        } else {
            showBluetoothDeniedAlertV()
        }
        
    }
    
    func showBluetoothDeniedAlertV() {
        let alert = UIAlertController(title: "Oops", message: "You have declined access to Bluetooth, please active it in Settings>Privacy>Bluetooth.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
            DispatchQueue.main.async {
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:])
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}

