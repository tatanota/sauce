import java.util.Scanner;


// 2024.4.11 paiza C084:【キャンペーン問題】枠で囲む

public class wakukakomu {
	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);


		while (true) {
			System.out.println("文字を入力してEnterを押してください(終了する場合はEnterのみ): ");        


			String line = sc.nextLine();


			// Enterキーが押された場合、ループを抜けてプログラムを終了する
			if (line.isEmpty()) {
				break;
			}


			String un  = "";

			//文字数取得
			int con = line.length();

			//文字数+2分"＋"を連結
			for (int n= 0 ; n<con+2  ;n++ ){
				un += "+";
			}

			//該当文字の両端に"＋"を連結
			String kas = "+" + line + "+";

			//表示
			System.out.println(un);
			System.out.println(kas);
			System.out.println(un);
		}

		// プログラムが終了したことをユーザーに通知
		System.out.println("終了します。");
	}
}
