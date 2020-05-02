//
//  Quiz.swift
//  FitnessApp
//
//  Created by Nick Huang on 4/2/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//

import Foundation

class Quiz {
    //------------------------------------------
    //               Variables
    //------------------------------------------
    
    var initialQuestionList: [Question] = []
    var sportQL: [Question] = []
    var weightsQL: [Question] = []
    var cardioQL: [Question] = []
    
    
    
    
    
    //------------------------------------------
    //               Functions
    //------------------------------------------
    
    init(){
        createInitialQuestionList()
    }
    
    func createInitialQuestionList(){
        initialQuestionList.append(Question(qF: ["Let's get to know you :)"], qT: "transition"))
        initialQuestionList.append(Question(qF: ["Name"], qT: "general"))
        initialQuestionList.append(Question(qF: ["Height (in)"], qT: "general"))
        initialQuestionList.append(Question(qF: ["Weight (lbs)"], qT: "general"))
        initialQuestionList.append(Question(qF: ["Age"], qT: "general"))
        initialQuestionList.append(Question(qF: ["Gender", "Male", "Female", "Other"], qT: "goal"))
        
        initialQuestionList.append(Question(qF: ["Nice to meet you! Now tell us a little bit about your activity!"], qT: "transition"))
        initialQuestionList.append(Question(qF: ["Activity Level", "Sedentary", "Lightly Active", "Active", "Very Active"], qT: "goal"))
        initialQuestionList.append(Question(qF: ["What is your goal?", "Weightloss", "Bulking", "Leaning", "Feel Good!"], qT: "goal"))
        initialQuestionList.append(Question(qF: ["What sports do you play?", "Soccer", "Basketball", "Tennis", "Swimming", "Football", "Track and Field", "Baseball", "Gymnastics", "Volleyball", "Skating", "Dance", "Other"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What do you currently train?", "Biceps", "Triceps", "Shoulders", "Chest", "Back", "Core", "Glutes", "Hamstrings", "Quads", "Calves"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What other excercises do you do?", "HIIT", "Jogging", "Yoga", "Circuit Training", "Tabata", "Cycling", "Walking", "Other"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What do you want to train?", "Biceps", "Triceps", "Shoulders", "Chest", "Back", "Core", "Glutes", "Hamstrings", "Quads", "Calves"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What other excercises do you want to do?", "HIIT", "Jogging", "Yoga", "Circuit Training", "Tabata", "Cycling", "Walking", "Other"], qT: "exercise"))
    }
}
