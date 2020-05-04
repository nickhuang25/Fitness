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
    var sportsQL: [Question] = []
    var otherExerciseQL: [Question] = []
    
    var name : String = ""
    var height: String = ""
    var weight: String = ""
    var age: String = ""
    var gender: String = ""
    var activityLevel: String = ""
    var goal: String = ""
    var sportsDict: [String:[Double]] = [:]
    var otherExerciseDict: [String:[Double]] = [:]
    var currentMuscles: [String] = []
    var futureExercise: [String] = []
    var futureMuscles: [String] = []
    var weightAccess: Bool = false
    
    
    
    
    
    //------------------------------------------
    //               Functions
    //------------------------------------------
    
    init(){
        createInitialQuestionList()
    }
    
    func createInitialQuestionList(){
        initialQuestionList.append(Question(qF: ["Hi there! Welcome to AIM! We're excited to help you reach all of your fitness goals. Let's start by telling us about yourself :)"], qT: "transition"))
        initialQuestionList.append(Question(qF: ["For starters, what's your name?"], qT: "general"))
        initialQuestionList.append(Question(qF: ["It's nice to meet you! How tall are you? (in)"], qT: "general"))
        initialQuestionList.append(Question(qF: ["How much do you weigh? (lbs)"], qT: "general"))
        initialQuestionList.append(Question(qF: ["How old are you?"], qT: "general"))
        initialQuestionList.append(Question(qF: ["Which of the following best describes you?", "Male", "Female", "Other"], qT: "goal"))
        
        initialQuestionList.append(Question(qF: ["Awesome! Now we want to learn about your activity!"], qT: "transition"))
        initialQuestionList.append(Question(qF: ["How would you describe your activity level?", "Sedentary", "Lightly Active", "Active", "Very Active"], qT: "goal"))
        initialQuestionList.append(Question(qF: ["What can AIM help you with?", "Weightloss", "Bulking", "Leaning", "Feel Good!"], qT: "goal"))
        initialQuestionList.append(Question(qF: ["What sports do you play?", "Soccer", "Basketball", "Tennis", "Swimming", "Football", "Track and Field", "Baseball", "Gymnastics", "Volleyball", "Skating", "Dance", "Other"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What other excercises do you do?", "Muscle Training", "HIIT", "Jogging", "Yoga", "Circuit Training", "Cardio Machine", "Cycling", "Walking", "Other"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What do you currently train?", "Biceps", "Triceps", "Shoulders", "Chest", "Back", "Core", "Glutes", "Hamstrings", "Quads", "Calves"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What other excercises do you want to do?", "Muscle Training", "HIIT", "Jogging", "Yoga", "Circuit Training", "Cardio Machine", "Cycling", "Walking", "Other"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["What do you want to train?", "Biceps", "Triceps", "Shoulders", "Chest", "Back", "Core", "Glutes", "Hamstrings", "Quads", "Calves"], qT: "exercise"))
        initialQuestionList.append(Question(qF: ["Do you have access to a gym or free weights?", "Yes", "No"], qT: "goal"))
        
        initialQuestionList.append(Question(qF: ["Thanks for all the information! We've calculated a workout plan for you for the next month to help you reach your goals :) Let's check out your dashboard together"], qT: "transition"))
    }
}
