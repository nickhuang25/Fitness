//
//  LaunchViewController.swift
//  FitnessApp
//
//  Created by Alice Ying on 3/7/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    //------------------------------------------
    //         Variables
    //------------------------------------------
    var user = User()
    var quiz = Quiz()
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    //------------------------------------------
    //         View Functions
    //------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool){
        nextStep()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }
        else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func nextStep(){
        if(isAppAlreadyLaunchedOnce() == false){
            print("LAUNCH QUIZ")
            print("QUIZ FINISHED")
        }
        else{
            print("RETRIEVE USER OBJECT")
            print("USER OBJECT RETRIEVED")
        }
        performSegue(withIdentifier: "LaunchToDashboard", sender: self)
    }
    
    //------------------------------------------
    //         Transition Functions
    //------------------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LaunchToDashboard" {
            let nextView = segue.destination as! DashboardViewController
            nextView.user = self.user
        }

    }
    
    //------------------------------------------
    //         Quiz Functions
    //------------------------------------------
    
    

}

