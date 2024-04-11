import java.util.*;
public class Main {
    public static void main(String[] args) {
        // 自分の得意な言語で
        // Let's チャレンジ！！
        Scanner sc = new Scanner(System.in);
        String line = sc.nextLine();
        String un  = "";
        
        int con = line.length();
        for (int n= 0 ; n<con+2  ;n++ ){
            un += "+";
        }
        
        
        String kas = "+" + line + "+";
        
        System.out.println(un);
        System.out.println(kas);
        System.out.println(un);
    }
}