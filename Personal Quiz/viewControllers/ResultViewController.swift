//
//  ResultViewController.swift
//  Personal Quiz
//
//  Created by Vladimir Liubarskiy on 27/03/2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet var animalLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let time = ContinuousClock().measure {
            updateResult()
        }
        print(time)
    }
    
    @IBAction func doneButoonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
} 
extension ResultViewController {
    private func updateResult() {
        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
            let sortedFrequentOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
            guard let mostFrequentAnimal = sortedFrequentOfAnimals.first?.key else {
                return
            }
            
            updateUI(with: mostFrequentAnimal)
        }
           func updateUI(with animal: Animal) {
            animalLabel.text = "Вы - \(animal.rawValue)!"
            descriptionLabel.text = animal.definition
        }

    }
}
