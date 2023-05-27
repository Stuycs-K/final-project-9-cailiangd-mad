Component prev1, prev2;
Component follow;
startJunction start;
public class endJunction extends Component{
  public endJunction(int x, int y) {
    super(0,0,x,y,startJunction);
  }
  
  //following 6 methods can be replaced with a add and get methods.
   public Component fol() {
    return follow;
  }
  
  public Component prev1() {
    return prev1;
  }
 
  public Component prev2() {
    return prev2;
  }
  
  public startJunction start() {
    return start;
  }
  
  public Component setFol1(Component newFol) {
    Component temp = follow;
    follow = newFol;
    return temp;
  }
  
    public Component setPre1(Component newPre) {
    Component temp = prev1;
    prev1 = newPre;
    return temp;
  }
  
    public Component setPre2(Component newPre) {
    Component temp = prev2;
    prev1 = newPre;
    return temp;
  }
  
    public void setStart(Component start_) {
      start = (startJunction) start_;
    }
  
  //change to list, use loop
  public void calculate() {
    setCur(0);
    if (prev1 != null) {
      setCur(current()+prev1.current());
    }
    if (prev2 != null) {
      setCur(current()+prev2.current());
    }
    follow.calculate();
  }
  
      public double REQsub() {
      if (follow == null || follow.type() == endJunction) {
        setREQsub(resistance());
      }
      setREQsub(follow.REQsub() + resistance());
    return getREQsub();
  }
  
      public void trace() {
      setTarget(true);
      follow.trace();
  }
  
  public void tracker(startJunction starter) {
    if (target()) {
      start = starter;
      starter.setEnd(this);
    }
    else follow.tracker(starter);
  }
  
  public void clearTrack() {
    setTarget(false);
    follow.clearTrack();
  }
    
}
