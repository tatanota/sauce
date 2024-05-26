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


//-- 配列にデータ格納
func addData(items: inout [[Item]], _ counter: Int, _ totalQuestions: Int) {
    
    //日付変換
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let dateString = formatter.string(from: Date())
    
    
    
    //◼️◼️◼️◼️◼️◼️最後の配列の＋１に格納したい
    if let lastIndex = items.indices.last {
        items[lastIndex].append(Item(date: dateString, score: counter, totalQuestions: totalQuestions))
    } else {
        // itemsが空の場合、新しいサブ配列を作成して追加
        items.append([Item(date: dateString, score: counter, totalQuestions: totalQuestions)])
    }
    saveArrayToUserDefaults(items: items)
}



//-- ユーザーが次の質問に進むためのメソッド
class QuizController {
    static func nextQuestion(quescount: inout Int) {
        quescount += 1
    }
}


//データ取得関数
func loadArrayFromUserDefaults(items: inout [[Item2]]) {
    if let savedData = UserDefaults.standard.data(forKey: "itemsKey") {
        let decoder = JSONDecoder()
        if let savedItems = try? decoder.decode([[Item2]].self, from: savedData) {
 
            items = savedItems
       
        }
    }
}
