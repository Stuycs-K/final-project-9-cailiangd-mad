import java.util.*;
import java.io.*;
public class Driver{
  public static void main(String[] args) {
    Circuit mainC = new Circuit();
    Component r1 = new Resistor(8,100,100,1);
    Component r2 = new Resistor(10,200,200,2);
    Component r3 = new Resistor(12,300,300,3);
    r1.connectPre(mainC.get(0));
    r2.connectPre(mainC.get(0));
    r3.connectPre(r2);
    mainC.get(0).connectFol(r1);
    mainC.get(0).connectFol(r2);
    r2.connectFol(r3);
    mainC.add(r1);
    mainC.add(r2);
    mainC.add(r3);
    System.out.println(mainC);
    mainC.getMatrix();
  }

  public static void matrixOut(ArrayList<double[]> matrix) {
   for (int i = 0; i < matrix.size(); i++) {
     System.out.println(Arrays.toString(matrix.get(i)));
   }
}
}
