//
//  LaunchViewController.swift
//  FitnessApp
//
//  Created by Alice Ying on 3/7/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, UIScrollViewDelegate{
    
    //------------------------------------------
    //         Variables
    //------------------------------------------
    var user = User()
    var quiz = Quiz()
    var curr_idx = 0;
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var slideImage: UIScrollView!
    
    
    //------------------------------------------
    //         View Functions
    //------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        slideImage.delegate = self
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
            takeQuiz()
        }
        else{
            print("RETRIEVE USER OBJECT")
            print("USER OBJECT RETRIEVED")
            performSegue(withIdentifier: "LaunchToDashboard", sender: self)
        }
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
    
    func takeQuiz(){
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1;
    }
    
    func populateSlide(curr_question : Question){
        switch (curr_question.questionTemplate){
        case "transition":
            let transition:Transition = Bundle.main.loadNibNamed("Transition", owner: self, options: nil)?.first as! Transition
            transition.transitionLabel.text = curr_question.questionFields![0]
            transition.transitionNext.addTarget(self, action: #selector(self.transitionNextClicked), for: .touchUpInside)
            slideImage.addSubview(transition)
            view.bringSubview(toFront: slideImage)
        case "general":
            let general:General = Bundle.main.loadNibNamed("General", owner: self, options: nil)?.first as! General
            general.generalLabel.text = curr_question.questionFields![0]
            general.generalNext.addTarget(self, action: #selector(self.generalNextClicked), for: .touchUpInside)
            slideImage.addSubview(general)
            view.bringSubview(toFront: slideImage)
        case "goal":
            let goal:Goal = Bundle.main.loadNibNamed("Goal", owner: self, options: nil)?.first as! Goal
            if(curr_question.questionFields!.count > 0){
                goal.goalLabel.text = curr_question.questionFields![0]
            }else{goal.goalLabel.isHidden = true}
            if(curr_question.questionFields!.count > 1){
                goal.goalButton1.setTitle(curr_question.questionFields![1], for: .normal)
                goal.goalButton1.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{goal.goalButton1.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                goal.goalButton2.setTitle(curr_question.questionFields![2], for: .normal)
                goal.goalButton2.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{goal.goalButton2.isHidden = true}
            if(curr_question.questionFields!.count > 3){
                goal.goalButton3.setTitle(curr_question.questionFields![3], for: .normal)
                goal.goalButton3.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{goal.goalButton3.isHidden = true}
            if(curr_question.questionFields!.count > 4){
                goal.goalButton4.setTitle(curr_question.questionFields![4], for: .normal)
                goal.goalButton4.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{goal.goalButton4.isHidden = true}
            goal.goalNext.addTarget(self, action: #selector(self.goalNextClicked), for: .touchUpInside)
            slideImage.addSubview(goal)
            view.bringSubview(toFront: slideImage)
        case "exercise":
            let exercise:Exercise = Bundle.main.loadNibNamed("Exercise", owner: self, options: nil)?.first as! Exercise
            if(curr_question.questionFields!.count > 0){
                exercise.exerciseLabel.text = curr_question.questionFields![0]
            }else{exercise.exerciseLabel.isHidden = true}
            if(curr_question.questionFields!.count > 1){
                exercise.exerciseButton1.setTitle(curr_question.questionFields![1], for: .normal)
                exercise.exerciseButton1.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton1.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                exercise.exerciseButton2.setTitle(curr_question.questionFields![2], for: .normal)
                exercise.exerciseButton2.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton2.isHidden = true}
            if(curr_question.questionFields!.count > 3){
                exercise.exerciseButton3.setTitle(curr_question.questionFields![3], for: .normal)
                exercise.exerciseButton3.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton3.isHidden = true}
            if(curr_question.questionFields!.count > 4){
                exercise.exerciseButton4.setTitle(curr_question.questionFields![4], for: .normal)
                exercise.exerciseButton4.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton4.isHidden = true}
            if(curr_question.questionFields!.count > 5){
                exercise.exerciseButton5.setTitle(curr_question.questionFields![5], for: .normal)
                exercise.exerciseButton5.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton5.isHidden = true}
            if(curr_question.questionFields!.count > 6){
                exercise.exerciseButton6.setTitle(curr_question.questionFields![6], for: .normal)
                exercise.exerciseButton6.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton6.isHidden = true}
            if(curr_question.questionFields!.count > 7){
                exercise.exerciseButton7.setTitle(curr_question.questionFields![7], for: .normal)
                exercise.exerciseButton7.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton7.isHidden = true}
            if(curr_question.questionFields!.count > 8){
                exercise.exerciseButton8.setTitle(curr_question.questionFields![8], for: .normal)
                exercise.exerciseButton8.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton8.isHidden = true}
            if(curr_question.questionFields!.count > 9){
                exercise.exerciseButton9.setTitle(curr_question.questionFields![9], for: .normal)
                exercise.exerciseButton9.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton9.isHidden = true}
            if(curr_question.questionFields!.count > 10){
                exercise.exerciseButton10.setTitle(curr_question.questionFields![10], for: .normal)
                exercise.exerciseButton10.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton10.isHidden = true}
            if(curr_question.questionFields!.count > 11){
                exercise.exerciseButton11.setTitle(curr_question.questionFields![11], for: .normal)
                exercise.exerciseButton11.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton11.isHidden = true}
            if(curr_question.questionFields!.count > 12){
                exercise.exerciseButton12.setTitle(curr_question.questionFields![12], for: .normal)
                exercise.exerciseButton12.addTarget(self, action: #selector(self.darken), for: .touchUpInside)
            }else{exercise.exerciseButton12.isHidden = true}
            exercise.exerciseNext.addTarget(self, action: #selector(self.exerciseNextClicked), for: .touchUpInside)
            slideImage.addSubview(exercise)
            view.bringSubview(toFront: slideImage)
            
        default:
            print("You fucked up")
        }
    }
    
    @objc func darken(_ sender: UIButton!){
        print("DARKENED")
        if(sender.isSelected){
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
    }
    
    @objc func generalNextClicked(_ sender: UIButton!){
        let save_question = quiz.initialQuestionList[curr_idx-1]
        let sub: UIView? = sender.superview
        let gen = sub as! General
        switch(save_question.questionFields![0]){
        case "For starters, what's your name?":
            quiz.name = gen.generalTextField.text!
            print(quiz.name)
        case "It's nice to meet you! How tall are you? (in)":
            quiz.height = gen.generalTextField.text!
            print(quiz.height)
        case "How much do you weigh? (lbs)":
            quiz.weight = gen.generalTextField.text!
            print(quiz.weight)
        case "How old are you?":
            quiz.age = gen.generalTextField.text!
            print(quiz.age)
        default:
            print("Failed on saving generalNextClicked")
        }
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1
    }
    
    @objc func goalNextClicked(_ sender: UIButton!){
        let save_question = quiz.initialQuestionList[curr_idx-1]
        let sub: UIView? = sender.superview
        let goal = sub as! Goal
        switch(save_question.questionFields![0]){
        case "Which of the following best describes you?":
            if(goal.goalButton1.isSelected){quiz.gender = "Male"}
            else if(goal.goalButton2.isSelected){quiz.gender = "Female"}
            else{quiz.gender = "Other"}
            print(quiz.gender)
        case "How would you describe your activity level?":
            if(goal.goalButton1.isSelected){quiz.activityLevel = "Sedentary"}
            else if(goal.goalButton2.isSelected){quiz.activityLevel = "Lightly Active"}
            else if(goal.goalButton3.isSelected){quiz.activityLevel = "Active"}
            else{quiz.activityLevel = "Very Active"}
            print(quiz.activityLevel)
        case "What can AIM help you with?":
            if(goal.goalButton1.isSelected){quiz.goal = "Weightloss"}
            else if(goal.goalButton2.isSelected){quiz.goal = "Bulking"}
            else if(goal.goalButton3.isSelected){quiz.goal = "Leaning"}
            else{quiz.goal = "Feel Good!"}
            print(quiz.goal)
        case "Do you have access to a gym or free weights?":
            if(goal.goalButton1.isSelected){quiz.weightAccess = true}
            else{quiz.weightAccess = false}
            print(quiz.weightAccess)
        default:
            print("Failed on saving generalNextClicked")
        }
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1
    }
    
    @objc func exerciseNextClicked(_ sender: UIButton!){
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1
    }
    
    @objc func metricsNextClicked(_ sender: UIButton!){
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1
    }
    
    @objc func transitionNextClicked(_ sender: UIButton!){
        if(curr_idx == quiz.initialQuestionList.count){
            calcAlgorithm()
            performSegue(withIdentifier: "LaunchToDashboard", sender: self)
        }
        else{
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
        }
    }
    
    func calcAlgorithm(){
        
        
    }
    

}
