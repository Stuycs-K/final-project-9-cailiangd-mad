public class endJunction extends Component{
  Component prev1, prev2;
Component follow;
Component start;
ArrayList<Component> temp;
  public endJunction(int x, int y, Component newStart) {
    super(0,0,x,y,endJunction);
    follow = null;
    prev1 = null;
    prev2 = null;
    start = newStart;
  }
  
  // general get methods
   public Component fol() {
    return follow;
  }
  
  public Component prev1() {
    return prev1;
  }
 
  public Component prev2() {
    return prev2;
  }
  
  public Component start() {
    return start;
  }
  
    public ArrayList<Component> followList() {
      temp = new ArrayList<Component> ();
    temp.add(follow);
    return temp;
  }
  
  //general set methods
  public Component setFol(Component newFol, int mode) {
    Component temp = follow;
    follow = newFol;
    return temp;
  }
  
    public Component setPre(Component newPre, int mode) {
    Component temp;
    if (mode == 0) {
    temp = prev1;
    prev1 = newPre;
    }
    else {
      temp = prev2;
      prev2 = newPre;
    }
    return temp;
  }
 
  //connect methodss
  public boolean connectPre(Component newComp) {
    if (prev1() == null) {
      setPre(newComp,0);
      return true;
    }
    else if (prev2() == null && prev1() != newComp && fol() != newComp) {
      setPre(newComp,1);
      return true;
    }
    else return false;
  }
  
  public boolean connectFol(Component newComp) {
    if (fol() == null && prev1() != newComp && prev2() != newComp) {
      setFol(newComp, 0);
      return true;
    }
    else return false;
  }
  
    public void setStart(Component start_) {
      start = (startJunction) start_;
    }
  
  //change to list, use loop
  public void calculate() {
    setCur(start.current());
    if (follow != null) {
    follow.calculate();
    setVol(follow.voltage());
    }
  }
  
      public double REQsub() {
      if (follow == null || follow.type() == endJunction) {
        setREQsub(0);
      }
      else if (follow != null) {
        setREQsub(follow.REQsub());
      }
      else {
        setREQsub(0);
      }
    return getREQsub();
  }
  
      public void trace() {
      setTarget(true);
      if (follow != null) {
      follow.trace();
      }
  }
  
  public void tracker(startJunction starter) {
    if (target()) {
      start = starter;
      starter.setEnd(this);
    }
    else if (follow != null) {
    follow.tracker(starter);
    }
  }
  
  public void clearTrack() {
    setTarget(false);
    if (follow != null) {
    follow.clearTrack();
    }
  }
    
}
