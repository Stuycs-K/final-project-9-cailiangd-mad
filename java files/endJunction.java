Component prev1, prev2;
Component follow;
startJunction start;
public class endJunction extends Component{
  public endJunction(int x, int y) {
    super(0,0,x,y,endJunction);
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

  public startJunction start() {
    return start;
  }

    public ArrayList<Component> followList() {
    ArrayList<Component> temp = new ArrayList<Component> ();
    temp.add(follow);
    return temp;
  }

  //general set methods
  public Component setFol(Component newFol) {
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
  //connect methodss
  public boolean connectPre(Component newComp) {
    if (prev1() == null) {
      setPre1(newComp);
      return true;
    }
    else if (prev2() == null && prev1() != newComp && fol() != newComp) {
      setPre2(newComp);
      return true;
    }
    else return false;
  }

  public boolean connectFol(Component newComp) {
    if (fol() == null && prev1() != newComp && prev2() != newComp) {
      setFol(newComp);
      return true;
    }
    else return false;
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
    if (follow != null) {
    follow.calculate();
    }
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