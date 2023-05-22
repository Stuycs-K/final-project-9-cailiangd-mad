import java.util.*;
import java.io.*;
public class Component{
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private ArrayList<Component> previous;
  private ArrayList<Component> following;
  private int x;
  private int y;
  public Component(double Voltage, double Resistance, int x_, int y_) {
    voltage = Voltage;
    resistance = Resistance;
    x=x_;
    y=y_;
    previous = new ArrayList<Component>();
    following = new ArrayList<Component>();
  }
  public Component(double Resistance, int x_, int y_) {
    resistance = Resistance;
    x=x_;
    y=y_;
    previous = new ArrayList<Component>();
    following = new ArrayList<Component>();
  }
  public double getResistance() {
    return resistance;
  }
  public double getCurrent() {
    return current;
  }
  public double getVoltage() {
    return voltage;
  }
  public double getPower() {
    return power;
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }

  public String toString() {
    return "R: "+resistance+"  I: "+current+"  V: "+voltage+"  P: "+power+ "  X: "+x+"  Y: "+y;
  }

  public void setRes(double newRes) {
    resistance = newRes;
  }

  public void setVolt(double newVolt) {
    voltage = newVolt;
  }

  public void addPrevious(Component newPre) {
    previous.add(newPre);
  }

  public void addFollowing(Component newFol) {
    following.add(newFol);
  }
}
