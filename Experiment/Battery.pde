public class Battery extends Component{
  public Battery(double newVol, int name) {
  super(0,newVol,width/2,height/2+16,battery,name);
  }
  
   //calculate for RIVP
  public ArrayList<double[]> genMatrix(double[] in) {
    in[name()] = resistance();
    in[in.length-1] += voltage();
    ArrayList<double[]> gen = new ArrayList<double[]> ();
    for (int i = 0; i < fol().size(); i++) {
      ArrayList<double[]> temp = fol().get(i).genMatrix(in);
      for (int k = 0; k < temp.size(); k++) {
        gen.add(temp.get(k));
      }
    }
    return gen;
  }
  
  public String debugToString() {
    String temp = "";
    for (int i = 0; i < fol().size(); i++) {
    temp += fol().get(i).toString() + "\n";
  }
  if (temp.length() > 0) {
  return temp.substring(0,temp.length()-1);
  }
  return temp;
}
}
