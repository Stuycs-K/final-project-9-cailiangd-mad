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
  public Component(double Voltage, double Resistance) {
    voltage = Voltage;
    resistance = Resistance;
  }
  public Component(double Resistance) {
    resistance = Resistance;
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
    return "R: "+resistance+"  I: "+current+"  V: "+voltage+"  P: "+power;
  }

  public void setRes(double newRes) {
    resistance = newRes;
  }
}
