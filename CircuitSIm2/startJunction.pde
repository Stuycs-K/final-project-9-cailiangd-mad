public class startJunction extends Component{
  Component previous;
Component fol1, fol2;
endJunction end;
  public startJunction(int x, int y) {
    super(0,0,x,y,startJunction);
    previous = null;
    fol1 = null;
    fol2 = null;
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
  
  public Component setPre(Component newPrev, int mode) {
    Component temp = previous;
    previous = newPrev;
    return temp;
  }
  
    public Component setFol(Component newFol, int mode) {
    Component temp;
    if (mode == 0) {
    temp = fol1;
    fol1 = newFol;
    }
    else {
    temp = fol2;
    fol2 = newFol;
    }
    return temp;
  }

  //connect methods
  public boolean connectFol(Component newComp) {
    if (fol1() == null) {
      setFol(newComp,0);
      return true;
    }
    else if (fol2() == null && fol1() != newComp && prev() != newComp) {
      setFol(newComp,1);
      return true;
    }
    else return false;
  }
  
  public boolean connectPre(Component newComp) {
    if (prev() == null && fol1() != newComp && fol2() != newComp) {
      setPre(newComp, 0);
      return true;
    }
    else return false;
  }

  public void setEnd(endJunction end_) {
    end = end_;
  }
  
  
    public void calculate() {

      if (previous.type() == startJunction) {
      setCur(previous.voltage()/getREQsub());
      }
      else {
        setCur(previous.current());
      }

      if (end != null) {
       end.calculate();
      setVol(getREQsub()*current()-end.voltage());
      }
      else {
        setVol(getREQsub()*current());
      }
    if (fol1 != null) {
      fol1.calculate();
    }
    if (fol2 != null) {
      fol2.calculate();
    }
  }
  
  public double REQsub() {

        println("this junction's x y coordinates" + this.getX() + " " + this.getY());
        println("ending junction x y coordinates" + end.getX() + " " + end.getY());
        //println("hello-1");

    if (fol1 != null && fol2 != null) {
             double temp = 0;
       temp += 1.0/(fol1.REQsub());
       temp += 1.0/(fol2.REQsub());
       if (end != null) {
    setREQsub((1.0/temp)+end.REQsub());
       }
       else {
       setREQsub(1.0/temp);
       }
    }
    else if (fol1 != null) {
      setREQsub(fol1.REQsub());
    }
    else {
      setREQsub(0);
    }
    return getREQsub();
  }
  
  public void findPartner() {
    trace();
    tracker(this);
    clearTrack();
  }
  
        public void trace() {
      setTarget(true);
      if (fol1 != null) {
      fol1.trace();
      }
  }
  
  public void tracker(startJunction start) {
    if (fol2 != null) {
    fol2.tracker(start);
    }
  }
  
  public void clearTrack() {
          setTarget(false);
          if (fol1 != null) {
      fol1.clearTrack();
          }
  }
  
}
