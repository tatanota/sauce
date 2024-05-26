//
//  ContentView.swift
//  sikaku
//
//  Created by ta on 2024/05/15.
//

import SwiftUI

//UIメソッド
struct ContentView: View {
    var body: some View {
        //ナビゲーションバーの表示
        NavigationView {
            //垂直にビューを積み重ねるコンテナビュー
            VStack {
                
                Text("アジャイル検定\n（アジャイルソフトウェア\n開発技術者検定）")
                    .font(.title2)
                    
                Text("対策問題")
                    .font(.title2)
                    
                Spacer().frame(height: 320) // 下部に20の高さの余白を作成するSpacer
                
                
                HStack {
                    //画面遷移　QuizViewを予備出し
                    NavigationLink(destination: QuizView()) {
                        Text("レベル1\n 問題開始")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding()
                            .border(.blue, width: 0.5)
                    }
                    //画面遷移
                    NavigationLink(destination: ScoreView()) {
                        Text("記録表示")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)//角丸く
                    }
                }
                
            }
        }
    }
}

