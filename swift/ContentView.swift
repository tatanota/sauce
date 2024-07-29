//
//  ContentView.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI


// 配列パスとして使う列挙型
enum SamplePath: Hashable {
    case pathA
    case pathB
    case pathC
    case pathD
}


struct Count1: Identifiable, Hashable {
    var id = UUID()
    var value: Int
}

// UIメソッド
struct ContentView: View {
    
    // ナビゲーションの状態を管理する配列パス
    @State private var navigatePath: [SamplePath] = []
    
    @State var inputName = ""
    
    @State private var count1: [Count1] = []
    // メニューの開閉
    //ブール型 true:メニュー開 false:メニュー閉
    @State var isMenuOpen = false
    
//-------------------------------------
    var body: some View {
        
        //コンテナビュー（共通画面Viewを呼び出し）
        MenuContainerView(navigatePath: $navigatePath) {
            
                // ナビゲーションバーの表示
                NavigationStack(path: $navigatePath) {
                    
                    Spacer().frame(height: 30)
                    
                    
                    // 垂直にビューを積み重ねるコンテナビュー
                    VStack {
                        Text("アジャイル検定\n（アジャイルソフトウェア\n開発技術者検定）")
                            .font(.title2)
                        
                        Text("対策問題")
                            .font(.title2)
                        
                        Spacer().frame(height: 100) // 下部に320の高さの余白を作成するSpacer
                        
                        HStack{
                            Spacer().frame(width: 20)
                            
                            TextField("問題数を入力してください", text: $inputName)
                                .keyboardType(.numberPad)
                                .border(.blue, width: 0.5)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: inputName) {
                                    inputName = inputName.filter { "0123456789".contains($0) }
                                }
                            

                        
                            
                            
                            Spacer().frame(width: 150)
                        }
                        
                        Text("　レベル1")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            // 画面遷移　QuizViewを呼び出し
                            Button("問題数を指定して\n 問題開始") {
                                
                                //パスを格納したら再レンダリング
                                navigatePath.append(.pathA)
                                
                            }
                            .padding()
                            .font(.title2)
                            .foregroundColor(.blue)
                            .border(.blue, width: 0.5)
                     
                            
                            // 画面遷移　QuizViewを呼び出し
                            Button("問題開始") {
                                navigatePath.append(.pathA)
                            }
                            .padding()
                            .font(.title2)
                            .foregroundColor(.blue)
                            .border(.blue, width: 0.5)
                        }// HStack
                        
                        Spacer().frame(height: 30)
                        Text("　レベル2")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            // 画面遷移　QuizViewを呼び出し
                            Button("問題数を指定して\n 問題開始") {
                            }
                            .padding()
                            .font(.title2)
                            .foregroundColor(.blue)
                            .border(.blue, width: 0.5)
                            
                            // 画面遷移　QuizViewを呼び出し
                            Button("問題開始") {
                            }
                            .padding()
                            .font(.title2)
                            .foregroundColor(.blue)
                            .border(.blue, width: 0.5)
                        }// HStack
                        Text("　　※レベル2 は準備中です。")
                            .font(.title3)
        
                    }//VStack
                    
                    
                    //-------------------------------------

                    
                    // 配列パスに追加された値が遷移先のビューを定義
                    .navigationDestination(for: SamplePath.self) { value in
                        switch value {
                        case .pathA:
                            QuizView(path: $navigatePath, count1: $count1, inputName: $inputName)
                        case .pathB:
                            ScoreView(path: $navigatePath)
                        case .pathC:
                            SettingsView()
                        case .pathD:
                            AppInfoView()
                        }
                    }
                     
                }//NavigationStack
        }//MenuContainerView
    }//body
}// View
