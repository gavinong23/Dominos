//
//  AppDelegate.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        setup()
        setupCart()
        setupAddressIDAndUserID()
        setupGoogleMapAPI()
        setupPaypal()
        
        return true
    }
    
    func setup(){
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        ScreenSaverTimer.sharedTimer.startTimer()
        tapGesture.delegate = self
        window?.addGestureRecognizer(tapGesture)
    }
    
    func setupPaypal(){
    
        PayPalMobile.initializeWithClientIds(forEnvironments:[PayPalEnvironmentProduction: "ATXB2d3cy1s7gTQoQtg6iVkNrDLS60ZkK5t-HIyxo3VX1JB3jusybV_9HwN05FZJEN3lTIz_eY3v4SQs",
                                                               PayPalEnvironmentSandbox: "ATXB2d3cy1s7gTQoQtg6iVkNrDLS60ZkK5t-HIyxo3VX1JB3jusybV_9HwN05FZJEN3lTIz_eY3v4SQs"])
    }
    
    func setupCart(){
       let cartService = CartService()
        cartService.setCart()
    }
    
    func setupAddressIDAndUserID(){
        let userService = UserService()
        userService.setAddressID()
//        userService.setUserID()
        userService.updateUserID(userID: "1")
        
        print("User ID: \(userService.retrieveUserID())")
    }

    func setupGoogleMapAPI(){
        let locationService = LocationService()
        locationService.setupGoogleMapAPI()
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

