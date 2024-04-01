//
//  ViewController.swift
//  Personal Quiz
//
//  Created by Vladimir Liubarskiy on 27/03/2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var questoinLabel: UILabel!
    @IBOutlet var questionProgresView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLables: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangeStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    // MARK: - Private Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    private var currentAnswer: [Answer] {
        questions[questionIndex].answers
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let answerCount = Float(currentAnswer.count - 1)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = answersChosen
    }
    // MARK: - IB Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswer[buttonIndex]
        answersChosen.append(currentAnswer)
        nextQuestion()
    }
    
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswer) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    
    @IBAction func rangeAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswer[index])
        nextQuestion()
    }
}
// MARK: - Private Methods
private extension QuestionsViewController {
    func updateUI() {
        // Hide everyshing
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question label
        questoinLabel.text = currentQuestion.tittle
        
        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progress for questionProgressView
        questionProgresView.setProgress(totalProgress, animated: true)
        
        // Show stacks corresponding to question type
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    /// Choice of answers category
    ///
    /// Displaying answers to a question according to a category
    ///
    /// - Parameter type: Specifies the category of responses
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswer)
        case .multiple: showMultipleStackView(with: currentAnswer)
        case .rage: showRangedStackView(with: currentAnswer)
        }
    }
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.tittle, for: .normal)
        }
        
    }
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLables, answers) {
            label.text = answer.tittle
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangeStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.tittle
        rangedLabels.last?.text = answers.last?.tittle
        
    }
    
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}


