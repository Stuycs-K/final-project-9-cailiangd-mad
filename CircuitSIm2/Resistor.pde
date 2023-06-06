public class Resistor extends Component{
  Component previousR;
Component followR;
double VEQ;
ArrayList<Component> temp;
  public Resistor(double Res, int x, int y, double newVEQ) {
    super(Res,0,x,y,resistor);
    previousR = null;
    followR = null;
    setVEQ(newVEQ);
}

  // general get methods
  public Component following() {
    return followR;
  }

  public Component previous() {
    return previousR;
  }

  public ArrayList<Component> followList() {
    temp = new ArrayList<Component> ();
    temp.add(followR);
    return temp;
  }

  // general set methods
  public Component setFol(Component newFol, int mode) {
    Component temp = followR;
    followR = newFol;
    return temp;
  }

    public Component setPre(Component newPre, int mode) {
    Component temp = previousR;
    previousR = newPre;
    return temp;
  }
  //general connect methods
  public boolean connectPre(Component newComp) {
    if (previous() == null && following() != newComp) {
      setPre(newComp, 0);
      return true;
    }
    else  return false;
  }
  public boolean connectFol(Component newComp) {
    if (following() == null && previous() != newComp)  {
      setFol(newComp, 0);
      return true;
    }
    else return false;
  }


    public double REQsub() {
      if (followR == null || followR.type() == endJunction) {
        setREQsub(resistance());
        return getREQsub();
      }
      else {
        setREQsub(followR.REQsub() + resistance());
      }
    return getREQsub();
  }

    public void calculate() {
    if (previousR != null && (previousR.type() == resistor || previousR.type() == endJunction)) {
      setCur(previousR.current());
      setVol(current()*resistance());
      setPow(current()*voltage());
      //println(this);
      //println(previousR);
    }
    else if (previousR != null  && previousR.type() == battery) {
       setCur(previousR.voltage()/getREQsub());
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null && previousR.type() == startJunction) {
      setCur(previousR.voltage()/(getREQsub()));
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null) {
      setVol(previousR.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
    }
    if (followR != null && followR.type() != endJunction) { //<>//
      followR.calculate();
    }
  } //<>//

    public void trace() {
      setTarget(true); //<>//
      if (followR != null) {
      followR.trace();
      } //<>//
  }

  public void tracker(startJunction start) {
    if (followR != null) {
    followR.tracker(start);
    }
  }

  public void clearTrack() {
    setTarget(false);
    if (followR != null) {
    followR.clearTrack();
    }
  }
  
  public void setVEQ(double newVEQ) {
    VEQ = newVEQ;
  }
  
  public double VEQ() {
  return VEQ;
  }

}
