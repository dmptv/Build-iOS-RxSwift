//
//  AppDelegate.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 22.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import Lightbox
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let disposeBag = DisposeBag()
    
    // RxFlow
    var coordinator = Coordinator()
    var appFlow: AppFlow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        guard let window = self.window else { return false }
        
        coordinator.rx.didNavigate
            .subscribe(onNext: { (flow, step) in
            print ("******** did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        self.appFlow = AppFlow(with: window)
        
        let loggedIn = User.current.isAuthenticated
        
        // ask the Coordinator to coordinate this Flow with a first Step
        if loggedIn {
           
        } else {
            coordinator.coordinate(
                flow: self.appFlow,
                withStepper: OneStepper(withSingleStep: AppStep.login)
            )
        }
        
        IQKeyboardManager.shared.enable = true
        
        LightboxConfig.loadImage = { imageView, url, completion in
            
//            ImageDownloader.download(image: url.absoluteString, completion: { (image) in
//                if let image = image {
//                    imageView.image = image
//                    completion?(image)
//                }
//            })
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}














