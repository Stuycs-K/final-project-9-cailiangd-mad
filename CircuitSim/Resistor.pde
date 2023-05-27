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
  
    public double REQsub() {
      if (followR == null || followR.type() == endJunction) {
        setREQsub(resistance());
      }
      setREQsub(followR.REQsub() + resistance());
    return getREQsub();
  }
  
    public void calculate() {
    if (previousR != null && previousR.type() == resistor && previousR.type() == endJunction) {
      setCur(previousR.current);
      setVol(current()*resistance());
      setPow(current()*voltage());
      followR.calculate();
    }
    else if (previousR != null) {
      setVol(previousR.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
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
