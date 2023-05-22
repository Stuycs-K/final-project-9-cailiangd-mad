public class Driver {
  public static void main(String[] args) {
    Circuit cirt1 = new Circuit(12);
    System.out.println(cirt1.getFirstComp());
    System.out.println(cirt1);
    System.out.println(cirt1.getCompList());
        System.out.println("-------------------");
    cirt1.add(new Component(10,7,11));
    System.out.println(cirt1.getFirstComp());
    System.out.println(cirt1);
    System.out.println(cirt1.getCompList());
    System.out.println(cirt1.debugToString());
    System.out.println("-------------------");
    cirt1.add(new Component(20,2,15,19));
    System.out.println(cirt1.getFirstComp());
    System.out.println(cirt1);
    System.out.println(cirt1.getCompList());
    System.out.println(cirt1.debugToString());
    System.out.println("-------------------");
    cirt1.getFirstComp().setRes(500);
    cirt1.getFirstComp().setVolt(50);
    System.out.println(cirt1.getFirstComp());
//----------------------------------------------------
    System.out.println("-------------------");
    Circuit cirt2 = new Circuit();
    System.out.println(cirt2.getFirstComp());
    System.out.println(cirt2);
    System.out.println(cirt1.getCompList());
    System.out.println(cirt1.debugToString());
//----------------------------------------------------
System.out.println("-------------------");
System.out.println("-------------------");
Component tar1 = new Component(50,70,90);
System.out.println(tar1);
  }
}
