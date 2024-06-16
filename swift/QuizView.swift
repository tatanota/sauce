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
    var no: String
    var class1: String
    var class2: String
    
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
    //Fanction.swiftのloadQuestions()を直接呼び出し可能
    let questions = loadQuestions()
    
    
    var body: some View {
        
        VStack {
            
            //画面遷移
            Button("記録表示") {
                
             /*   addData(no:questions[currentQuestionIndex].no,class1:questions[currentQuestionIndex].class1 , class2:questions[currentQuestionIndex].class2  ,items: &items, counter: score, totalQuestions: currentQuestionIndex)
              */
                
                addData(no: "", class1: "",class2: "",items: &items, counter: score, totalQuestions: currentQuestionIndex)
             
                
                path.append(.pathB)
            }
            .padding()
            .font(.title2)
            .foregroundColor(.blue)
            .border(.blue, width: 0.5)
            
            .onAppear {
                loadArrayFromUserDefaults(items: &items)
            }
            
            //現在の質問のインデックスが質問の総数より小さい場合と大きい場合で条件分岐
            if currentQuestionIndex < questions.count {

                // 現在の質問を取得
                let currentQuestion = questions[currentQuestionIndex]
                
                //大分類表示
                Text(currentQuestion.class1)
                    .font(.body)
                //中分類表示
                Text(currentQuestion.class2)
                    .font(.body)
                //問題文表示
                Text("Q: " + currentQuestion.no + currentQuestion.text)
                    .font(.title)
                    .padding()
                Spacer()//上寄せ
                
                /*
                 shuffledIndices ランダムに並べ替えた後の選択肢のインデックスを保持する変数
                 questions[] 質問オブジェクトを取得
                 currentQuestionIndex 現在表示している質問のインデックス
                 options 質問に対する選択肢（配列）を表します。
                 options.indices optionsのインデックスの範囲 indices は 0..<4
                 .shuffled() 配列内の要素をランダムに並び替えるメソッド
                 
                 現在表示している問題の選択肢の範囲を読み込み、.shuffled()で並び替え
                */
                
                // 選択肢をシャッフル
              //  let shuffledIndices = questions[currentQuestionIndex].options.indices.shuffled()
    
                
                
                //選択肢表示　questionsに格納した内容を表示
                VStack(alignment: .leading, spacing: 10) {
                
                    // 初期化時に選択肢のインデックスをシャッフルする
                   /* if shuffledIndices.isEmpty {
                shuffledIndices = questions[currentQuestionIndex].options.indices.shuffled()
                    }*/
                    
                               
                    
                    // 選択肢を縦並びで表示
                    ForEach(currentQuestion.options.indices, id: \.self) { index in
                        HStack {
                            if index < currentQuestion.options.count {  // インデックスが範囲内か確認
                                Text("\(["A", "B", "C", "D"][index]): \(currentQuestion.options[index])")
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        self.selectedAnswer = currentQuestion.options[index]
                                    }
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding(.horizontal) // 水平方向の余白
                    Spacer().frame(width: 50) // テキストを左寄せにするためのSpacer
                    
                    
                    //回答ボタン
                    HStack(spacing: 40) {
                        
                        // ボタンA, B, C, D の表示
                        ForEach(["A", "B", "C", "D"], id: \.self) { label in
                            AnswerButton(label: label, selectedAnswer: $selectedAnswer,
                                         showAlert: $showAlert, correctAnswer: currentQuestion.answer)
  
                            
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
                .padding()
                .font(.title2)
                .foregroundColor(.blue)
                .border(.blue, width: 0.5)
                
                
                .onAppear {

                    //データ記録
                    loadArrayFromUserDefaults(items: &items)

               //     addData(no: questions[currentQuestionIndex].no, class1: questions[currentQuestionIndex].class1,
                //            class2: questions[currentQuestionIndex].class2, items: &items, counter: score, totalQuestions: currentQuestionIndex)
                    addData(no: "", class1: "",class2: "",items: &items, counter: score, totalQuestions: currentQuestionIndex)
                }
            }
        }
        
        
//-------------------------------------
        //alertメソッド
        .alert(isPresented: $showAlert) {
            Alert(
 
                title: Text(selectedAnswer == questions[currentQuestionIndex].answer ? "正解" : "不正解"),
                message: Text(selectedAnswer == questions[currentQuestionIndex].answer ? "正解です！" : "正しい答えは \(questions[currentQuestionIndex].answer) です。"),
                primaryButton: .default(Text("次へ")) {
                    if selectedAnswer == questions[currentQuestionIndex].answer {
                        score += 1
                    }

                    
                    //問題数をカウント
                    QuizController.nextQuestion(quescount: &currentQuestionIndex)
                },
                secondaryButton: .cancel(Text("復習"))
            )
        }

//-------------------------------------
                   
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
