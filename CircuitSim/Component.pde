import java.util.*;
import java.io.*;
public class Component{
  private int type;
  private double REQsub;
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private ArrayList<Component> previous;
  private ArrayList<Component> following;
  private int x;
  private int y;
  private boolean solved;
  public Component(double Voltage, double Resistance, int x_, int y_) {
    voltage = Voltage;
    resistance = Resistance;
    x=x_;
    y=y_;
    previous = new ArrayList<Component>();
    following = new ArrayList<Component>();
    type = battery;
  }
  public Component(double Resistance, int x_, int y_) {
    resistance = Resistance;
    x=x_;
    y=y_;
    previous = new ArrayList<Component>();
    following = new ArrayList<Component>();
    type = resistor;
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

  public void setVoltage(double newVolt) {
    voltage = newVolt;
  }


  public void addPrevious(Component newPre) {
    previous.add(newPre);
  }

  public void addFollowing(Component newFol) {
    following.add(newFol);
  }

  public ArrayList<Component> getFollowing() {
    return following;
  }
  public ArrayList<Component> getPrevious() {
    return previous;
  }
  public String previousToString() {
    return previous.toString();
  }
  public String followingToString() {
    return following.toString();
  }

/*
I kind of want calculateReqSub to recursively call itself up the chain so that the calculateReqSub
for the main battery will be able to send the actual REQ for the entire circuit to the
calculateREQ method in the Circuit class.

Also I was hoping to include solved in the calculateReqSub method so that we don't call the same
component multiple time and screwing with our numbers since multiple components can tie back to
one component.

We could also implament solved in calculateStat for effeciency reasons.
*/
  public double calculateReqSub() {
    if (solved) {
      solved = true;
    double result = resistance;
    if (following.size() > 1) {
      for (int i=0; i < following.size(); i++) {
        result += 1.0 / (following.get(i).calculateReqSub());
      }
      REQsub = 1.0/result;
      return 1.0/result;
    }
    else {
      result += following.get(0).calculateReqSub();
      REQsub = result;
      return result;
    }
  }
  return REQsub;
  //Might be a problem we will have to see.
  }

  public void resetSolved() {
  if (solved) {
       solved = !solved;
      }
    for (int i=0; i < following.size(); i++) {
      following.get(i).resetSolved();
      }
    }
    /** CalculateStat helps calculate all of the instance variables (such as resistance, voltage) of the component.*/
    
/
  public void calculateStat() {
    if (!solved) {
        solved = true;
        if (previous.size() == 0) {
          current = voltage / REQsub;
          }
        else if (previous.size() == 1) {
          current = previous.get(0).getCurrent();
          voltage = current * resistance;
          power = voltage * current;
        }
        else {
          voltage = previous.get(0).getVoltage();
          current = voltage/resistance;
          power = current*voltage;
        }
        }
        }
   
   public int getType() {
     return type;
   }

}
