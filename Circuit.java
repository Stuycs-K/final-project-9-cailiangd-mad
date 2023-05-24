import java.util.*;
import java.io.*;
public class Circuit{
  private Component firstComp;
  private double REQ;
  private double IEQ;
  private double VEQ;
  private double PEQ;
  ArrayList<Component> compList;

  public Circuit() {
    this(12);
  }

  public Circuit(double voltage) {
    Component battery = new Component(voltage, 0, 0, 0);
    firstComp = battery;
    VEQ = voltage;
    compList = new ArrayList<Component>();
    add(battery);
  }

  public Component getFirstComp() {
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

  public void setVEQ(double newVEQ) {
    VEQ = firstComp.getVoltage();
  }

  public void add(Component newComp) {
    if (compList.size() == 1) {
      newComp.setVoltage(0);
    }
    compList.add(newComp);

  }

  public String getCompList() {
    return compList.toString();
  }

  public int getCompNum() {
    return compList.size();
  }

  public String debugToString() {
    String res = "";
    for (int i = 0; i < compList.size(); i++) {
      res+=compList.get(i)+"\n";
    }
    return res.substring(0,res.length()-1);
  }

 public void calculateREQ() {
    REQ = getFirstComp().getREQsub();
 }

 public void calculateIVPeq() {
   IEQ = VEQ/REQ;
   PEQ = VEQ * IEQ;
 }

public void calculateIVP() {
  getFirstComp().calculateStat();
}

public void calculate() {
  calculateREQ();
  getFirstComp().resetSolved();
  calculateIVPeq();
  calculateIVP();
  getFirstComp().resetSolved();
}

}
