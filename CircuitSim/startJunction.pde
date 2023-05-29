Component previous;
Component fol1, fol2;
endJunction end;
public class startJunction extends Component{
  public startJunction(int x, int y) {
    super(0,0,x,y,startJunction);
  }
  
  // general get methods
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
  
   public ArrayList<Component> followList() {
    ArrayList<Component> temp = new ArrayList<Component> ();
    temp.add(fol1);
    temp.add(fol2);
    return temp;
  }
  
  public Component setPre(Component newPrev) {
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
  //connect methodss
  public void connectFol(Component newComp) {
    if (fol1() == null) {
      setFol1(newComp);
    }
    if (fol2() == null) {
      setFol2(newComp);
    }
  }
  
  public void connectPre(Component newComp) {
    setPre(newComp);
  }
  
    public void setStart(Component start_) {
      start = (startJunction) start_;
    }
  public void setEnd(endJunction end_) {
    end = end_;
  }
  
  
    public void calculate() {
    if (previous != null && previous.type() == resistor && previous.type() == endJunction) {
      setCur(previous.current);
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previous != null) {
      setVol(previous.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
    }
    if (fol1 != null) {
      fol1.calculate();
    }
    if (fol2 != null) {
      fol2.calculate();
    }
  }
  
  public double REQsub() {
    if (fol1 != null && fol2 != null) {
             double temp = 0;
       temp += 1/(fol1.REQsub());
       temp += 1/(fol2.REQsub());
       if (end != null) {
   return (1/temp)+end.REQsub();
       }
       else {
       return (1/temp);
       }
    }
    else if (fol1 != null) {
      return fol1.REQsub();
    }
    return 0;
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
