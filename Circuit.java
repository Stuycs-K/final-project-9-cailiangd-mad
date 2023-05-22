import java.util.*;
import java.io.*;
public class Circuit{
  private Component firstComp;
  private double REQ;
  private double IEQ;
  private double VEQ;
  private double PEQ;
  ArrayList<Component> compList;

  public static Component getfirstComp() {
    return getfirstComp;
  }

  public static double getREQ() {
    return REQ;
  }

  public static double getIEQ() {
    return IEQ;
  }

  public static double getVEQ() {
    return VEQ;
  }

  public static double getPEQ() {
    return PEQ;
  }
}
