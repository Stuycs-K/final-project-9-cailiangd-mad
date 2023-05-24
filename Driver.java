public class Driver {
  public static void main(String[] args) {
//     Circuit cirt1 = new Circuit(12);
//     System.out.println(cirt1.getFirstComp());
//     System.out.println(cirt1);
//     System.out.println(cirt1.getCompList());
//         System.out.println("-------------------");
//     cirt1.add(new Component(10,7,11));
//     System.out.println(cirt1.getFirstComp());
//     System.out.println(cirt1);
//     System.out.println(cirt1.getCompList());
//     System.out.println("Debug List Below");
//     System.out.println(cirt1.debugToString());
//     System.out.println("-------------------");
//     cirt1.add(new Component(20,2,15,19));
//     System.out.println(cirt1.getFirstComp());
//     System.out.println(cirt1);
//     System.out.println(cirt1.getCompList());
//     System.out.println("Debug List Below");
//     System.out.println(cirt1.debugToString());
//     System.out.println("-------------------");
//     cirt1.getFirstComp().setRes(500);
//     cirt1.getFirstComp().setVoltage(50);
//     System.out.println(cirt1.getFirstComp());
// //----------------------------------------------------
//     System.out.println("-------------------");
//     Circuit cirt2 = new Circuit();
//     System.out.println(cirt2.getFirstComp());
//     System.out.println(cirt2);
//     System.out.println(cirt1.getCompList());
//     System.out.println("Debug List Below");
//     System.out.println(cirt1.debugToString());
// //----------------------------------------------------
// System.out.println("-------------------");
// System.out.println("-------------------");
// Component tar1 = new Component(50,70,90);
// System.out.println(tar1);
// Component tar2 = new Component(50,1,100,170);
// tar1.addPrevious(tar2);
// System.out.println("Previous: "+tar1.getPrevious());
// Component tar3 = new Component(10,5,8);
// tar1.addFollowing(tar3);
// System.out.println("Following: "+tar1.getFollowing());

  Circuit full1 = new Circuit();
      System.out.println(full1);
      System.out.println(full1.getCompList());
      System.out.println(full1.debugToString());
     for (int i = 0; i < 10; i++) {
       full1.add(new Component(0,i,2*i));
     }
     System.out.println(full1.getCompList());
     System.out.println(full1.debugToString());
     System.out.println(full1.chooseComp(10,10));
  }
}
