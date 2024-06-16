//
//  Question.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI
import Foundation
import UIKit


struct Question: Codable {
    var no: String
    var class1: String
    var class2: String
    
    var text: String
    var options: [String]
    var answer: String
}

//-- jsonファイルから読み込み
func loadQuestions() -> [Question] {
    guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
        print("Failed to locate questions.json")
        return []
    }
    
    // データが取得できるか確認
    do {
        let data = try Data(contentsOf: url)
        
        // JSONデータをデコード
        var questions = try JSONDecoder().decode([Question].self, from: data)

        // 各質問の選択肢をシャッフルし、正解を再設定
        questions = questions.map { question in
            var shuffledQuestion = question
            // 現在の正解の内容を取得
            let correctAnswer = question.options[["A", "B", "C", "D"].firstIndex(of: question.answer)!]
            // 選択肢をシャッフル
            shuffledQuestion.options = question.options.shuffled()
            // 新しいインデックスを基に正解のラベルを更新
            shuffledQuestion.answer = ["A", "B", "C", "D"][shuffledQuestion.options.firstIndex(of: correctAnswer)!]
            return shuffledQuestion
        }
        
        // 質問全体をシャッフル
        questions = questions.shuffled()
        
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



//データ追加
func addData( no: String, class1: String, class2: String ,items: inout [[Item]], counter: Int, totalQuestions: Int) {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/dd HH:mm"
    let dateString = formatter.string(from: Date())

    // 配列の最後のサブ配列の次に追加
    items.append([Item(no: no,class1: class1,class2: class2,date: dateString, score: counter, totalQuestions: totalQuestions)])
    saveArrayToUserDefaults(items: items)
}



//-- ユーザーが次の質問に進むためのメソッド
class QuizController {
    static func nextQuestion(quescount: inout Int) {
        quescount += 1
    }
}
