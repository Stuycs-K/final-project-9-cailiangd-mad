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
  private ArrayList<Component> prev;
  private ArrayList<Component> fol;
  public Component(double Resistance, double Voltage, int x_, int y_) {
    voltage = Voltage;
    resistance = Resistance;
    x=x_;
    y=y_;
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
  
  public ArrayList<Component> followList() {
    return new ArrayList<Component>();
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
  public void calculate() {
  }

  //Connection methods
  public boolean connectPre(Component newComp) {
    return true;
  }
  public boolean connectFol(Component newComp) {
   return true;
  }
  
    public Component setFol(Component newFol, int mode) {
    return null;
  }

    public Component setPre(Component newPre, int mode) {
    return null;
  }
}
