import SwiftUI

struct MenuContainerView<Content: View>: View {
    
    //ContentViewなどからナビゲーションパスを受け取
    //現在のナビゲーション状態を他のビューと共有
    @Binding var navigatePath: [SamplePath]
    @State private var isMenuOpen = false
    
    //内部で表示するビューを格納(引数)
    let content: Content
    
    
    //初期化メソッド。ナビゲーションパスと表示するコンテンツを初期化
    init(navigatePath: Binding<[SamplePath]>, @ViewBuilder content: () -> Content) {
        self._navigatePath = navigatePath
        self.content = content()
    }
    

    
    
    var body: some View {

        ZStack {
            NavigationStack(path: $navigatePath) {
                content
                
                
                //ハンバーガーメニューを表示
                    .toolbar {
                        
                        //navigationBar"Trailing"で右に表示
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            // isMenuOpenの変化にアニメーションをつける
                            //withAnimation: アニメーション適用関数
                            //easeInOut: 開始時と終了時に遅く、中間は速いアニメーション効果。
                            //duration: 0.3: アニメーションの持続時間を0.3秒に設定。
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    
                                    //isMenuOpenの値を更新してメニュー表示
                                    isMenuOpen.toggle()
                                }
                            } label: {
                                //三本線
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }//toolbar
                
                /*
                    // 配列パスに追加された値が遷移先のビューを定義
                    .navigationDestination(for: SamplePath.self) { value in
                        switch value {
                        case .pathA:
                            QuizView(path: $navigatePath)
                        case .pathB:
                            ScoreView(path: $navigatePath)
                        case .pathC:
                            SettingsView()
                        case .pathD:
                            AppInfoView()
                        }
                    }*/
                 
            }//NavigationStack
            //初期表示は閉じた状態（画面外）で画面表示
            MenuView(isOpen: $isMenuOpen, navigatePath: $navigatePath)
            
        }//ZStack
    }//body
}//MenuContainerView



struct SettingsView: View {
    var body: some View {
        Text("設定画面")
            .navigationTitle("設定")
    }
}
