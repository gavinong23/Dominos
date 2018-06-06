//
//  AppDelegate.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setup()
        setupCart()
    
        return true
    }
    
    func setup(){
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        ScreenSaverTimer.sharedTimer.startTimer()
        tapGesture.delegate = self
        window?.addGestureRecognizer(tapGesture)
    }
    
    func setupCart(){
        
       let cartService = CartService()
        
        cartService.setCart()
    
    
      
        
        //let cartService = CartService()
        //let pizzaDetailViewData = PizzaDetailViewData()
        
       // cartService.addToCart(model: pizzaDetailViewData)
//        cartService.setCart()
//        let userDefaults = UserDefaults.standard
//
//        userDefaults.removeObject(forKey: Config.preferenceKey.cartModels)
//
//        if userDefaults.object(forKey: Config.preferenceKey.cartModels) == nil{
//            let pizzaDetailViewData = [PizzaDetailViewData]()
//
//            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject:  pizzaDetailViewData)
//            userDefaults.set(encodedData, forKey: Config.preferenceKey.cartModels)
//            userDefaults.synchronize()
//        }else{
//
//          if let savedCartItems = userDefaults.object(forKey: Config.preferenceKey.cartModels) as? Data {
//            let decoder = JSONDecoder()
//
//                if let loadedCartItems = try? decoder.decode([PizzaDetailViewData].self, from: savedCartItems) {
//
//                    Global.sharedManager.sharedGlobalCart.append(contentsOf: loadedCartItems)
//                }
//
//            }
//
//            userDefaults.synchronize()
//        }
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

extension AppDelegate: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        ScreenSaverTimer.sharedTimer.resetTimer()
        
        return false
    }
}

