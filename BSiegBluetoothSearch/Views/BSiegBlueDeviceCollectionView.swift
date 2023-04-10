//
//  BSiegBlueDeviceCollectionView.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/7.
//

import UIKit

class BSiegBlueDeviceCollectionView: UIView {

    var collection: UICollectionView!
    var myDevices: [Device] = []
    var otherDevices: [Device] = []
    var itemclickBlock: ((Device)->Void)?
    var searchAgainClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentDevice() {
        myDevices = BSiesDeviceManager.default.currentMyDevices
        otherDevices = BSiesDeviceManager.default.otherTrackedDevices
        collection.reloadData()
    }

}

extension BSiegBlueDeviceCollectionView {
    func setupView() {
        backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: BSiegBlueDevicePreviewCell.self)
        collection.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: BSiegBlueHeader.self)
        
        
        //
        let bottomBar = UIView()
        addSubview(bottomBar)
        bottomBar.backgroundColor = .clear
        bottomBar.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(140)
        }
        bottomBar.layer.cornerRadius = 30
        bottomBar.addShadow(ofColor: UIColor(hexString: "#2B2F3C")!, radius: 40, offset: CGSize(width: 0, height: -5), opacity: 0.1)
        //
        let bottomBgImgv = UIImageView()
        bottomBar.addSubview(bottomBgImgv)
        bottomBgImgv.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bottomBgImgv.image = UIImage(named: "bottonbgbanner")
        //
        let searAginBtn = UIButton()
        bottomBar.addSubview(searAginBtn)
        searAginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(60)
        }
        searAginBtn.backgroundColor = UIColor(hexString: "#3971FF")
        searAginBtn.layer.cornerRadius = 30
        searAginBtn.clipsToBounds = true
        searAginBtn.setTitle("Search Again", for: .normal)
        searAginBtn.setTitleColor(.white, for: .normal)
        searAginBtn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        searAginBtn.addTarget(self, action: #selector(searAginBtnClick(sender: )), for: .touchUpInside)
        
        
    }
    
    @objc func searAginBtnClick(sender: UIButton) {
        searchAgainClickBlock?()
    }
    
    
}

extension BSiegBlueDeviceCollectionView: UICollectionViewDataSource {
    
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: BSiegBlueDevicePreviewCell.self, for: indexPath)
        var deviceNameStr = ""
        var describeStr = ""
        var deviceIconStr = ""
        if myDevices.count == 0 && otherDevices.count == 0 {
            
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            let devi = otherDevices[indexPath.item]
            deviceIconStr = devi.deviceTagIconName(isSmall: true)
            deviceNameStr = devi.name
            describeStr = "Approx. \(devi.fetchDistanceString()) away from you"
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            let devi = myDevices[indexPath.item]
            deviceIconStr = devi.deviceTagIconName(isSmall: true)
            deviceNameStr = devi.name
            describeStr = "Approx. \(devi.fetchDistanceString()) away from you"
        } else {
            if indexPath.section == 0 {
                let devi = myDevices[indexPath.item]
                deviceIconStr = devi.deviceTagIconName(isSmall: true)
                deviceNameStr = devi.name
                describeStr = "Approx. \(devi.fetchDistanceString()) away from you"
                cell.favoButton.isSelected = true
            } else {
                let devi = otherDevices[indexPath.item]
                deviceIconStr = devi.deviceTagIconName(isSmall: true)
                deviceNameStr = devi.name
                describeStr = "Approx. \(devi.fetchDistanceString()) away from you"
                cell.favoButton.isSelected = false
            }

        }
        cell.contentImgV.image = UIImage(named: deviceIconStr)
        cell.deviceNameLabel.text = deviceNameStr
        cell.describeLabel.text = describeStr
        cell.favoClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                
            }
        }
         
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myDevices.count == 0 && otherDevices.count == 0 {
            return 0
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            return otherDevices.count
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            return myDevices.count
        } else {
            if section == 0 {
                return myDevices.count
            } else {
                return otherDevices.count
            }
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if myDevices.count == 0 && otherDevices.count == 0 {
            return 0
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            return 1
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            return 1
        } else {
            return 2
        }
        return 1
    }
    
}

extension BSiegBlueDeviceCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 24 * 2, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let bottomOffset: CGFloat = 160
        if myDevices.count == 0 && otherDevices.count == 0 {
            return UIEdgeInsets(top: 10, left: 24, bottom: bottomOffset, right: 24)
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            return UIEdgeInsets(top: 10, left: 24, bottom: bottomOffset, right: 24)
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            return UIEdgeInsets(top: 10, left: 24, bottom: bottomOffset, right: 24)
        } else {
            if section == 0 {
                return UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
            } else {
                return UIEdgeInsets(top: 10, left: 24, bottom: bottomOffset, right: 24)
            }
            
        }
        return UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if myDevices.count == 0 && otherDevices.count == 0 {
            return CGSize(width: 0, height: 0)
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            return CGSize(width: 0, height: 0)
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 64)
        }
        return CGSize(width: UIScreen.main.bounds.size.width, height: 64)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: BSiegBlueHeader.self, for: indexPath)
            if myDevices.count == 0 && otherDevices.count == 0 {

            } else if myDevices.count == 0 && otherDevices.count != 0 {
                
            } else if myDevices.count != 0 && otherDevices.count == 0 {
                
            } else {
                if indexPath.section == 0 {
                    view.tiNameLabel.text = "My Devices"
                } else {
                    view.tiNameLabel.text = "Other Devices"
                }
            }
            return view
        }
        return UICollectionReusableView()
    }
    
}

extension BSiegBlueDeviceCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if myDevices.count == 0 && otherDevices.count == 0 {
            
        } else if myDevices.count == 0 && otherDevices.count != 0 {
            let devi = otherDevices[indexPath.item]
            itemclickBlock?(devi)
        } else if myDevices.count != 0 && otherDevices.count == 0 {
            let devi = myDevices[indexPath.item]
            itemclickBlock?(devi)
        } else {
            if indexPath.section == 0 {
                let devi = myDevices[indexPath.item]
                itemclickBlock?(devi)
            } else {
                let devi = otherDevices[indexPath.item]
                itemclickBlock?(devi)
            }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


class BSiegBlueHeader: UICollectionReusableView {
    let tiNameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(tiNameLabel)
        tiNameLabel.font = UIFont(name: "Poppins-Bold", size: 20)
        tiNameLabel.textColor = UIColor(hexString: "#242766")
        tiNameLabel.textAlignment = .left
        tiNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(10)
            $0.height.greaterThanOrEqualTo(24)
        }
        
    }
    
    
    
}

class BSiegBlueDevicePreviewCell: PZSwipedCollectionViewCell {
    let contentImgV = UIImageView()
    let deviceNameLabel = UILabel()
    let describeLabel = UILabel()
    var favoButton: UIButton!
    var favoClickBlock: (()->Void)?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        //
        let iconbgV = UIView()
        self.addSubview(iconbgV)
        iconbgV.backgroundColor = UIColor(hexString: "#E8EDFF")
        iconbgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
            $0.width.height.equalTo(48)
        }
        iconbgV.layer.cornerRadius = 24
        iconbgV.clipsToBounds = true
        //
        contentImgV.contentMode = .scaleAspectFit
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.center.equalTo(iconbgV)
            $0.width.height.equalTo(32)
        }
        
        //
        
        self.addSubview(deviceNameLabel)
        deviceNameLabel.font = UIFont(name: "Poppins-Bold", size: 14)
        deviceNameLabel.textColor = UIColor(hexString: "#242766")
        deviceNameLabel.lineBreakMode = .byTruncatingTail
        deviceNameLabel.textAlignment = .left
        deviceNameLabel.snp.makeConstraints {
            $0.left.equalTo(iconbgV.snp.right).offset(15)
            $0.top.equalTo(iconbgV.snp.top)
            $0.bottom.equalTo(iconbgV.snp.centerY)
            $0.right.equalToSuperview().offset(-50)
        }
        
        //
        self.addSubview(describeLabel)
        describeLabel.font = UIFont(name: "Poppins", size: 12)
        describeLabel.textColor = UIColor(hexString: "#242766")?.withAlphaComponent(0.5)
//        describeLabel.lineBreakMode = .byTruncatingTail
        describeLabel.adjustsFontSizeToFitWidth = true
        describeLabel.textAlignment = .left
        describeLabel.snp.makeConstraints {
            $0.left.equalTo(iconbgV.snp.right).offset(15)
            $0.top.equalTo(iconbgV.snp.centerY)
            $0.bottom.equalTo(iconbgV.snp.bottom)
            $0.right.equalToSuperview().offset(-50)
        }
        
        //
        let arrowImgV = UIImageView()
        arrowImgV.contentMode = .scaleAspectFit
        arrowImgV.image = UIImage(named: "CaretRight")
        arrowImgV.clipsToBounds = true
        contentView.addSubview(arrowImgV)
        arrowImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-14)
            $0.width.height.equalTo(20)
        }
        //
        favoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: self.bounds.height))
        favoButton.layer.cornerRadius = 20
        favoButton.setBackgroundImage(UIImage(named: "cell_heart_n"), for: .normal)
        favoButton.setBackgroundImage(UIImage(named: "cell_heart_s"), for: .selected)
        favoButton.roundCorners([.topRight, .bottomRight], radius: 20)
        favoButton.addTarget(self, action: #selector(favoButtonSelf), for: .touchUpInside)
        self.revealView = favoButton
    }
    
    @objc func favoButtonSelf() {
        self.hideRevealView(withAnimated: true)
        favoClickBlock?()
    }
    
}


