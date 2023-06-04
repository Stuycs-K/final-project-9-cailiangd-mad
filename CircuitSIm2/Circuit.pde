public class Circuit{
  private double REQ;
  private double IEQ;
  private double VEQ;
  private double PEQ;
  ArrayList<Component> compList;

  public Circuit() {
    this(12);
  }

  public Circuit(double voltage) {
    Component battery1 = new Battery(voltage);
    VEQ = voltage;
    compList = new ArrayList<Component>();
    add(battery1);
  }
public void undo() {
  /* Remove the previously added last resistor from the list */
  mainC.compList.remove(mainC.compList.size()-1);
  /* disconnect that resistor */
  
  if (mainC.compList.get(mainC.compList.size()-1).followList().size() > 1){
    mainC.compList.get(mainC.compList.size()-1).followList().remove(followList.size()-1);
  }
  else {
    mainC.compList.get(mainC.compList.size()-1).connectFol(mainC.compList.get(0));
  }
  
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
    VEQ = newVEQ;
    get(0).setVol(VEQ);
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

  public String debugToString() {
    String res = "";
    for (int i = 0; i < compList.size(); i++) {
      res+=compList.get(i)+"\n";
    }
    return res.substring(0,res.length()-1);
  }

 public void calculateREQ() {
    REQ = get(0).REQsub();
 }

 public void calculateIVPeq() {
   IEQ = VEQ/REQ;
   PEQ = VEQ * IEQ;
 }

public void calculateIVP() {
  for (int i = 0; i < size(); i++) {
    get(i).calculate();
  }
}

public void calculate() {
  calculateREQ();
  calculateIVPeq();
  calculateIVP();
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
