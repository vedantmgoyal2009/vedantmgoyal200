package patterns.pdf;
/*  1 3 5 7
      3 5 7
        5 7
          7
*/
public class pdf_12 {
  public static void main(String[] args) {
    java.util.Scanner sc = new java.util.Scanner(System.in);
    System.out.println("Enter no. of lines to print : ");
    int lines = sc.nextInt();
    for (int i = 1; i <= lines; i++) {
      for (int j = 1; j < i; j++) System.out.print("  ");
      for (int j = i; j <= lines; j++) System.out.print((j * 2 - 1) + " ");
      System.out.println();
    }
    sc.close();
  }
}
