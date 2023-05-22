public class Component{
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private ArrayList<Component> previous;
  private ArrayList<Component> following;
  private int x;
  private int y;

  public static double getResistance() {
    return resistance;
  }
  public static double getCurrent() {
    return current;
  }
  public static double getVoltage() {
    return voltage;
  }
  public static double getPower() {
    return power;
  }
  public static int getX() {
    return x;
  }
  public static int getY() {
    return y;
  }
}
