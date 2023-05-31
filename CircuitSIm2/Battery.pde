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
   double temp = 0;
   for (int i = 0; i < followList.size(); i++) {
     temp += 1.0/(followList.get(i).REQsub());
   }
   return 1.0/temp;
 }
 
 public void calculate() {
      for (int i = 0; i < followList.size(); i++) {
     followList.get(i).calculate();
   }
 }
 
 public ArrayList<Component> followList() {
   return followList;
 }

}
