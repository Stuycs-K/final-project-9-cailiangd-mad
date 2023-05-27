Component previous;
Component fol1, fol2;
endJunction end;
public class startJunction extends Component{
  public startJunction(int x, int y) {
    super(0,0,x,y,startJunction);
  }
  
  //following 6 mthods can be repalced with get and add methods.
   public Component prev() {
    return previous;
  }
  
  public Component fol1() {
    return fol1;
  }
 
  
  public Component fol2() {
    return fol2;
  }
  
  public Component end() {
    return end;
  }
  
  public Component setPrev(Component newPrev) {
    Component temp = previous;
    previous = newPrev;
    return temp;
  }
  
    public Component setFol1(Component newFol) {
    Component temp = fol1;
    fol1 = newFol;
    return temp;
  }
  
    public Component setFol2(Component newFol) {
    Component temp = prev2;
    fol2 = newFol;
    return temp;
  }
  
  public void setEnd(endJunction end_) {
    end = end_;
  }
  
  
    public void calculate() {
    if (previous != null && previous.type() == resistor && previous.type() == endJunction) {
      setCur(previous.current);
      setVol(current()*resistance());
      setPow(current()*voltage());
      followR.calculate();
    }
    else if (previous != null) {
      setVol(previous.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
      followR.calculate();
    }
  }
  
  public double REQsub() {
       double temp = 0;
   for (int i = 0; i < followList.size(); i++) {
     temp += 1/(followList.get(i).REQsub());
   }
   return 1/temp+end.REQsub();
  }
  
  public void findPartner() {
    trace();
    tracker(this);
    clearTrack();
  }
  
        public void trace() {
      setTarget(false);
      fol1.trace();
  }
  
  public void tracker(startJunction start) {
    fol2.tracker(start);
  }
  
  public void clearTrack() {
          setTarget(false);
      fol1.clearTrack();
  }
  
}
