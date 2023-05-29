import java.util.*;
import java.io.*;
public class Component{
  private int type;
  private double REQsub;
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private int x;
  private int y;
  private boolean target;
  public Component(double Resistance, double Voltage, int x_, int y_, int Type) {
    voltage = Voltage;
    resistance = Resistance;
    type = Type;
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

  public String toString() {
    return "R: "+resistance+"  I: "+current+"  V: "+voltage+"  P: "+power+ "  X: "+x+"  Y: "+y+ "  REQsub: "+REQsub;
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


  //REQ related methods
  public double getREQsub() {
    return REQsub;
  }

  public double REQsub() {
  return REQsub;
  }

  public void setREQsub(double in) {
    REQsub = in;
  }

  //calculate for RIVP
  public void calculate() {
  }
  /////Methods need to find loop endings.
  public void trace() {
  }

  public void tracker(startJunction start) {
  }

  public void clearTrack() {
  }

  public void setTarget(boolean val) {
    target = val;
  }

  public boolean target() {
    return target;
  }
  //Connection methods
  public void connectPre(Component newComp) {
  }
  public void connectFol(Component newComp) {
  }
}
