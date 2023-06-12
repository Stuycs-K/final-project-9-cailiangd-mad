public class Resistor extends Component{
  Component previousR;
Component followR;
  public Resistor(double Res, int x, int y) {
    super(Res,0,x,y,resistor);
    previousR = null;
    followR = null;
}

  // general get methods
  public Component fol() {
    return followR;
  }

  public Component prev() {
    return previousR;
  }

  public ArrayList<Component> prepFollowList() {
    super.clearFollowList();
    super.addFollowList(followR);
    return super.followList();
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
    if (prev() == null && fol() != newComp) {
      setPre(newComp, 0);
      return true;
    }
    else  return false;
  }
  public boolean connectFol(Component newComp) {
    if (fol() == null && prev() != newComp)  {
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
    /* Our calculate methods rely on recursion to calculate the REQ of the following resistors, with a check to determine whether or not the next 
    component is a start or end junction. When that happens, we set the current on the junction to be the same. 
    */
    public void calculate() {
    if (previousR != null && (previousR.type() == resistor || previousR.type() == endJunction)) {
      setCur(previousR.current());
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null  && previousR.type() == battery) {
       setCur(previousR.voltage()/getREQsub());
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null && previousR.type() == startJunction) {
            if (previousR.followList().size() > 1) {
      double val = (previousR.followList().get((previousR.followList().indexOf(this)+1)%2).getREQsub());
      setCur(previousR.current()*(val/(getREQsub()+val)));
      }
      else {
        setCur(previousR.current());
      }
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null) {
      setVol(previousR.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
    }
    if (followR != null && followR.type() != endJunction) {
      followR.calculate();
    }
  }

    public void trace() {
      setTarget(true);
      if (followR != null) {
      followR.trace();
      }
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

}
