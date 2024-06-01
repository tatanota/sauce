//C149:大文字小文字

import java.util.*;
public class Main {
    public static void main(String[] args) {
        // 自分の得意な言語で
        // Let's チャレンジ！！
        Scanner sc = new Scanner(System.in);
        
        String line = sc.nextLine();
        String line2 = sc.nextLine();
        
        String upline2 = line2.toUpperCase(); 
        String upline3 = line2.toLowerCase(); 
        
        int linelen = line.length();
        int linelen2 = line2.length();
        
        
        String an = "";
       

           for (int j= 0; j< linelen2; j++){
                      for (int i= 0;i< linelen;i++){
               //           System.out.println(j);
               //      System.out.println("A:" + line.charAt(i)); //  a       
                //     System.out.println("B:" + line2.charAt(j));  //P
                          
              if(line.charAt(i) == upline2.charAt(j) || line.charAt(i) == upline3.charAt(j) ){
                    an += line.charAt(i);


              }
              
           }
       }
       System.out.println(an);
    }
}
