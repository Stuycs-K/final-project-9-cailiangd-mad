import java.util.*;
import java.io.*;
public class Circuit{
  ArrayList<Component> compList;
  int count = 0;
  public Circuit() {
    this(12);
  }

  public Circuit(double voltage) {
    Component battery1 = new Battery(voltage,count());
    compList = new ArrayList<Component>();
    add(battery1);
  }

   public int count() {
     return count++;
   }

  public void add(Component newComp) {
    compList.add(newComp);
  }

  public void remove(int pos) {
    compList.remove(pos);
  }

  public String getCompList() {
    return compList.toString();
  }

  public int size() {
    return compList.size();
  }

  public String toString() {
    String res = "";
    for (int i = 0; i < compList.size(); i++) {
      res+=compList.get(i)+"\n";
    }
    return res.substring(0,res.length()-1);
  }

 public void getMatrix() {
    Driver.matrixOut(compList.get(0).genMatrix(new double[compList.size()+1]));
 }

public void calculateIVP() {
  for (int i = 0; i < size(); i++) {
    get(i).calculate();
  }
}

public Component chooseComp(int x,int y) {
  int pos = 0;
  for (int i = 1; i < compList.size(); i++) {
    if (
    Math.sqrt(
    (x-compList.get(i).getX())*(x-compList.get(i).getX())
    +
    (y-compList.get(i).getY())*(y-compList.get(i).getY())
    )
    <
    Math.sqrt(
    (x-compList.get(pos).getX())*(x-compList.get(pos).getX())
    +
    (y-compList.get(pos).getY())*(y-compList.get(pos).getY())
    )
    )
    pos = i;
  }
  return compList.get(pos);
}


public Component get(int i) {
  return compList.get(i);
}


}
