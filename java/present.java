import java.util.*;
public class Main {
    public static void main(String[] args) {
        // 自分の得意な言語で
        // Let's チャレンジ！！
        Scanner sc = new Scanner(System.in);
        
        String inputLine = sc.nextLine();
        String[] parts = inputLine.split(" ");

        // Convert the parts to integers
        int line = Integer.parseInt(parts[0]);
        int line2 = Integer.parseInt(parts[1]);
        int line3 = Integer.parseInt(parts[2]);
    
        
      for (int i = 1; i < line+1; i++) {
            if (i % line2 == 0 && i % line3 == 0) {
                System.out.println("AB");
            } else if (i % line2 == 0) {
                System.out.println("A");
            } else if (i % line3 == 0) {
                System.out.println("B");
            } else {
                System.out.println("N");
            }
        }
    }
}
