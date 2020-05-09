//
//  LaunchViewController.swift
//  FitnessApp
//
//  Created by Alice Ying on 3/7/20.
//  Copyright © 2020 Alice Ying. All rights reserved.
//



import UIKit

class LaunchViewController: UIViewController, UIScrollViewDelegate {
    
    //------------------------------------------
    //         Variables
    //------------------------------------------
    var firstLaunch: Bool = true
    var user: User?
    var quiz = Quiz()
    var curr_idx = 0;
    var sports_idx = 0;
    var otherExercise_idx = 0;
    
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
        firstLaunch = isAppAlreadyLaunchedOnce()
        if(firstLaunch == false){
            print("LAUNCH QUIZ")
            takeQuiz()
        }
        else{
            print("RETRIEVE USER OBJECT")
            user = loadUserData()
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
    //         User Data Functions
    //------------------------------------------
    
    private func saveUserData(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(user as Any, toFile: User.ArchiveURL.path)
        if(isSuccessfulSave){
            print("User data successfully saved")
        }
        else{
            print("Failed to save user data")
        }
    }
    
    private func loadUserData() -> User{
        return (NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User)!
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
            transition.transitionContent.text = curr_question.questionFields![1]
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
                goal.goalButton1.layer.cornerRadius = 5.0
                goal.goalButton1.addTarget(self, action: #selector(self.grow), for: .touchUpInside)
            }else{goal.goalButton1.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                goal.goalButton2.setTitle(curr_question.questionFields![2], for: .normal)
                goal.goalButton2.layer.cornerRadius = 5.0
                goal.goalButton2.addTarget(self, action: #selector(self.grow), for: .touchUpInside)
            }else{goal.goalButton2.isHidden = true}
            if(curr_question.questionFields!.count > 3){
                goal.goalButton3.setTitle(curr_question.questionFields![3], for: .normal)
                goal.goalButton3.layer.cornerRadius = 5.0
                goal.goalButton3.addTarget(self, action: #selector(self.grow), for: .touchUpInside)
            }else{goal.goalButton3.isHidden = true}
            if(curr_question.questionFields!.count > 4){
                goal.goalButton4.setTitle(curr_question.questionFields![4], for: .normal)
                goal.goalButton4.layer.cornerRadius = 5.0
                goal.goalButton4.addTarget(self, action: #selector(self.grow), for: .touchUpInside)
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
                exercise.exerciseButton1.setImage(UIImage(named: curr_question.questionFields![1]), for: .normal)
                exercise.exerciseButton1.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton1.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                exercise.exerciseButton2.setImage(UIImage(named: curr_question.questionFields![2]), for: .normal)
                exercise.exerciseButton2.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton2.isHidden = true}
            if(curr_question.questionFields!.count > 3){
                exercise.exerciseButton3.setImage(UIImage(named: curr_question.questionFields![3]), for: .normal)
                exercise.exerciseButton3.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton3.isHidden = true}
            if(curr_question.questionFields!.count > 4){
                exercise.exerciseButton4.setImage(UIImage(named: curr_question.questionFields![4]), for: .normal)
                exercise.exerciseButton4.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton4.isHidden = true}
            if(curr_question.questionFields!.count > 5){
                exercise.exerciseButton5.setImage(UIImage(named: curr_question.questionFields![5]), for: .normal)
                exercise.exerciseButton5.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton5.isHidden = true}
            if(curr_question.questionFields!.count > 6){
                exercise.exerciseButton6.setImage(UIImage(named: curr_question.questionFields![6]), for: .normal)
                exercise.exerciseButton6.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton6.isHidden = true}
            if(curr_question.questionFields!.count > 7){
                exercise.exerciseButton7.setImage(UIImage(named: curr_question.questionFields![7]), for: .normal)
                exercise.exerciseButton7.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton7.isHidden = true}
            if(curr_question.questionFields!.count > 8){
                exercise.exerciseButton8.setImage(UIImage(named: curr_question.questionFields![8]), for: .normal)
                exercise.exerciseButton8.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton8.isHidden = true}
            if(curr_question.questionFields!.count > 9){
                exercise.exerciseButton9.setImage(UIImage(named: curr_question.questionFields![9]), for: .normal)
                exercise.exerciseButton9.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton9.isHidden = true}
            if(curr_question.questionFields!.count > 10){
                exercise.exerciseButton10.setImage(UIImage(named: curr_question.questionFields![10]), for: .normal)
                exercise.exerciseButton10.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton10.isHidden = true}
            if(curr_question.questionFields!.count > 11){
                exercise.exerciseButton11.setImage(UIImage(named: curr_question.questionFields![11]), for: .normal)
                exercise.exerciseButton11.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton11.isHidden = true}
            if(curr_question.questionFields!.count > 12){
                exercise.exerciseButton12.setImage(UIImage(named: curr_question.questionFields![12]), for: .normal)
                exercise.exerciseButton12.addTarget(self, action: #selector(self.flip), for: .touchUpInside)
            }else{exercise.exerciseButton12.isHidden = true}
            exercise.exerciseNext.addTarget(self, action: #selector(self.exerciseNextClicked), for: .touchUpInside)
            slideImage.addSubview(exercise)
            view.bringSubview(toFront: slideImage)
        case "metrics":
            let metrics:Metrics = Bundle.main.loadNibNamed("Metrics", owner: self, options: nil)?.first as! Metrics
            if(curr_question.questionFields!.count > 0){
                metrics.sportLabel.text = curr_question.questionFields![0]
            }else{metrics.sportLabel.isHidden = true}
            if(curr_question.questionFields!.count > 1){
                metrics.intensityLabel.text = curr_question.questionFields![1]
            }else{metrics.intensityLabel.isHidden = true}
            if(curr_question.questionFields!.count > 2){
                metrics.durationLabel.text = curr_question.questionFields![2]
            }else{metrics.durationLabel.isHidden = true}
            metrics.durationSlider.addTarget(self, action: #selector(self.durationSliderChanged), for: .allTouchEvents)
            metrics.metricNext.addTarget(self, action: #selector(self.metricsNextClicked), for: .touchUpInside)
            slideImage.addSubview(metrics)
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
    
    @objc func flip(_ sender: UIButton!){
        print("DARKENED")
        if(sender.isSelected){
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
    }
    
    @objc func grow(_ sender: UIButton!){
        print("GROWN")
        if(sender.isSelected){
            sender.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y, width: 300, height: 90)
            sender.isSelected = false
        }
        else{
            sender.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y, width: 350, height: 90)
            sender.isSelected = true
        }
    }
    
    @objc func durationSliderChanged(_ sender: UISlider!){
        print("Slider Value Updated")
        let sub: UIView? = sender.superview
        let metrics = sub as! Metrics
        metrics.durationValue.text = "\(Int(round(metrics.durationSlider.value)))"
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
            if(goal.goalButton1.isSelected){quiz.goal = "Weight Loss"}
            else if(goal.goalButton2.isSelected){quiz.goal = "Bulking"}
            else if(goal.goalButton3.isSelected){quiz.goal = "Leaning"}
            else{quiz.goal = "Feel Good!"}
            print(quiz.goal)
        case "Do you have access to a gym or free weights?":
            if(goal.goalButton1.isSelected){quiz.weightAccess = true}
            else{quiz.weightAccess = false}
            print(quiz.weightAccess)
        default:
            print("Failed on saving goalNextClicked")
        }
        let curr_question = quiz.initialQuestionList[curr_idx]
        populateSlide(curr_question: curr_question)
        curr_idx+=1
    }
    
    @objc func exerciseNextClicked(_ sender: UIButton!){
        let save_question = quiz.initialQuestionList[curr_idx-1]
        let sub: UIView? = sender.superview
        let exercise = sub as! Exercise
        switch(save_question.questionFields![0]){
        case "What sports do you play?":
            if(exercise.exerciseButton1.isSelected){quiz.sportsQL.append(Question(qF: ["Soccer", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton2.isSelected){quiz.sportsQL.append(Question(qF: ["Basketball", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton3.isSelected){quiz.sportsQL.append(Question(qF: ["Tennis", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton4.isSelected){quiz.sportsQL.append(Question(qF: ["Swimming", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton5.isSelected){quiz.sportsQL.append(Question(qF: ["Football", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton6.isSelected){quiz.sportsQL.append(Question(qF: ["Track and Field", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton7.isSelected){quiz.sportsQL.append(Question(qF: ["Baseball", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton8.isSelected){quiz.sportsQL.append(Question(qF: ["Gymnastics", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton9.isSelected){quiz.sportsQL.append(Question(qF: ["Volleyball", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton10.isSelected){quiz.sportsQL.append(Question(qF: ["Skating", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton11.isSelected){quiz.sportsQL.append(Question(qF: ["Dance", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton12.isSelected){quiz.sportsQL.append(Question(qF: ["Other", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(quiz.sportsQL.count > 0){
                let first_sports_q = quiz.sportsQL[0]
                populateSlide(curr_question: first_sports_q)
                sports_idx+=1
            }
            else{
                let curr_question = quiz.initialQuestionList[curr_idx]
                populateSlide(curr_question: curr_question)
                sports_idx+=1
                curr_idx+=1
            }
        case "What other excercises do you do?":
            if(exercise.exerciseButton1.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Muscle Training", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton1.isSelected == false){curr_idx+=1}
            if(exercise.exerciseButton2.isSelected){quiz.otherExerciseQL.append(Question(qF: ["HIIT", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton3.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Jogging", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton4.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Yoga", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton5.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Circuit Training", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton6.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Cardio Machine", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton7.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Cycling", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton8.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Walking", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(exercise.exerciseButton9.isSelected){quiz.otherExerciseQL.append(Question(qF: ["Other", "Intensity", "Hours/Week"], qT: "metrics"))}
            if(quiz.otherExerciseQL.count > 0){
                let first_exercise_q = quiz.otherExerciseQL[0]
                populateSlide(curr_question: first_exercise_q)
                otherExercise_idx+=1
            }
            else{
                let curr_question = quiz.initialQuestionList[curr_idx]
                populateSlide(curr_question: curr_question)
                curr_idx+=1
            }
        case "What do you currently train?":
            if(exercise.exerciseButton1.isSelected){quiz.currentMuscles.append("Biceps")}
            if(exercise.exerciseButton2.isSelected){quiz.currentMuscles.append("Triceps")}
            if(exercise.exerciseButton3.isSelected){quiz.currentMuscles.append("Shoulders")}
            if(exercise.exerciseButton4.isSelected){quiz.currentMuscles.append("Chest")}
            if(exercise.exerciseButton5.isSelected){quiz.currentMuscles.append("Back")}
            if(exercise.exerciseButton6.isSelected){quiz.currentMuscles.append("Core")}
            if(exercise.exerciseButton7.isSelected){quiz.currentMuscles.append("Glutes")}
            if(exercise.exerciseButton8.isSelected){quiz.currentMuscles.append("Hamstrings")}
            if(exercise.exerciseButton9.isSelected){quiz.currentMuscles.append("Quads")}
            if(exercise.exerciseButton10.isSelected){quiz.currentMuscles.append("Calves")}
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
            print(quiz.currentMuscles)
        case "What other excercises do you want to do?":
            if(exercise.exerciseButton1.isSelected){quiz.futureExercise.append("Muscle Training")}
            if(exercise.exerciseButton2.isSelected){quiz.futureExercise.append("HIIT")}
            if(exercise.exerciseButton3.isSelected){quiz.futureExercise.append("Jogging")}
            if(exercise.exerciseButton4.isSelected){quiz.futureExercise.append("Yoga")}
            if(exercise.exerciseButton5.isSelected){quiz.futureExercise.append("Circuit Training")}
            if(exercise.exerciseButton6.isSelected){quiz.futureExercise.append("Cardio Machine")}
            if(exercise.exerciseButton7.isSelected){quiz.futureExercise.append("Cycling")}
            if(exercise.exerciseButton8.isSelected){quiz.futureExercise.append("Walking")}
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
            print(quiz.futureExercise)
        case "What do you want to train?":
            if(exercise.exerciseButton1.isSelected){quiz.futureMuscles.append("Biceps")}
            if(exercise.exerciseButton2.isSelected){quiz.futureMuscles.append("Triceps")}
            if(exercise.exerciseButton3.isSelected){quiz.futureMuscles.append("Shoulders")}
            if(exercise.exerciseButton4.isSelected){quiz.futureMuscles.append("Chest")}
            if(exercise.exerciseButton5.isSelected){quiz.futureMuscles.append("Back")}
            if(exercise.exerciseButton6.isSelected){quiz.futureMuscles.append("Core")}
            if(exercise.exerciseButton7.isSelected){quiz.futureMuscles.append("Glutes")}
            if(exercise.exerciseButton8.isSelected){quiz.futureMuscles.append("Hamstrings")}
            if(exercise.exerciseButton9.isSelected){quiz.futureMuscles.append("Quads")}
            if(exercise.exerciseButton10.isSelected){quiz.futureMuscles.append("Calves")}
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
            print(quiz.futureMuscles)
        default:
            print("Failed on saving exerciseNextClicked")
        }
    }
    
    @objc func metricsNextClicked(_ sender: UIButton!){
        if(sports_idx == quiz.sportsQL.count){
            let save_question = quiz.sportsQL[sports_idx-1]
            let sub: UIView? = sender.superview
            let metrics = sub as! Metrics
            let intensity = metrics.intensitySlider.value
            let duration = metrics.durationSlider.value
            quiz.sportsDict[save_question.questionFields![0]] = [intensity, duration]
            //REMOVE
            print(save_question.questionFields![0])
            print(quiz.sportsDict[save_question.questionFields![0]]!)
            //REMOVE
            sports_idx+=1
            let curr_question = quiz.initialQuestionList[curr_idx]
            populateSlide(curr_question: curr_question)
            curr_idx+=1
        }
        else if(sports_idx < quiz.sportsQL.count){
            let save_question = quiz.sportsQL[sports_idx-1]
            let sub: UIView? = sender.superview
            let metrics = sub as! Metrics
            let intensity = metrics.intensitySlider.value
            let duration = metrics.durationSlider.value
            quiz.sportsDict[save_question.questionFields![0]] = [intensity, duration]
            //REMOVE
            print(save_question.questionFields![0])
            print(quiz.sportsDict[save_question.questionFields![0]]!)
            //REMOVE
            let sports_question = quiz.sportsQL[sports_idx]
            populateSlide(curr_question: sports_question)
            sports_idx+=1
        }
        else{
            let save_question = quiz.otherExerciseQL[otherExercise_idx-1]
            let sub: UIView? = sender.superview
            let metrics = sub as! Metrics
            let intensity = metrics.intensitySlider.value
            let duration = metrics.durationSlider.value
            quiz.otherExerciseDict[save_question.questionFields![0]] = [intensity, duration]
            //REMOVE
            print(save_question.questionFields![0])
            print(quiz.otherExerciseDict[save_question.questionFields![0]]!)
            //REMOVE
            if(otherExercise_idx == quiz.otherExerciseQL.count){
                otherExercise_idx+=1;
                let curr_question = quiz.initialQuestionList[curr_idx]
                populateSlide(curr_question: curr_question)
                curr_idx+=1
            }
            else{
                let otherEx_question = quiz.otherExerciseQL[otherExercise_idx]
                populateSlide(curr_question: otherEx_question)
                otherExercise_idx+=1
            }
        }

        
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
        // Variables
        var calorieConsumption: Float = 0.0
        var actLevel: Float = 0.0
        var physicalAct: Float = 0.0
        var totalDuration: Float = 0
        var calorieGoal: Float?
        var upperAbility: String = "beginner"
        var lowerAbility: String = "beginner"
        var cardioHealth: String?
       
        let weight: Float = (quiz.weight as NSString).floatValue / 2.2046
        let height: Float = (quiz.height as NSString).floatValue * 2.54
        let age: Float = (quiz.age as NSString).floatValue
   
        // Calculates total calorie expenditure
        // BMR
        if(quiz.gender == "Male" || quiz.gender == "Other"){
            calorieConsumption += 66.47
            calorieConsumption += (13.75 * weight)
            calorieConsumption += (5.003 * height)
            calorieConsumption -= (6.755 * age)
        }
        else if(quiz.gender == "Female" || quiz.gender == "Other"){
            calorieConsumption += 655.1
            calorieConsumption += (9.563 * weight)
            calorieConsumption += (1.85 * height)
            calorieConsumption -= (4.676 * age)
        }
        else{
            calorieConsumption /= 2
        }
    
       
        print("BMR: ", calorieConsumption)
   
        // Non-Exercise
        if(quiz.activityLevel == "Sedentary"){
            actLevel = calorieConsumption * 1.2
        }
        else if(quiz.activityLevel == "Lightly Active"){
            actLevel = calorieConsumption * 1.375
        }
        else if(quiz.activityLevel == "Active"){
             actLevel = calorieConsumption * 1.55
        }
        else{
            actLevel = calorieConsumption * 1.725
        }
   
        print("Activity Level", actLevel)
 
        // Physical Activity
        var sportsRatios: [String:[Float]] = [:]
        sportsRatios["Soccer"] = [3.18, 4.54]
        sportsRatios["Basketball"] = [2.04, 3.62]
        sportsRatios["Tennis"] = [2.72, 3.63]
        sportsRatios["Swimming"] = [3.17, 4.54]
        sportsRatios["Football"] = [3.63, 4.08]
        sportsRatios["Track and Field"] = [3.63, 4.54]
        sportsRatios["Baseball"] = [2.23, 2.23]
        sportsRatios["Gymnastics"] = [1.82, 1.82]
        sportsRatios["Volleyball"] = [1.36, 3.63]
        sportsRatios["Skating"] = [2.5, 4.08]
        sportsRatios["Dance"] = [1.42, 3.71]
        sportsRatios["Other"] = [2.52, 4.04]
       
        var otherRatios: [String:[Float]] = [:]
        otherRatios["Muscle Training"] = [1.36, 2.72]
        otherRatios["HIIT"] = [3.69, 4.62]
        otherRatios["Jogging"] = [3.63, 4.54]
        otherRatios["Yoga"] = [1.14, 1.82]
        otherRatios["Circuit Training"] = [1.92, 3.63]
        otherRatios["Cardio Machine"] = [1.68, 4.62]
        otherRatios["Cycling"] = [2.5, 4.77]
        otherRatios["Walking"] = [1.14, 2.69]
        otherRatios["Other"] = [2.2, 3.54]
       
        for (sport, sportMetrics) in quiz.sportsDict{
            let low: Float = sportsRatios[sport]![0]
            let high: Float = sportsRatios[sport]![1]
            physicalAct += ((low + (high - low) * sportMetrics[0]) * weight * round(sportMetrics[1]) / 7)
            totalDuration += sportMetrics[1]
            if(sport == "Football" || sport == "Gymnastics" || sport == "Swimming"){
                upperAbility = "advanced"
            }
            if(sport == "Soccer" || sport == "Basketball" || sport == "Track and Field" || sport == "Volleyball" ||  sport == "Skating"){
                lowerAbility = "advanced"
            }
        }
       
        for (otherExercise, otherMetrics) in quiz.otherExerciseDict{
            let low: Float = otherRatios[otherExercise]![0]
            let high: Float = otherRatios[otherExercise]![1]
            physicalAct += ((low + (high - low) * otherMetrics[0]) * weight * round(otherMetrics[1]) / 7)
            totalDuration += otherMetrics[1]
            if(otherExercise == "Muscle Training" || otherExercise == "HITT"){
                upperAbility = "advanced"
                lowerAbility = "advanced"
            }
        }
       
        print("Physical Activity: ", physicalAct)
       
        calorieConsumption += ((actLevel + physicalAct) / 2)
       
        print("Calorie Consumption: ", calorieConsumption)
       
        // Calculate goal calories
        if(quiz.goal == "Weight Loss" || quiz.goal == "Leaning"){
            calorieGoal = calorieConsumption * 0.9
        }
        else if(quiz.goal == "Bulking"){
            calorieGoal = calorieConsumption + 500
        }
        else{
            calorieGoal = calorieConsumption
        }
  
        // Determine cardio level
        if(totalDuration >= 0 && totalDuration <= 2){
            cardioHealth = "beginner"
        }
        else if(totalDuration > 2 && totalDuration <= 4){
            cardioHealth = "intermediate"
        }
         else{
            cardioHealth = "advanced"
        }
   
        print("Goal:", calorieGoal!)
        
        let today = Date()
        user = User(name: quiz.name, startDate: today, workoutPlan: [["Archery"]], dietPlan: [["Grass"]], motivation: ["You have failed this city"])
        saveUserData()
    }
}


