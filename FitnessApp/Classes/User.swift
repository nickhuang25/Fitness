//
//  User.swift
//  FitnessApp
//
//  Created by Nick Huang on 4/2/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//

import Foundation

class User : NSObject, NSCoding{
    //------------------------------------------
    //               Variables
    //------------------------------------------
    
    var name: String = ""
    var startDate: Date?
    var workoutPlan: [[String]] = [[]]
    var dietPlan: [[String]] = [[]]
    var motivation: [String] = []
    
    
    struct PropertyKey{
        static let name = "name"
        static let startDate = "startDate"
        static let workoutPlan = "workoutPlan"
        static let dietPlan = "dietPlan"
        static let motivation = "motivation"
        
    }
    
    static let DocumentsDirectory = FileManager().urls(for:. documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    
    //------------------------------------------
    //               Functions
    //------------------------------------------
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(startDate, forKey: PropertyKey.startDate)
        coder.encode(workoutPlan, forKey: PropertyKey.workoutPlan)
        coder.encode(dietPlan, forKey: PropertyKey.dietPlan)
        coder.encode(motivation, forKey: PropertyKey.motivation)
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: PropertyKey.name) as? String
        let startDate = coder.decodeObject(forKey: PropertyKey.startDate) as? Date
        let workoutPlan = coder.decodeObject(forKey: PropertyKey.workoutPlan) as? [[String]]
        let dietPlan = coder.decodeObject(forKey: PropertyKey.dietPlan) as? [[String]]
        let motivation = coder.decodeObject(forKey: PropertyKey.motivation) as? [String]
        self.init(name: name!, startDate: startDate!, workoutPlan: workoutPlan!, dietPlan: dietPlan!, motivation: motivation!)
        
    }
    
    init(name: String, startDate: Date, workoutPlan: [[String]], dietPlan: [[String]], motivation: [String]){
        self.name = name
        self.startDate = startDate
        self.workoutPlan = workoutPlan
        self.dietPlan = dietPlan
        self.motivation = motivation
    }
    
    
    
}
