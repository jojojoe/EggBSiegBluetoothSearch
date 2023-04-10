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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupV()
        scanCollectionV.isHidden = true
        searchLaunchPageV.isHidden = false
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
        setupSearchLaunchPage()
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
        blueLabel1.font = UIFont(name: "Poppins", size: 24)
        
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
    
    func setupSearchLaunchPage() {
        searchLaunchPageV.backgroundColor = .clear
        view.addSubview(searchLaunchPageV)
        searchLaunchPageV.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(settingBtn.snp.bottom)
        }
        
        //
        let searchBtn = UIButton()
        searchBtn.backgroundColor = UIColor(hexString: "#3971FF")
        searchBtn.layer.cornerRadius = 72/2
        searchBtn.clipsToBounds = true
        searchBtn.setTitle("Start Search", for: .normal)
        searchBtn.setTitleColor(.white, for: .normal)
        searchBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        searchLaunchPageV.addSubview(searchBtn)
        searchBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            $0.width.equalTo(300)
            $0.height.equalTo(72)
        }
        searchBtn.addTarget(self, action: #selector(searchBtnClick(sender: )), for: .touchUpInside)
        searchBtn.addShadow(ofColor: UIColor(hexString: "#3971FF")!, radius: 10, offset: CGSize(width: 0, height: 5), opacity: 0.3)
        
        
        //
        let tapBtn = UIButton()
        tapBtn.setTitle("Tap to Scan", for: .normal)
        tapBtn.setTitleColor(UIColor(hexString: "#242766")!.withAlphaComponent(0.7), for: .normal)
        tapBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        tapBtn.contentHorizontalAlignment = .center
        searchLaunchPageV.addSubview(tapBtn)
        tapBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(searchBtn.snp.top).offset(-10)
            $0.width.equalTo(96)
            $0.height.equalTo(22)
        }
        tapBtn.addTarget(self, action: #selector(searchBtnClick(sender: )), for: .touchUpInside)
        
        
        //
        let centerScanAniImgV = UIImageView()
        searchLaunchPageV.addSubview(centerScanAniImgV)
        centerScanAniImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
            $0.width.height.equalTo(UIScreen.main.bounds.width - 60)
        }
        centerScanAniImgV.image = UIImage(named: "scanbganiyuan")
        //
        let scanImgV = UIImageView()
        searchLaunchPageV.addSubview(scanImgV)
        scanImgV.snp.makeConstraints {
            $0.center.equalTo(centerScanAniImgV)
            $0.width.height.equalTo(120)
        }
        scanImgV.image = UIImage(named: "bluescancenter")
        
        //
        let topkongV = UIView()
        searchLaunchPageV.addSubview(topkongV)
        topkongV.backgroundColor = .clear
        topkongV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(centerScanAniImgV.snp.top)
        }
        //
        let blueLabel2 = UILabel()
        searchLaunchPageV.addSubview(blueLabel2)
        blueLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(14)
            $0.centerY.equalTo(topkongV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(24)
        }
        blueLabel2.text = "Find your lost devices"
        blueLabel2.textColor = UIColor(hexString: "#242766")
        blueLabel2.font = UIFont(name: "Poppins", size: 16)
        //
        let blueImgV = UIImageView()
        blueImgV.contentMode = .scaleAspectFit
        searchLaunchPageV.addSubview(blueImgV)
        blueImgV.snp.makeConstraints {
            $0.centerY.equalTo(blueLabel2.snp.centerY)
            $0.right.equalTo(blueLabel2.snp.left).offset(-8)
            $0.width.height.equalTo(24)
        }
        blueImgV.image = UIImage(named: "hometopbluetooth")
        
        
    }
    
    func setupSearchingBottomBanner() {
        
        view.addSubview(searchingBottomV)
        searchingBottomV.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(362)
        }
        searchingBottomV.searchingCloseBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.searchingBottomV.isHidden = true
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
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.showContentSearchVC()
            }
        }
        self.searchingBottomV.isHidden = true
        scanCollectionV.searchAgainClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.searchingBottomV.isHidden = false
            }
        }
    }
    
    @objc func settingBtnClick(sender: UIButton) {
//        let vc = BSiegDeSettingVC()
//        let vc = BSiegDeSubscVC()
        let vc = BSiegDeSplasecVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBtnClick(sender: UIButton) {
        scanCollectionV.isHidden = false
        searchLaunchPageV.isHidden = true
    }
   
    
}

extension ViewController {
    func showContentSearchVC() {
        let vc = BSiegDeviceContentVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
