//
//  BSiegDeSettingVC.swift
//  BSiegBluetoothSearch
//
//  Created by Joe on 2023/4/8.
//

import UIKit

class BSiegDeSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func setupViews() {
        view.clipsToBounds = true
        //
        let bgImgV = UIImageView()
        view.addSubview(bgImgV)
        bgImgV.image = UIImage(named: "home")
        bgImgV.snp.makeConstraints {
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
        let tiNameLabel = UILabel()
        view.addSubview(tiNameLabel)
        tiNameLabel.snp.makeConstraints {
            $0.left.equalTo(backB.snp.right).offset(20)
            $0.centerY.equalTo(backB.snp.centerY).offset(0)
            $0.centerX.equalToSuperview()
            $0.height.greaterThanOrEqualTo(17)
        }
        tiNameLabel.lineBreakMode = .byTruncatingTail
        tiNameLabel.text = "Settings"
        tiNameLabel.textAlignment = .center
        tiNameLabel.textColor = UIColor(hexString: "#242766")
        tiNameLabel.font = UIFont(name: "Poppins-Bold", size: 24)
        
        //
        
        //
        let subBtn = UIButton()
        subBtn.backgroundColor = .white
        subBtn.layer.cornerRadius = 20
        view.addSubview(subBtn)
        subBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.top.equalTo(backB.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64)
        }
        subBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        subBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        subBtn.setImage(UIImage(named: "wangguan"), for: .normal)
        subBtn.setTitle( "To Unlock All Features", for: .normal)
        subBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        subBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        subBtn.contentHorizontalAlignment = .left
        subBtn.addTarget(self, action: #selector(subscribeBClick(sender: )), for: .touchUpInside)
        //
        let shareBgV = UIView()
        view.addSubview(shareBgV)
        shareBgV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subBtn.snp.bottom).offset(20)
            $0.height.equalTo(128)
        }
        shareBgV.backgroundColor = .white
        shareBgV.layer.cornerRadius = 20
        
        //
        let shareBgLine = UIView()
        shareBgV.addSubview(shareBgLine)
        shareBgLine.backgroundColor = UIColor(hexString: "#F2F4F9")
        shareBgLine.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
        }
        
        //
        let shareBtn = UIButton()
        shareBtn.backgroundColor = .clear
        shareBtn.layer.cornerRadius = 20
        shareBgV.addSubview(shareBtn)
        shareBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
        }
        shareBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        shareBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        shareBtn.setImage(UIImage(named: "share"), for: .normal)
        shareBtn.setTitle( "Share", for: .normal)
        shareBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        shareBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        shareBtn.contentHorizontalAlignment = .left
        shareBtn.addTarget(self, action: #selector(shareBClick(sender: )), for: .touchUpInside)
        //
        let morehelpBtn = UIButton()
        morehelpBtn.backgroundColor = .clear
        morehelpBtn.layer.cornerRadius = 20
        shareBgV.addSubview(morehelpBtn)
        morehelpBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(64)
        }
        morehelpBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        morehelpBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        morehelpBtn.setImage(UIImage(named: "file-question"), for: .normal)
        morehelpBtn.setTitle( "More Help", for: .normal)
        morehelpBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        morehelpBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        morehelpBtn.contentHorizontalAlignment = .left
        
        //
        //
        let privacyBgV = UIView()
        view.addSubview(privacyBgV)
        privacyBgV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(shareBgV.snp.bottom).offset(20)
            $0.height.equalTo(128)
        }
        privacyBgV.backgroundColor = .white
        privacyBgV.layer.cornerRadius = 20
        
        //
        let privacyBgLine1 = UIView()
        privacyBgV.addSubview(privacyBgLine1)
        privacyBgLine1.backgroundColor = UIColor(hexString: "#F2F4F9")
        privacyBgLine1.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
        }
        //
        let privacyBtn = UIButton()
        privacyBtn.backgroundColor = .clear
        privacyBtn.layer.cornerRadius = 20
        privacyBgV.addSubview(privacyBtn)
        privacyBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
        }
        privacyBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        privacyBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        privacyBtn.setImage(UIImage(named: "lock-alt"), for: .normal)
        privacyBtn.setTitle( "Privacy Policy", for: .normal)
        privacyBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        privacyBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        privacyBtn.contentHorizontalAlignment = .left
        privacyBtn.addTarget(self, action: #selector(privacyBClick(sender: )), for: .touchUpInside)
        //
        let termsBtn = UIButton()
        termsBtn.backgroundColor = .clear
        termsBtn.layer.cornerRadius = 20
        privacyBgV.addSubview(termsBtn)
        termsBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(64)
        }
        termsBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        termsBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        termsBtn.setImage(UIImage(named: "file-alt"), for: .normal)
        termsBtn.setTitle( "Terms of use", for: .normal)
        termsBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        termsBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        termsBtn.contentHorizontalAlignment = .left
        termsBtn.addTarget(self, action: #selector(termsBClick(sender: )), for: .touchUpInside)
        
        
        //
        let restoreBtn = UIButton()
        restoreBtn.backgroundColor = .white
        restoreBtn.layer.cornerRadius = 20
        view.addSubview(restoreBtn)
        restoreBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.top.equalTo(privacyBgV.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64)
        }
        restoreBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        restoreBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        restoreBtn.setImage(UIImage(named: "file-alt"), for: .normal)
        restoreBtn.setTitle( "Restore", for: .normal)
        restoreBtn.setTitleColor(UIColor(hexString: "#242766"), for: .normal)
        restoreBtn.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        restoreBtn.contentHorizontalAlignment = .left
        restoreBtn.addTarget(self, action: #selector(restoreBClick(sender: )), for: .touchUpInside)
    }

    
    @objc func backBClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func subscribeBClick(sender: UIButton) {
        
    }
    @objc func shareBClick(sender: UIButton) {
        
    }
    @objc func morehelpBClick(sender: UIButton) {
        
    }
    @objc func privacyBClick(sender: UIButton) {
        
    }
    @objc func termsBClick(sender: UIButton) {
        
    }
    @objc func restoreBClick(sender: UIButton) {
        
    }
    
}
