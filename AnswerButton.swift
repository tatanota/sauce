//
//  AnswerButton.swift
//  sikaku
//
//  Created by ta on 2024/05/25.
//

import SwiftUI

//回答ボタンのコンポーネント化
struct AnswerButton: View {
    var label: String
    @Binding var selectedAnswer: String?
    @Binding var showAlert: Bool
    var correctAnswer: String
    
    var body: some View {
        Button(action: {
            self.selectedAnswer = label
            self.showAlert = true
        }) {
            Text(label)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}
