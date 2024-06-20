//
//  Score.swift
//  sikaku
//
//  Created by ta on 2024/05/17.
//

import SwiftUI

struct ScoreView: View {
    
    @Binding var path: [SamplePath]
    
    @Environment(\.presentationMode) var presentationMode
    
      @State private var items: [[Item]] = []

    var body: some View {
        

        //コンテナビュー（共通画面Viewを呼び出し）
       // MenuContainerView(navigatePath: $path) {
      /*    MenuContainerView(navigatePath: $navigatePath) {
        　MenuContainerView(navigatePath: $path) {
              // ナビゲーションの状態を管理する配列パス
              @State private var navigatePath: [SamplePath] = []
            @Binding var path: [SamplePath]
              */
              
              
            VStack {
                HStack {
                    
                    Text("　日付　　　　　")
                        .font(.headline)
                        .border(.blue, width: 0.5)
                    //左寄せ
                        .frame(width: 180, alignment: .leading )
                    
                    Text("正当数 / 回答数")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .border(.blue, width: 0.5)
                }//HStack
                .padding()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        //flatMapは、コレクション内の各要素を変換し、ネストされたコレクションを1つのコレクションに平坦化
                        //items Item2の配列の配列
                        //{ $0 } クロージャで、各要素（[Item2]）をそのまま返しています。
                        ForEach(items.flatMap { $0 }, id: \.self) { item in
                            HStack {
                                Text(item.date)
                                    .frame(width: 180, alignment: .leading)
                                
                                /*  Text(item.no)
                                 .frame(maxWidth: .infinity, alignment: .center)
                                 
                                 Text("\(item.class1)")
                                 .frame(maxWidth: .infinity, alignment: .center)
                                 
                                 Text("\(item.class2)")
                                 .frame(maxWidth: .infinity, alignment: .center)*/
                                
                                Text("\(item.score)/\(item.totalQuestions)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }//HStack
                            .padding(.vertical,0.01)
                        } //ForEach
                    } //VStack
                    Spacer()//上寄せ
                    
                    
                    //ビューが表示される直前に実行されるモディファイア
                        .onAppear {
                            loadArrayFromUserDefaults(items: &items)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    
                    // ホームに戻るボタン
                        .navigationBarItems(trailing:
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
                        )//navigationBarItems
                    
                        .navigationBarBackButtonHidden(true) // Backボタンを非表示にする
                }//ScrollView
            }//VStack
        

     //   }//MenuContainerView
    }//body
}//ScoreView
