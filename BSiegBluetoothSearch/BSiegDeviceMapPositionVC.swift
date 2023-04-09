//
//  BSiegDeviceMapPositionVC.swift
//  BSiegBluetoothSearch
//
//  Created by Joe on 2023/4/8.
//

import UIKit
import MapKit
import CoreLocation

class BSiegDeviceMapPositionVC: UIViewController {

    let mapView: MKMapView = MKMapView()
    let tiNameLabel = UILabel()
    let infoDevNameLabel = UILabel()
    let infoPostionLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupV()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupLocationPositionNow()
    }
    
    func setupLocationPositionNow() {
        
    }
    
    func setupV() {
        view.clipsToBounds = true
        //
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        let backB = UIButton()
        view.addSubview(backB)
        backB.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.width.height.equalTo(44)
        }
        backB.setImage(UIImage(named: "nav_back"), for: .normal)
        backB.addTarget(self, action: #selector(backBClick(sender: )), for: .touchUpInside)
        
        //
        
        view.addSubview(tiNameLabel)
        tiNameLabel.snp.makeConstraints {
            $0.left.equalTo(backB.snp.right).offset(20)
            $0.centerY.equalTo(backB.snp.centerY).offset(0)
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(17)
        }
        tiNameLabel.lineBreakMode = .byTruncatingTail
        tiNameLabel.text = "Device Name"
        tiNameLabel.textAlignment = .center
        tiNameLabel.textColor = UIColor(hexString: "#242766")
        tiNameLabel.font = UIFont(name: "Poppins", size: 24)
        
        //
        setupSearchAgainV()
    }
    
    func setupSearchAgainV() {
        //
        let bottomBar = UIView()
        view.addSubview(bottomBar)
        bottomBar.backgroundColor = .clear
        bottomBar.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(190)
        }
        bottomBar.layer.cornerRadius = 30
        bottomBar.addShadow(ofColor: UIColor(hexString: "#2B2F3C")!, radius: 40, offset: CGSize(width: 0, height: -5), opacity: 0.1)
        //
        let bottomBgImgv = UIImageView()
        bottomBar.addSubview(bottomBgImgv)
        bottomBgImgv.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bottomBgImgv.image = UIImage(named: "mapbottom")
        //
        let founditBtn = UIButton()
        bottomBar.addSubview(founditBtn)
        founditBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(60)
        }
        founditBtn.backgroundColor = UIColor(hexString: "#3971FF")
        founditBtn.layer.cornerRadius = 30
        founditBtn.clipsToBounds = true
        founditBtn.setTitle("I Found It!", for: .normal)
        founditBtn.setTitleColor(.white, for: .normal)
        founditBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        founditBtn.addTarget(self, action: #selector(founditBtnClick(sender: )), for: .touchUpInside)
        
        //
        
        bottomBar.addSubview(infoDevNameLabel)
        infoDevNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(24)
            $0.width.height.greaterThanOrEqualTo(17)
        }
        infoDevNameLabel.lineBreakMode = .byTruncatingTail
        infoDevNameLabel.text = "Device Name"
        infoDevNameLabel.textAlignment = .center
        infoDevNameLabel.textColor = UIColor(hexString: "#242766")
        infoDevNameLabel.font = UIFont(name: "Poppins", size: 16)
        
        //
        
        bottomBar.addSubview(infoPostionLabel)
        infoPostionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(infoDevNameLabel.snp.bottom)
            $0.bottom.equalTo(founditBtn.snp.top).offset(-2)
            $0.centerX.equalToSuperview()
        }
        infoPostionLabel.numberOfLines = 0
        infoPostionLabel.text = "meilan District, haikou City, hainan Province, China"
        infoPostionLabel.textAlignment = .left
        infoPostionLabel.textColor = UIColor(hexString: "#242766")!.withAlphaComponent(0.5)
        infoPostionLabel.font = UIFont(name: "Poppins", size: 12)
        infoPostionLabel.adjustsFontSizeToFitWidth = true
    }

    
    
    
    @objc func backBClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func founditBtnClick(sender: UIButton) {
        
         
    }
    
}
