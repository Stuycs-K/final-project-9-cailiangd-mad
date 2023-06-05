import java.util.*;
import java.io.*;
public class Component{
  private int type;
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private int x;
  private int y;
  private ArrayList<Component> pre;
  private ArrayList<Component> fol;
  public Component(double Resistance, double Voltage, int x_, int y_) {
    voltage = Voltage;
    resistance = Resistance;
    x=x_;
    y=y_;
    pre = new ArrayList<Component> ();
    fol = new ArrayList<Component> ();
  }
  //general get methods
  public double resistance() {
    return resistance;
  }

  public double current() {
    return current;
  }

  public double voltage() {
    return voltage;
  }

  public double power() {
    return power;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

   public int type() {
     return type;
   }
  
  public ArrayList<Component> fol() {
    return fol;
  }
  
  public ArrayList<Component> pre() {
    return pre;
  }
  
  public String toString() {
    return "R: "+resistance+"  I: "+current+"  V: "+voltage+"  P: "+power+ "  X: "+x+"  Y: "+y;
  }

  //general set methods
  public void setRes(double newRes) {
    resistance = newRes;
  }

  public void setVol(double newVolt) {
    voltage = newVolt;
  }

  public void setCur(double newCur) {
    current = newCur;
  }

  public void setPow(double newPow) {
    power = newPow;
  }

  //calculate for RIVP
  public ArrayList<double[]> calculate(double[]) {
    
  }

  //Connection methods
  public void connectPre(Component newComp) {
    pre.add(newComp);
  }
  public void connectFol(Component newComp) {
   fol.add(newComp);
  }
  
    public Component removeFol(int pos) {
     Component temp = fol.get(pos);
    fol.remove(pos);
    return temp;
  }

    public Component removePre(int pos) {
     Component temp = pre.get(pos);
    pre.remove(pos);
    return temp;
  }
}
