//
//  Question.swift
//  Personal Quiz
//
//  Created by Vladimir Liubarskiy on 27/03/2024.
//

struct Question {
    let tittle: String
    let type: ResponseType
    let answers: [Answer]
    
   static  func getQuestions() -> [Question] {
        [
            Question(
                tittle: "Какую пищу предпочитаете?",
                type: .single,
                answers: [
                    Answer(tittle: "Стейк", animal: .dog),
                    Answer(tittle: "Рыба", animal: .cat),
                    Answer(tittle: "Морковь", animal: .rabbit),
                    Answer(tittle: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                tittle: "Что вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(tittle: "Плавать", animal: .dog),
                    Answer(tittle: "Спать", animal: .cat),
                    Answer(tittle: "Обниматься", animal: .rabbit),
                    Answer(tittle: "Есть", animal: .turtle)
                ]
            ),
            Question(
                tittle: "Любите ли вы поездки на машине?",
                type: .rage,
                answers: [
                    Answer(tittle: "Ненавижу", animal: .cat),
                    Answer(tittle: "Нервничаю", animal: .rabbit),
                    Answer(tittle: "Не замечаю", animal: .turtle),
                    Answer(tittle: "Обожаю", animal: .dog)
                ]
            ),
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case rage
}

struct Answer {
    let tittle: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выйгривыет на больших дистанциях."
        }
    }
}

