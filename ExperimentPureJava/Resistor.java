import java.util.*;
import java.io.*;
public class Resistor extends Component{
  public Resistor(double res, int x, int y, int name) {
    super(res,0,x,y,-100,name);
}

  public void calculate() {
    setVol(resistance()*current());
    setPow(current()*voltage());
  }

}
