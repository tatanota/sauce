//
//  ContentView.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI


// 配列パスとして使う列挙型
enum SamplePath {
    case pathA, pathB
}

//UIメソッド
struct ContentView: View {
            
    // ナビゲーションの状態を管理する配列パス
    @State private var navigatePath: [SamplePath] = []
    
    var body: some View {
        //ナビゲーションバーの表示
        NavigationStack(path: $navigatePath) {
   
            //垂直にビューを積み重ねるコンテナビュー
            VStack {
                Text("アジャイル検定\n（アジャイルソフトウェア\n開発技術者検定）")
                    .font(.title2)
                    
                Text("対策問題")
                    .font(.title2)
                    
                Spacer().frame(height: 320) // 下部に20の高さの余白を作成するSpacer
                
                HStack {
                    //画面遷移　QuizViewを呼び出し
                    Button("レベル1\n 問題開始") {
                        navigatePath.append(.pathA)
                    }
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding()
                    .border(.blue, width: 0.5)
                    
                    //画面遷移
                    Button("記録表示") {
                        navigatePath.append(.pathB)
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)//角丸く
                }
                // 配列パスに追加された値が遷移先のビューを定義
                .navigationDestination(for: SamplePath.self) { value in
                    switch value {
                    case .pathA:
                        QuizView(path: $navigatePath)
                    case .pathB:
                        ScoreView(path: $navigatePath)
                    }
                }
                
            }
        }
    }
}

