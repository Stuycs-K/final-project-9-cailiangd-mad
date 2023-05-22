public class Driver {
  public static void main(String[] args) {
    Circuit cirt1 = new Circuit(12);
    System.out.println(cirt1.getfirstComp());
    System.out.println(cirt1);
    System.out.println(cirt1.getCompList());
    cirt1.setVEQ(20);
    System.out.println(cirt1.getfirstComp());
    System.out.println(cirt1);
    System.out.println(cirt1.getCompList());
    Circuit cirt2 = new Circuit();
    System.out.println(cirt2.getfirstComp());
    System.out.println(cirt2);
    System.out.println(cirt2.getCompList());
  }
}
