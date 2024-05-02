//
//  AppDelegate.swift
//  NoteKeeper
//
//  Created by Rizwan Shaikh on 23/04/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    private func configureWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteListVC") as! NoteListVC
        window?.rootViewController = UINavigationController.init(rootViewController: vc)
        window?.makeKeyAndVisible()
    }

}

