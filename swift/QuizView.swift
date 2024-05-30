//
//  QuizView.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI

//Codableプロトコル　Item 構造体はエンコード（保存）およびデコード（読み込み）が可能
//Identifiableプロトコル ForEach などのビューで使用する際に、各 Item インスタンスが一意に識別
//　　　　　　　　　　　　　id というプロパティ(UUID)で各インスタンスを一意に識別
//Hashableプロトコル　Item インスタンスはハッシュ可能　Set や Dictionary のキーとして使用可
struct Item: Codable, Identifiable, Hashable {
    var id = UUID()
    var date: String
    var score: Int
    var totalQuestions: Int
}


struct QuizView: View {
    
    @Binding var path: [SamplePath]
    
    //現在の質問のインデックスを保持するStateプロパティ。
    @State private var currentQuestionIndex = 0
    
    //ユーザーのスコアを保持するStateプロパティ。
    @State private var score = 0
    
    //ユーザーが選択した回答を保持するStateプロパティ。
    @State private var selectedAnswer: String? = nil
    
    //アラートを表示するためのStateプロパティ。
    @State private var showAlert = false
    
    // 4つのサブ配列を持つ2次元配列
    @State private var items: [[Item]] = []

    @Environment(\.presentationMode) var presentationMode // 環境変数を追加
    
    
    
    //問題データを配列にロードする関数
    //Question.swiftのloadQuestions()を直接呼び出し可能
    let questions = loadQuestions()
    
    var body: some View {
        
        VStack {
            
            //画面遷移
            Button("記録表示") {
                addData(items: &items, counter: score, totalQuestions: currentQuestionIndex)
                path.append(.pathB)
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)//角丸く
            
            .onAppear {
                loadArrayFromUserDefaults(items: &items)
            }
        
            //現在の質問のインデックスが質問の総数より小さい場合と大きい場合で条件分岐
            if currentQuestionIndex < questions.count {
                
                //問題文表示
                Text("Q: " + questions[currentQuestionIndex].text)
                    .font(.title)
                    .padding()
                Spacer()//上寄せ
                
                
                //選択肢表示　questionsに格納した内容を表示
                VStack(alignment: .leading, spacing: 10) {
                    
                    // 選択肢を縦並びで表示
                    ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                        HStack {
                            Text("\(["A", "B", "C", "D"][index]): \(questions[currentQuestionIndex].options[index])")
                                .cornerRadius(10)
                                .onTapGesture {
                                    self.selectedAnswer = questions[currentQuestionIndex].options[index]
                                }
                                .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal) // 水平方向の余白
                    Spacer().frame(width: 50) // テキストを左寄せにするためのSpacer
                    
                    //回答ボタン
                    HStack(spacing: 40) {
                        
                        // ボタンA, B, C, D の表示
                        ForEach(["A", "B", "C", "D"], id: \.self) { label in
                            AnswerButton(label: label, selectedAnswer: $selectedAnswer, showAlert: $showAlert, correctAnswer: questions[currentQuestionIndex].answer)
                        }
                    }
                    .padding(.horizontal) // 水平方向の余白
                }
                
             
            } else {
                Text("クイズが終了しました")
                    .font(.title)
                    .padding()
                Text("スコア: \(score)/\(questions.count)")
                    .font(.title2)
                    .padding()
                
                //画面遷移
                Button("記録表示") {
                    path.append(.pathB)
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10) // 角を丸く
                
                
                
                .onAppear {
                    //addData(items: &items, score, questions.count)
                    
                    loadArrayFromUserDefaults(items: &items)
                    addData(items: &items, counter: score, totalQuestions: currentQuestionIndex)
                    
                }
            }
        }
        //alertメソッド
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(selectedAnswer == questions[currentQuestionIndex].answer ? "正解" : "不正解"),
                message: Text(selectedAnswer == questions[currentQuestionIndex].answer ? "正解です！" : "正しい答えは \(questions[currentQuestionIndex].answer) です。"),
                dismissButton: .default(Text("次へ")) {
                    if selectedAnswer == questions[currentQuestionIndex].answer {
                        score += 1
                    }
                    
                    //問題数をカウント
                    QuizController.nextQuestion(quescount: &currentQuestionIndex)
                }
            )
        }
                   
        .navigationBarItems(trailing:
                // ホームに戻るボタン
                Button(action: {
                    path.removeAll()
                }
                      )
                {
                    Image(systemName: "house.fill") // 家のアイコンを表示
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.blue)
                }
                            )
        
    
        
        
            
    }
}
