package java_programs.for_loop.series.pdf;
import java.util.Scanner;
//L and P. S = X/1! + X/2! + X/3! + X/4! +....................+ X/N!
public class l_p_SeriesX {
    public static void main(String[] args) {
        Scanner sc=new Scanner(System.in);
        System.out.print("Enter X and no. of terms : ");
        int x=sc.nextInt(),n=sc.nextInt();
        double s=0,f=1;
        for(int i=1;i<=n;i++) {
            f*=i;
            s+=x/f;
            System.out.print(x+"/"+f);
            if(i!=n)
                System.out.print(" + ");
        }
        System.out.println("\nSum : "+s);
        sc.close();
    }
}
