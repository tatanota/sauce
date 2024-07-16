// ゼロ・プラス・マイナスを繰り返し判定する
fun main() {
    println("繰り返したい回数を入力してください")

    val count = readLine()!!.toInt()
    println("入力された繰り返し回数: $count")

    for (i in 1 .. count) {
        println("確認したい数値を入力してください")

        val number = readLine()!!.toInt()
        println("入力された数値: $count")

        if(number == 0){
            println("${number}は0")
        }else if(number > 0){
            println("${number}はプラス")
        }else{
            println("${number}はマイナス")
        }
    }
}
