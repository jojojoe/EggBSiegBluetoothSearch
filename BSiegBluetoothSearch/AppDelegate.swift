//
//  AppDelegate.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    com.xx.888888
//    com.superegg.okeydokey
//    com.find.cellphones

    
    /*
     内购版本再改：
     1:加引导页；
     2:让蓝牙扫描的时间稍微长点【6～8秒】，现在时间有点太短了；
     3:在扫描完成后弹星评；
     4:寻找设备界面播放声音和震动，点击后要有颜色；寻找设备界面 图标和文字都调整的大点；
     5:付费逻辑：用户在每次次首次扫描完成后弹订阅面，如果用户没有退出app，在重复扫描后就不用弹订阅了【这块仿照竞品】；
     进入找设备页面，震动可以正常使用，声音和定位卡订阅；
     */
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
for fy in UIFont.familyNames {
    let fts = UIFont.fontNames(forFamilyName: fy)
    for ft in fts {
        debugPrint("***fontName = \(ft)")
    }
}
        
#endif
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

public class Once {
    var already: Bool = false
    
    public init() {}
    
    public func run(_ block: () -> Void) {
        guard !already else {
            return
        }
        
        block()
        already = true
    }
}





