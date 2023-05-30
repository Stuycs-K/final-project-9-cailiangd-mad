Component previousR; 
Component followR;
public class Resistor extends Component{
  public Resistor(double Res, int x, int y) {
    super(Res,0,x,y,resistor);  
}
  // general get methods
  public Component following() {
    return followR;
  }
  
  public Component previous() {
    return previousR;
  }
  
  public ArrayList<Component> followList() {
    ArrayList<Component> temp = new ArrayList<Component> ();
    temp.add(followR);
    return temp;
  }
  
  // general set methods
  public Component setFollowing(Component newFol) {
    Component temp = followR;
    followR = newFol;
    return temp;
  }
  
    public Component setPrevious(Component newPre) {
    Component temp = previousR;
    previousR = newPre;
    return temp;
  }
  //general connect methods
  public boolean connectPre(Component newComp) {
    if (previous() == null && following() != newComp) {
      setPrevious(newComp);
      return true;
    }
    else  return false;
  }
  public boolean connectFol(Component newComp) {
    if (following() == null && previous() != newComp)  {
      setFollowing(newComp);
      return true;
    }
    else return false;
  }
  
  
    public double REQsub() {
      if (followR == null || followR.type() == endJunction) {
        setREQsub(resistance());
      }
      else setREQsub(followR.REQsub() + resistance());
    return getREQsub();
  }
  
    public void calculate() {
    if (previousR != null && previousR.type() == resistor && previousR.type() == endJunction) {
      setCur(previousR.current);
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null) {
      setVol(previousR.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
    }
    if (followR != null) {
      followR.calculate();
    }
  }
  
    public void trace() {
      setTarget(true);
      followR.trace();
  }
  
  public void tracker(startJunction start) {
    followR.tracker(start);
  }
  
  public void clearTrack() {
    setTarget(false);
    followR.clearTrack();
  }
 
}
