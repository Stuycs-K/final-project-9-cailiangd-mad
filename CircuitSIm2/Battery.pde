ArrayList<Component> followList;
public class Battery extends Component{
  public Battery(double newVol) {
  super(0,newVol,width/2,height/2+16,battery);
  followList = new ArrayList<Component>();
  }
  
  public boolean connectFol(Component newComp) {
    followList.add(newComp);
    return true;
  }
 
   //actually just removes items from followList.
  public Component setFol(Component newFol, int mode) {
    Component temp = followList.get(followList.size()-1);
    followList.set(followList.size()-1,newFol);
    return temp;
  }
  
  public String debugToString() {
    String temp = "";
    for (int i = 0; i < followList.size(); i++) {
    temp += followList.get(i).toString() + "\n";
  }
  if (temp.length() > 0) {
  return temp.substring(0,temp.length()-1);
  }
  return temp;
}



 public double REQsub() {
   setREQsub(0);
   for (int i = 0; i < followList.size(); i++) {
     if (followList.get(i) != null) {
     setREQsub(getREQsub()+(1.0/(followList.get(i).REQsub())));
     }
   }
   setREQsub(1.0/getREQsub());
   return getREQsub();
 }
 
 public void calculate() {
     setCur(voltage()/getREQsub());
      for (int i = 0; i < followList.size(); i++) {
        if (followList.get(i) != null) {
     followList.get(i).calculate();
        }
   }
 }
 
 public ArrayList<Component> followList() {
   return followList;
 }

}
