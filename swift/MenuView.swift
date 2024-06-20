import SwiftUI

struct MenuView: View {
    /// メニュー開閉
    @Binding var isOpen: Bool
    // ナビゲーションパス
    @Binding var navigatePath: [SamplePath]
    
    /// iPhoneの幅
    private let maxWidth = UIScreen.main.bounds.width
    
    var body: some View {

        ZStack(alignment: .trailing) { // 右側に揃える
            /// 背景が透明な黒になる
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(isOpen ? 0.7 : 0)
                .onTapGesture {
                    toggleMenu()
                }

            
            /// メニューの内容
            VStack(alignment: .leading) {
                List {
                    Section {
                       
                        //ホームに遷移
                        Button(action: {
                         //   path.removeAll()
                          //  toggleMenu()
                        }) {
                            HStack {
                                //家のアイコンを表示
                                Image(systemName: "house.fill")
                                Text("ホームに戻る")
                            }
                        }
                   
                        //スコアに遷移
                        Button(action: {
                            navigatePath.append(.pathB)
                            toggleMenu()
                        }) {
                            HStack {
                                //Image(systemName: "gearshape")
                                Text("記録表示")
                            }
                        }
                    
                        
                        //設定に遷移（ダミー）
                        Button(action: {
                            navigatePath.append(.pathC)
                            toggleMenu()
                        }) {
                            HStack {
                                Image(systemName: "gearshape")
                                Text("設定")
                            }
                        }
                        //情報に遷移（ダミー）
                        Button(action: {
                            navigatePath.append(.pathD)
                            toggleMenu()
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("このアプリについて")
                            }
                        }
                        
                        //取説に遷移（ダミー）
                        Button(action: {
                            navigatePath.append(.pathD)
                            toggleMenu()
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("取扱説明書")
                            }
                        }
                        
                    }
                }
            }
            .frame(width: maxWidth * 0.75)
            .offset(x: isOpen ? 0 : maxWidth * 0.75) // 右から表示
            .animation(.easeInOut(duration: 0.3), value: isOpen)
        }
    }

    
//-------------------------------------
    private func toggleMenu() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isOpen.toggle()
        }
    }
}


//-------------------------------------
/*
struct SettingsView: View {
    var body: some View {
        Text("設定画面")
            .navigationTitle("設定")
    }
}*/

struct AppInfoView: View {
    var body: some View {
        Text("アプリケーション情報画面")
            .navigationTitle("アプリケーション情報")
    }
}
