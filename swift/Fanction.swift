//
//  Question.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI
import Foundation


struct Question: Codable {
    let text: String
    let options: [String]
    let answer: String
}

//-- jsonファイルから読み込み
func loadQuestions() -> [Question] {
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
        print("Failed to locate questions.json")
        return []
    }
    
    //データが取得できるか確認
    do {
        let data = try Data(contentsOf: url)
        
        let questions = try JSONDecoder().decode([Question].self, from: data)
        return questions
        
    } catch {
        print("Error decoding questions.json: \(error)")
        return []
    }
}

//-- userdefaultに記録関数
func saveArrayToUserDefaults(items: [[Item]]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: "itemsKey")
    }
}


//データ取得関数
func loadArrayFromUserDefaults(items: inout [[Item]]) {
    if let savedData = UserDefaults.standard.data(forKey: "itemsKey") {
        let decoder = JSONDecoder()
        if let savedItems = try? decoder.decode([[Item]].self, from: savedData) {
 
            items = savedItems
       
        }
    }
}

func addData(items: inout [[Item]], counter: Int, totalQuestions: Int) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let dateString = formatter.string(from: Date())

    // 配列の最後のサブ配列の次に追加
    items.append([Item(date: dateString, score: counter, totalQuestions: totalQuestions)])
    saveArrayToUserDefaults(items: items)
}



//-- ユーザーが次の質問に進むためのメソッド
class QuizController {
    static func nextQuestion(quescount: inout Int) {
        quescount += 1
    }
}


