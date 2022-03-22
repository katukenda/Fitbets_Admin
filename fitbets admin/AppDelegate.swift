//
//  AppDelegate.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc: UIViewController?
        if TokenService.tokenInstance.checkForLogin(){
          //
            
            
//
   }
        else {
//            vc = HomeViewController()
//            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                   let login = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//                   self.window?.rootViewController = login
        }
        
        //let navVC = UINavigationController(rootViewController: vc!)
//        let navVC = UINavigationController(rootViewController: vc!)
//        window?.rootViewController = navVC
//        window?.makeKeyAndVisible()
        return true
    }
    

}

