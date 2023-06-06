public class Circuit{
  ArrayList<Component> compList;
  int count = 0;
  public Circuit() {
    this(12);
  }

  public Circuit(double voltage) {
    Component battery1 = new Battery(voltage,count());
    compList = new ArrayList<Component>();
    add(battery1);
  }
 
   public int count() {
     return count++;
   }
//need to rebuild
//need to rebuild
//need to rebuild
//public void undo() {
//  if (isEditMode) {
//  /* Remove the previously added last resistor from the list */
//  compList.remove(compList.size()-1);
//  /* disconnect that resistor */
//  if (compList.get(compList.size()-1).type() == resistor) {
//    compList.get(compList.size()-1).setFol(null,0);
//  }
//  else if (compList.get(compList.size()-1).type() == startJunction) {
//    compList.get(compList.size()-1).setFol(null,0);
//  }
//  else if (compList.get(compList.size()-1).type() == endJunction) {
//    if (compList.get(compList.size()-1).followList().get(1) != null) {
//      compList.get(compList.size()-1).setFol(null,0);
//    }
//    else {
//      compList.get(compList.size()-1).setFol(null,1);
//    }
//  }
//  else if (compList.get(compList.size()-1).type() == battery){
//   compList.get(compList.size()-1).setFol(null,0);
//  }
//  }
//}

  public void add(Component newComp) {
    compList.add(newComp);
  }
  
  public void remove(int pos) {
    compList.remove(pos);
  }

  public String getCompList() {
    return compList.toString();
  }

  public int size() {
    return compList.size();
  }

  public String toString() {
    String res = "";
    for (int i = 0; i < compList.size(); i++) {
      res+=compList.get(i)+"\n";
    }
    return res.substring(0,res.length()-1);
  }

 public void RREF() {
   ArrayList<double[]> matrix = compList.get(0).genMatrix(new double[compList.size()+1]);
   //debugging method
   matrixOut(matrix);
   /*Need to implement.*/
   /*Need to implement.*/
   /*Need to implement.*/
 }
 
   public void matrixOut(ArrayList<double[]> matrix) {
     for (int i = 0; i < matrix.size(); i++) {
       //println(Arrays.toString(matrix.get(i)));
     }
  }
 
 public void pullCurrent() {
      /*Need to implement.*/
   /*Need to implement.*/
   /*Need to implement.*/
 }

public void calculateIVP() {
  for (int i = 0; i < size(); i++) {
    get(i).calculate();
  }
}

public void calculate() {
  RREF();
  pullCurrent();
  calculateIVP();
}

public Component chooseComp(int x,int y) {
  int pos = 0;
  for (int i = 1; i < compList.size(); i++) {
    if (
    Math.sqrt(
    (x-compList.get(i).getX())*(x-compList.get(i).getX())
    +
    (y-compList.get(i).getY())*(y-compList.get(i).getY())
    )
    <
    Math.sqrt(
    (x-compList.get(pos).getX())*(x-compList.get(pos).getX())
    +
    (y-compList.get(pos).getY())*(y-compList.get(pos).getY())
    )
    )
    pos = i;
  }
  return compList.get(pos);
}


public Component get(int i) {
  return compList.get(i);
}


}
