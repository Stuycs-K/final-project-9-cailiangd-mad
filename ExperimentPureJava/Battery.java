import java.util.*;
import java.io.*;
public class Battery extends Component{
  public Battery(double newVol, int name) {
  super(0,newVol,0,0,100,name);
  }

   //calculate for RIVP
  public ArrayList<double[]> genMatrix(double[] in) {
    in[name()] = resistance();
    in[in.length-1] += voltage();
    ArrayList<double[]> gen = new ArrayList<double[]> ();
    for (int i = 0; i < fol().size(); i++) {
      ArrayList<double[]> temp = fol().get(i).genMatrix(Arrays.copyOf(in,in.length));
      for (int k = 0; k < temp.size(); k++) {
        gen.add(temp.get(k));
      }
    }
        System.out.println(this);
    System.out.println(in);
    System.out.println(Arrays.toString(in));
    System.out.println("matrix");
    Driver.matrixOut(gen);
    return gen;
  }

  public String debugToString() {
    String temp = "";
    for (int i = 0; i < fol().size(); i++) {
    temp += fol().get(i).toString() + "\n";
  }
  if (temp.length() > 0) {
  return temp.substring(0,temp.length()-1);
  }
  return temp;
}
}
