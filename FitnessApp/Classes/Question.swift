//
//  Question.swift
//  FitnessApp
//
//  Created by Nick Huang on 4/2/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//

import Foundation

class Question {
    //------------------------------------------
    //               Variables
    //------------------------------------------
    
    var questionFields: [String]?
    var questionTemplate: String?
    
    
    //------------------------------------------
    //               Functions
    //------------------------------------------
    
    init(qF: [String], qT: String){
        questionFields = qF
        questionTemplate = qT
    }
}
