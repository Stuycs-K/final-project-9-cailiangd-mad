import java.util.*;
import java.io.*;
public class Circuit{
  private Component firstComp;
  private double REQ;
  private double IEQ;
  private double VEQ;
  private double PEQ;
  ArrayList<Component> compList;

  public Circuit(double voltage) {
    Component battery = new Component(voltage);
    firstComp = battery;
    VEQ = voltage;
  }

  public Component getfirstComp() {
    return firstComp;
  }

  public double getREQ() {
    return REQ;
  }

  public double getIEQ() {
    return IEQ;
  }

  public double getVEQ() {
    return VEQ;
  }

  public double getPEQ() {
    return PEQ;
  }
  public String toString() {
    return "REQ: "+REQ+" IEQ: "+IEQ+" VEQ: "+VEQ+" PEQ: "+PEQ;
  }
}
