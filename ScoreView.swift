//
//  Score.swift
//  sikaku
//
//  Created by ta on 2024/05/17.
//

import SwiftUI


struct Item2: Codable, Identifiable, Hashable {
    var id = UUID()
    var date: String
    var score: Int
    var totalQuestions: Int
}


struct ScoreView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var items: [[Item2]] = []

    var body: some View {
        VStack {
            HStack {
                Text("日付")
                    .font(.headline)
                //左寄せ
                    .frame(width: 180, alignment: .leading )
                Text("スコア")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("回答数")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
           

            VStack(alignment: .leading) {
                
                //flatMapは、コレクション内の各要素を変換し、ネストされたコレクションを1つのコレクションに平坦化
                //items Item2の配列の配列
                //{ $0 } クロージャで、各要素（[Item2]）をそのまま返しています。
                ForEach(items.flatMap { $0 }, id: \.self) { item in
                    HStack {
                        Text(item.date)
                            .frame(width: 180, alignment: .leading)
                        
                        Text("\(item.score)")
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("\(item.totalQuestions)")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.vertical, 5)
                }
            }
            Spacer()//上寄せ
            
            
        //ビューが表示される直前に実行されるモディファイア
        .onAppear {
                loadArrayFromUserDefaults(items: &items)
            }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
           

    
        .navigationBarItems(trailing:
                // ホームに戻るボタン
                Button(action: {
                presentationMode.wrappedValue.dismiss()
           
                }) {
                    Image(systemName: "house.fill") // 家のアイコンを表示
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.blue)
                }
                                )
     
   }
}
}










    
