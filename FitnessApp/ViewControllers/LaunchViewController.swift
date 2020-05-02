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
    var curr_idx = 0;
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var slideImage: UIImageView!
    
    
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
    
    @IBAction func nextClicked(_ sender: Any) {
        if(curr_idx != quiz.initialQuestionList.count){
            saveAnswers()
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
        }
        else{
            calcAlgorithm()
            performSegue(withIdentifier: "LaunchToDashboard", sender: self)
        }
    }
    
    func populateSlide(curr_question : Question){
        switch (curr_question.questionTemplate){
        case "transition":
            let transition:Transition = Bundle.main.loadNibNamed("Transition", owner: self, options: nil)?.first as! Transition
            transition.transitionLabel.text = curr_question.questionFields![0]
            slideImage.addSubview(transition)
            view.bringSubview(toFront: slideImage)
        case "general":
            let general:General = Bundle.main.loadNibNamed("General", owner: self, options: nil)?.first as! General
            general.generalLabel.text = curr_question.questionFields![0]
            slideImage.addSubview(general)
            view.bringSubview(toFront: slideImage)
        case "goal":
            let goal:Goal = Bundle.main.loadNibNamed("Goal", owner: self, options: nil)?.first as! Goal
            if(curr_question.questionFields!.count > 0){
                goal.goalLabel.text = curr_question.questionFields![0]
            }else{goal.goalLabel.isHidden = true}
            if(curr_question.questionFields!.count > 1){
                goal.goalButton1.setTitle(curr_question.questionFields![1], for: .normal)
                //goal.goalButton1.addTarget(self, action: #selector(darkenG1(_:)), for: .touchUpInside)
            }else{goal.goalButton1.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                goal.goalButton2.setTitle(curr_question.questionFields![2], for: .normal)
                //goal.goalButton2.addTarget(self, action: #selector(darkenG1(_:)), for: .touchUpInside)
            }else{goal.goalButton2.isHidden = true}
            if(curr_question.questionFields!.count > 3){
                goal.goalButton3.setTitle(curr_question.questionFields![3], for: .normal)
                //goal.goalButton3.addTarget(self, action: #selector(darkenG1(_:)), for: .touchUpInside)
            }else{goal.goalButton3.isHidden = true}
            if(curr_question.questionFields!.count > 4){
                goal.goalButton4.setTitle(curr_question.questionFields![4], for: .normal)
                //goal.goalButton4.addTarget(self, action: #selector(darkenG1(_:)), for: .touchUpInside)
            }else{goal.goalButton4.isHidden = true}
            slideImage.addSubview(goal)
            view.bringSubview(toFront: slideImage)
        case "exercise":
            let exercise:Exercise = Bundle.main.loadNibNamed("Exercise", owner: self, options: nil)?.first as! Exercise
            if(curr_question.questionFields!.count > 0){
                exercise.exerciseLabel.text = curr_question.questionFields![0]
            }else{exercise.exerciseLabel.isHidden = true}
            if(curr_question.questionFields!.count > 1){
                exercise.exerciseButton1.setTitle(curr_question.questionFields![1], for: .normal)
                //exercise.exerciseButton1.addTarget(self, action: #selector(darkenG1(_:)), for: .touchUpInside)
            }else{exercise.exerciseButton1.isHidden = true}
            
        default:
            print("You fucked up")
        }
    }
    
//    @objc func darkenG1(sender: UIButton!){
//        print("DARKENED")
//        goal.go
//    }
    
    func saveAnswers(){
        let curr_question = quiz.initialQuestionList[curr_idx]
        switch (curr_question.questionTemplate){
        case "transition":
            print("ahasifoa")
        case "general":
            print("ahasifoa")
        case "goal":
            print("ahasifoa")
        case "exercise":
            print("ahasifoa")
        default:
            print("You fucked up")
        }
    }
    
    func calcAlgorithm(){
        
        
    }
    

}
