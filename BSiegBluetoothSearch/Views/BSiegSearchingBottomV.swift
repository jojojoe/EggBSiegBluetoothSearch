//
//  BSiegSearchingBottomV.swift
//  BSiegBluetoothSearch
//
//  Created by Joe on 2023/4/8.
//

import UIKit

class BSiegSearchingBottomV: UIView {
    
    let searchingBottomV = UIView()
    let searingCountInfoLabel = UILabel()
    var searchingCloseBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        //
        
        addSubview(searchingBottomV)
        searchingBottomV.backgroundColor = .clear
        searchingBottomV.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        searchingBottomV.clipsToBounds = false
        searchingBottomV.layer.cornerRadius = 30
        searchingBottomV.addShadow(ofColor: UIColor(hexString: "#2B2F3C")!, radius: 40, offset: CGSize(width: 0, height: -5), opacity: 0.1)
        //
        let bottomBgImgv = UIImageView()
        searchingBottomV.addSubview(bottomBgImgv)
        bottomBgImgv.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bottomBgImgv.image = UIImage(named: "Framebbanner")
        //
        let searingCloseBtn = UIButton()
        searchingBottomV.addSubview(searingCloseBtn)
        searingCloseBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.width.height.equalTo(40)
        }
        searingCloseBtn.setImage(UIImage(named: "icbackclo"), for: .normal)
        searingCloseBtn.addTarget(self, action: #selector(searchingCloseBtnClick(sender: )), for: .touchUpInside)
        
        //
        let centerScanAniImgV = UIImageView()
        searchingBottomV.addSubview(centerScanAniImgV)
        centerScanAniImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.width.height.equalTo(200)
        }
        centerScanAniImgV.image = UIImage(named: "scanbganiyuan")
        //
        let scanImgV = UIImageView()
        searchingBottomV.addSubview(scanImgV)
        scanImgV.snp.makeConstraints {
            $0.center.equalTo(centerScanAniImgV)
            $0.width.height.equalTo(120)
        }
        scanImgV.image = UIImage(named: "bluescancenter")
        
        //
        let searingLabel1 = UILabel()
        searchingBottomV.addSubview(searingLabel1)
        searingLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(centerScanAniImgV.snp.bottom).offset(30)
            $0.width.height.greaterThanOrEqualTo(22)
        }
        searingLabel1.text = "Searching..."
        searingLabel1.textColor = UIColor(hexString: "#242766")
        searingLabel1.font = UIFont(name: "Poppins-Bold", size: 20)
        
        //
        
        searchingBottomV.addSubview(searingCountInfoLabel)
        searingCountInfoLabel.text = "7 nearby devices found"
        searingCountInfoLabel.font = UIFont(name: "Poppins", size: 12)
        searingCountInfoLabel.textColor = UIColor(hexString: "#242766")?.withAlphaComponent(0.5)
        searingCountInfoLabel.textAlignment = .center
        searingCountInfoLabel.adjustsFontSizeToFitWidth = true
        searingCountInfoLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(searingLabel1.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(10)
        }

    }
    
    func updateSearingCountInfoLabel() {
        
        searingCountInfoLabel.text = "\(BSiesDeviceManager.default.scannedDevices.count) nearby devices found"
    }
    
    
    @objc func searchingCloseBtnClick(sender: UIButton) {
        
        searchingCloseBlock?()
    }
    

}
