import processing.sound.*;
import java.util.*;
import java.io.*;

import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

/** CircuitSim2 */
public class CircuitSim2 {
PrintWriter output;
private int battery = -550;
private final int resistor = 15;
private final int startJunction = 1;
private final int endJunction = 0;

Circuit mainC;
Component prev;
int compType, alternative, decimal, signal, SoundTimer; //demical = number of digits left of decimal place, signal = save result signal
double level = 120;
double level2 = 100;
boolean tab, mute;
double typing, experimental;
boolean isEditMode = true;
PFont font;
SoundFile res, start, end, open;
Pulse pulse;
void setup() {
  cursor(CROSS);
  fullScreen();
  font = loadFont("CenturyGothic-72.vlw");
  textFont(font);
  battery = -width/2+50;
  mainC = new Circuit();
  prev = mainC.get(0);
  res = new SoundFile(this,"Xylophone.hardrubber.ff.F4.stereo.aif");
  start = new SoundFile(this,"Xylophone.hardrubber.ff.D6.stereo.aif");
  end = new SoundFile(this,"Xylophone.hardrubber.ff.G7.stereo.aif");
  open = new SoundFile(this,"Marimba.yarn.ff.D3.stereo.aif");
  pulse = new Pulse(this);
}

void draw() {
  screen();
  generateConnections();
  generateNodes();
  circlePrev();
  rectMode(CORNER);
  dataDisplay();
  slider(width-350,15,level,"Voltage: ");
  level = 10.0 * mainC.getVEQ();
  if (isEditMode && prev.type() == resistor) {
   level2 = 10.0*prev.resistance();
  slider(width/2+300,height-120,level2,"Resistance: ");
  }
  copiedSignal();
}

void keyPressed() {
    if (key == ' ') {
    mainC.undo();
  }
    if (key == 'c') {
      compType = (compType+1)%3;
  }
  if (key == 'e') {
      EditModeChange();
  }
  if (key == 'r') {
    isEditMode = true;
    setup();
  }
    if(key == TAB) {
      tab = true;
    }
    if (key == 'a') {
      alternative = (alternative + 1) % 3;
    }
    if (alternative > 0 && (key+"").matches("[0-9]")) {
      noCursor();
      if (decimal == 0) {
        typing = typing*10.0 + Double.parseDouble(key+"");
      }
      else {
        typing = typing + Double.parseDouble(key+"")/Math.pow(10,decimal);
        decimal++;
      }
    }
    if (alternative > 0 && alternative < 3 && key == '.') {
      decimal++;
    }
    if (alternative > 0 && key == '\n') {
      cursor(CROSS);
      if (alternative == 1) {
        mainC.setVEQ(typing);
        typing = 0.0;
        decimal = 0;
      }
        else if (alternative == 2) {
          if (prev.type() == resistor) {
        prev.setRes(typing);
        typing = 0.0;
        decimal = 0;
    }
    else alternative = 0;
        }
}
    if (key == 's' && signal == 0) {
      output = createWriter(year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()+".txt");
      output.print(dataReturn());
        output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  signal = 120;
    }
    if (key == 'g') {
      selectInput("Select a file to process:", "fileRead");
    }
    if (key == 'm') {
      mute = !mute;
    }
}

void mouseClicked() {
  if (mouseX > 70 && mouseX < 170 && mouseY > 0 && mouseY < 80) {
   EditModeChange();
  }
  if (isEditMode) {
   Editing();
  }
  else {
  Running();
}
}

void mouseDragged() {
  if (mouseY > 15 && mouseY < 15+50 && mouseX > width-450 && mouseX < width-350+300) {
    level = mouseX - (width-450);
    if (level > 285) {
      level = 285;
    }
    mainC.setVEQ(level / 10);
  }
  if (isEditMode && prev.type() == resistor && mouseY > height - 120 && mouseY < height-120+50 && mouseX > width/2+300 && mouseX < width/2+300+300) {
    level2 = mouseX - (width/2+300);
    if (level2 > 285) {
      level2 = 285;
    }
    prev.setRes(level2 / 10);
  }
  }

  void keyReleased() {
    if(key == TAB) {
      tab = false;
    }
  }
public class Battery extends Component{
  public Battery(double newVol) {
  super(0,newVol,width/2,height/2+16,battery);
  }

  public boolean connectFol(Component newComp) {
    followList().add(newComp);
    return true;
  }

   //actually just removes items from followList.
  public Component setFol(Component newFol, int mode) {
    Component temp = followList().get(followList().size()-1);
    followList().set(followList().size()-1,newFol);
    return temp;
  }

  public void remove(int pos) {
    super.followList().remove(pos);
  }

  public String debugToString() {
    String temp = "";
    for (int i = 0; i < followList().size(); i++) {
    temp += followList().get(i).toString() + "\n";
  }
  if (temp.length() > 0) {
  return temp.substring(0,temp.length()-1);
  }
  return temp;
}

 public double REQsub() {
   setREQsub(0);
   for (int i = 0; i < followList().size(); i++) {
     if (followList().get(i) != null) {
     setREQsub(getREQsub()+(1.0/(followList().get(i).REQsub())));
     }
   }
   setREQsub(1.0/getREQsub());
   return getREQsub();
 }

 public void calculate() {
     setCur(voltage()/getREQsub());
      for (int i = 0; i < followList().size(); i++) {
        if (followList().get(i) != null) {
     followList().get(i).calculate();
        }
   }
 }

}public class Circuit{
  private double REQ;
  private double IEQ;
  private double VEQ;
  private double PEQ;
  ArrayList<Component> compList;

  public Circuit() {
    this(12);
  }

  public Circuit(double voltage) {
    Component battery1 = new Battery(voltage);
    VEQ = voltage;
    compList = new ArrayList<Component>();
    add(battery1);
  }

public void undo() {
  if (isEditMode) {
  /* Remove the previously added last resistor from the list */
  Component target = compList.get(compList.size()-1);
  if (target.type() == endJunction) {
    endJunction targetE = (endJunction) target;
    if (targetE.prev1().followList().size() == 2 && targetE.prev1().followList().get(1) == targetE) {
      targetE.prev1().setFol(null,1);
    }
    else {
      targetE.prev1().setFol(null,0);
    }
        if (targetE.prev2().followList().size() == 2 && targetE.prev2().followList().get(1) == targetE) {
      targetE.prev2().setFol(null,1);
    }
    else {
      targetE.prev2().setFol(null,0);
    }
    prev = targetE.prev1();
    compList.remove(compList.size()-1);
  }
  else if (target.type() != battery) {
    if (target.prev().type() == battery) {
      Battery targetPrev = (Battery) target.prev();
      for (int i = 0; i < targetPrev.followList().size(); i++) {
        if (targetPrev.followList().get(i) == target) {
          targetPrev.remove(i);
        }
      }
      prev = targetPrev;
    }
    else {
        if (target.prev().followList().size() == 2 && target.prev().followList().get(1) == target) {
      target.prev().setFol(null,1);
    }
    else {
      target.prev().setFol(null,0);
    }
    prev = target.prev();
  }
     compList.remove(compList.size()-1);
  }
  }
}

  public double getREQ() {
    return REQ;
  }

  public double getIEQ() {
    return IEQ;
  }

  public double getVEQ() {
    return VEQ;
  }

  public double getPEQ() {
    return PEQ;
  }

  public String toString() {
    return "REQ: "+REQ+" IEQ: "+IEQ+" VEQ: "+VEQ+" PEQ: "+PEQ;
  }

  
  public void setVEQ(double newVEQ) {
    VEQ = newVEQ;
    get(0).setVol(VEQ);
  }

  public void add(Component newComp) {
    compList.add(newComp);
  }

  public void remove(int pos) {
    compList.remove(pos);
  }

  public int size() {
    return compList.size();
  }

  public String debugToString() {
    String res = "";
    for (int i = 0; i < compList.size(); i++) {
      res+=compList.get(i)+"\n";
    }
    return res.substring(0,res.length()-1);
  }

 private void calculateREQ() {
    REQ = get(0).REQsub();
 }

 private void calculateIVPeq() {
   IEQ = VEQ/REQ;
   PEQ = VEQ * IEQ;
 }

private void calculateIVP() {
  for (int i = 0; i < size(); i++) {
    get(i).calculate();
  }
}

private void calculate() {
  calculateREQ();
  calculateIVPeq();
  calculateIVP();
}

public Component chooseComp(int x,int y) {
  return chooseComp(x,y,1);
}

public Component chooseComp(int x,int y, int start) {
  for (int i = start; i < compList.size(); i++) {
    if (Math.sqrt(Math.pow(x-compList.get(i).getX(),2)+Math.pow(y-compList.get(i).getY(),2)) < 60)
    return compList.get(i);
  }
  return null;
}

public Component get(int pos) {
  return compList.get(pos);
}

public void setAllFollow() {
  for (int i = 0; i < compList.size(); i++) {
  compList.get(i).prepFollowList();
  }
}
}public class Component{
  private int type;
  private double REQsub;
  private double resistance;
  private double current;
  private double voltage;
  private double power;
  private int x;
  private int y;
  private boolean target; //allows startJunction / endJunction interaction
  private ArrayList<Component> followList;
  public Component(double Resistance, double Voltage, int x_, int y_, int Type) {
    voltage = Voltage;
    resistance = Resistance;
    type = Type;
    x=x_;
    y=y_;
    followList = new ArrayList<Component>();
  }
  //general get methods
  public double resistance() {
    return resistance;
  }

  public Component prev() {
    return null;
  }

  public double current() {
    return current;
  }

  public double voltage() {
    return voltage;
  }

  public double power() {
    return power;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

   public int type() {
     return type;
   }

  public ArrayList<Component> followList() {
    return followList;
  }

  public void addFollowList(Component newComp) {
    followList.add(newComp);
  }
  
  public void setFollowList(int pos, Component newComp) {
    followList.set(pos, newComp);
  }
  
  public void clearFollowList() {
    followList = new ArrayList<Component>();
  }
  
  public ArrayList<Component> prepFollowList() {
    return null;
  }

  public String toString() {
    return "R_"+resistance+" I_"+current+" V_"+voltage+" P_"+power+" X_"+x+" Y_"+y;
  }

  //general set methods
  public void setRes(double newRes) {
    resistance = newRes;
  }

  public void setVol(double newVolt) {
    voltage = newVolt;
  }

  public void setCur(double newCur) {
    current = newCur;
  }

  public void setPow(double newPow) {
    power = newPow;
  }

  //REQ related methods
  public double getREQsub() {
    return REQsub;
  }

  public double REQsub() {
    return REQsub;
  }

  public void setREQsub(double in) {
    REQsub = in;
  }

  //calculate for RIVP
  public void calculate() {
  }
  /////Methods need to find loop endings.
  public void trace() {
  }

  public void tracker(startJunction start) {
  }

  public void clearTrack() {
  }

      public void findPartner() {
    }

  public void setTarget(boolean val) {
    target = val;
  }

  public boolean target() {
    return target;
  }
  //Connection methods
  public boolean connectPre(Component newComp) {
    return true;
  }
  public boolean connectFol(Component newComp) {
   return true;
  }

    public Component setFol(Component newFol, int mode) {
    return null;
  }

    public Component setPre(Component newPre, int mode) {
    return null;
  }
}
public class Resistor extends Component{
  Component previousR;
Component followR;
  public Resistor(double Res, int x, int y) {
    super(Res,0,x,y,resistor);
    previousR = null;
    followR = null;
}

  // general get methods
  public Component fol() {
    return followR;
  }

  public Component prev() {
    return previousR;
  }

  public ArrayList<Component> prepFollowList() {
    super.clearFollowList();
    super.addFollowList(followR);
    return super.followList();
  }

  // general set methods
  public Component setFol(Component newFol, int mode) {
    Component temp = followR;
    followR = newFol;
    return temp;
  }

    public Component setPre(Component newPre, int mode) {
    Component temp = previousR;
    previousR = newPre;
    return temp;
  }
  //general connect methods
  public boolean connectPre(Component newComp) {
    if (prev() == null && fol() != newComp) {
      setPre(newComp, 0);
      return true;
    }
    else  return false;
  }
  public boolean connectFol(Component newComp) {
    if (fol() == null && prev() != newComp)  {
      setFol(newComp, 0);
      return true;
    }
    else return false;
  }
    public double REQsub() {
      if (followR == null || followR.type() == endJunction) {
        setREQsub(resistance());
        return getREQsub();
      }
      else {
        setREQsub(followR.REQsub() + resistance());
      }
    return getREQsub();
  }

    public void calculate() {
    if (previousR != null && (previousR.type() == resistor || previousR.type() == endJunction)) {
      setCur(previousR.current());
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null  && previousR.type() == battery) {
       setCur(previousR.voltage()/getREQsub());
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null && previousR.type() == startJunction) {
            if (previousR.followList().size() > 1) {
      double val = (previousR.followList().get((previousR.followList().indexOf(this)+1)%2).getREQsub());
      setCur(previousR.current()*(val/(getREQsub()+val)));
      }
      else {
        setCur(previousR.current());
      }
      setVol(current()*resistance());
      setPow(current()*voltage());
    }
    else if (previousR != null) {
      setVol(previousR.voltage());
      setCur(voltage()/resistance());
      setPow(current()*voltage());
    }
    if (followR != null && followR.type() != endJunction) {
      followR.calculate();
    }
  }

    public void trace() {
      setTarget(true);
      if (followR != null) {
      followR.trace();
      }
  }
  public void tracker(startJunction start) {
    if (followR != null) {
    followR.tracker(start);
    }
  }

  public void clearTrack() {
    setTarget(false);
    if (followR != null) {
    followR.clearTrack();
    }
  }

}//draw
void screen() {
  background(255);
  noStroke();
  fill(35,80,200);
  rect(0,0,width,80);
  rect(0,50,50,height/2);
  rect(width-50,50,50,height/2);
  fill(0);
  rect(18,height/2,10,40);
  rect(4,height/2+16,40,10);
  rect(width-60,height/2,10,40);
  //hit boxes for connections
  rect(width-45,height/2+16,40,10);
  rect(50,height/2,10,40);
  //display area
  fill(100);
  rect(0,height-150,width,150);
  textSize(30);
  noStroke();
    if (isEditMode) {
      fill(185,32,96);
    rect(70,0,100,80);
  }
  if (compType == 0) {
      fill(185,32,96);
     rect(295,0,100,80);
  }
  else if (compType == 1) {
    fill(185,32,96);
    rect(395,0,100,80);
  }
  else if (compType == 2) {
    fill(185,32,96);
    rect(495,0,100,80);
  }
  run(120,40);
  resistorIcon(330,25,false);
  startJunctionIcon(540,35);
  endJunctionIcon(410,35);
    stroke(0);
  strokeWeight(6);
  strokeCap(SQUARE);
  line(70,0,70,80);
  line(170,0,170,80);
  line(295,0,295,80);
  line(395,0,395,80);
  line(495,0,495,80);
  line(595,0,595,80);
}

void generateConnections() {
 mainC.setAllFollow();
  for (int i = 0; i < mainC.size(); i++) {
    for (int k = 0; k < mainC.get(i).followList().size(); k++) {
      stroke(0);
      if (mainC.get(i).followList().get(k) != null) {
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(i).followList().get(k).getX()-mainC.get(i).followList().get(k).type(),mainC.get(i).followList().get(k).getY());
      }
  }
    if (!isEditMode && mainC.get(i).followList().size() != 0 && mainC.get(i).followList().get(0) == null) {
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(0).getX()-mainC.get(0).type(),mainC.get(0).getY());
    }
  }
}

void generateNodes() {
      rectMode(CENTER);
    noStroke();
    for (int i = 1; i < mainC.size(); i++) {
    if (mainC.get(i).type() == resistor) {
    resistorIcon(mainC.get(i).getX(),mainC.get(i).getY(),true);
    }
    else if (mainC.get(i).type() == startJunction) {
    startJunctionDisplay(mainC.get(i).getX(),mainC.get(i).getY());
    }
    else if (mainC.get(i).type() == endJunction) {
    endJunctionDisplay(mainC.get(i).getX(),mainC.get(i).getY());
    }
  }
}

void circlePrev() {
  if (prev == null) {
    prev = mainC.get(0);
  }
    noFill();
  stroke(255,0,0,100);
  circle(prev.getX(),prev.getY(),50);
}

void dataDisplay() {
    if (!isEditMode) {
      //sound affects
      if (!mute) {
        pulse.set((float)mainC.getVEQ()*10, 0.1, 0, -0.5);
       if (SoundTimer % (int) mainC.getREQ()*10 == 0) {
         pulse.play();
       }
       if (SoundTimer % (int) mainC.getREQ()*10 == (int) mainC.getREQ()*5) {
         pulse.stop();
       }
       SoundTimer++;
      }
      else {
        pulse.stop();
      }
    textSize(40);
    if (prev == mainC.get(0)) {
    text("REQ: "+round((float)mainC.getREQ()*1000.0)/1000.0,10,height-100);
    text("PEQ: "+round((float)mainC.getPEQ()*1000.0)/1000.0,10,height-50);
    text("IEQ: "+round((float)mainC.getIEQ()*1000.0)/1000.0,350,height-100);
    text("VEQ: "+round((float)mainC.getVEQ()*1000.0)/1000.0,350,height-50);
    stroke(0);
    }
    else if (prev.type() == resistor) {
      text("resistance: "+round((float)prev.resistance()*1000.0)/1000.0,10,height-100);
      text("        power: "+round((float)prev.power()*1000.0)/1000.0,10,height-50);
      text("   current: "+round((float)prev.current()*1000.0)/1000.0,350,height-100);
      text("   voltage: "+round((float)prev.voltage()*1000.0)/1000.0,350,height-50);
      //text("   REQ: "+prev.getREQsub(),700,height-100);
    }
}
else {
  pulse.stop();
     if (alternative == 2) {
  fill(0);
  textSize(40);
  text("New Resistance: "+round((float)typing*1000.0)/1000.0,40,height-80);
  }
   else if (alternative == 1) {
  fill(0);
  textSize(40);
  text("New Voltage: "+round((float)typing*1000.0)/1000.0,40,height-80);
  }
  else {
    fill(0);
    textSize(25);
    text("- ' '\n  - Undo\n- 'e'\n  - editMode ON/OFF",10,height-120);
    text("-'c'\n  - Switch Components\n- 'r'\n  - Restart",260, height-120);
  }
}
}

void slider(int x, int y, double level, String attach) {
  fill(0);
  stroke(0);
  textSize(50);
  text(attach+round((float)level*1000.0)/10000.0,x-textWidth(attach+round((float)level*1000.0)/10000.0)-20,y+40);
  strokeWeight(4);
  fill(0,255,0);
  rect(x,y,300,50,10);
  fill(0,0,255);
  rect(x,y,(float)level,50,10,0,0,10);
}

void copiedSignal() {
  noStroke();
  fill(255,0,0,signal);
  circle(232.5,40,50);
  if (signal > 0) {
    signal--;
  }
}

//Inputs
//MouseClicked && KeyPressed
void EditModeChange() {
    isEditMode = !isEditMode;
    if (!isEditMode) {
           for (int i = 0; i < mainC.compList.size(); i++) {
    if (mainC.compList.get(i).type() == startJunction) {
      mainC.compList.get(i).findPartner();
    }
  }
        mainC.calculate();
        open.play();
    }
}

//MouseClicked
void Editing() {
   if (!tab && mouseButton == LEFT && prev != null) {
     left();
  }
  else if (mouseButton == RIGHT || (tab && mouseButton == LEFT)) {
      choosePrev(mouseX,mouseY);
  }
  }

void left() {
      Component target = mainC.chooseComp(mouseX,mouseY);
      if (target != null) {
        if (target.connectPre(prev)) {
      prev.connectFol(target);
      }
      else {
        prev = mainC.get(0);
      }
      }
      else if (mouseY < height-150-30 && mouseY > 70+30 && (mouseY > height/2+50+30 || (mouseX > 50+30 && mouseX < width-100-30))) {
    Component target2 = new Component(0,0,0,0,startJunction);
    if (compType == 0) {
      target2 = new Resistor(10,mouseX,mouseY);
       if (!mute) res.play();
    }
    else if (compType == 1) {
      target2 = new startJunction(mouseX,mouseY);
      if (!mute) start.play();
    }
    else if (compType == 2) {
      target2 = new endJunction(mouseX,mouseY,mainC.get(0));
      if (!mute) end.play();
    }
  mainC.add(target2);
  if (target2.connectPre(prev)) {
   if (!prev.connectFol(target2)) {
  mainC.remove(mainC.size()-1);
  prev = mainC.get(0);
   }
  }
  else {
    mainC.remove(mainC.size()-1);
  prev = mainC.get(0);
  }
  }
  else if(mouseX > 295 && mouseX < 395 && mouseY > 0 && mouseY < 80) {
    compType = 0;
  }
  else if(mouseX > 395 && mouseX < 495 && mouseY > 0 && mouseY < 80) {
    compType = 1;
  }
  else if(mouseX > 495 && mouseX < 595 && mouseY > 0 && mouseY < 80) {
    compType = 2;
  }
}

void choosePrev(int x, int y) {
  prev = mainC.chooseComp(x,y);
}


void Running() {
          if (prev != mainC.get(0) && Math.sqrt(Math.pow(mouseX-prev.getX(),2) + Math.pow(mouseY-prev.getY(),2)) < 60) {
        prev = mainC.get(0);
        }
       else {
         prev = mainC.chooseComp(mouseX,mouseY);
  }
}

//mousePressed
String dataReturn() {
  String temp = "";
  for (int i = 0; i < mainC.size(); i++) {
    temp+=mainC.get(i).type();
    temp+=" ";
    temp+=mainC.get(i).toString();
    temp+=" ";
    for (int k = 0; k < mainC.get(i).followList().size(); k++) {
      if (mainC.get(i).followList().get(k) != null) {
      temp+=mainC.get(i).followList().get(k).getX()+"_"+mainC.get(i).followList().get(k).getY()+"_";
      }
    }
    if (temp.charAt(temp.length()-1) == '_') {
      temp = temp.substring(0,temp.length()-1);
  }
  temp+="\n";
}
temp = temp.substring(0,temp.length()-1);
return temp;
}

void fileRead(File Selection) {
  ArrayList temp = new ArrayList<ArrayList<Double>> ();
    try {
      Scanner input = new Scanner(Selection);
   while (input.hasNextLine()) {
     ArrayList<Double> inner = new ArrayList<Double> ();
     String line = input.nextLine();
     for (int i = 0; i < 7; i++) {
       if (i == 0) {
         inner.add(Double.parseDouble(line.substring(0,line.indexOf(" "))));
       }
     else inner.add(Double.parseDouble(line.substring(2,line.indexOf(" "))));
      line = line.substring(line.indexOf(" ")+1);
      }
      while(line.length() > 0) {
        if (line.indexOf("_") == -1) {
          inner.add(Double.parseDouble(line));
          line = "";
        }
        else {
          inner.add(Double.parseDouble(line.substring(0,line.indexOf("_"))));
        line = line.substring(line.indexOf("_")+1);
        }
      }
      temp.add(inner);
   }
      input.close();
      generate(temp);
}
catch (FileNotFoundException ex) {
    }
}

void generate(ArrayList<ArrayList<Double>> data) {
  mainC = new Circuit(data.get(0).get(3));
  for (int i = 1; i < data.size(); i++) {
    if (data.get(i).get(0) == resistor) {
     Resistor temp = new Resistor(data.get(i).get(1),data.get(i).get(5).intValue(),data.get(i).get(6).intValue());
     mainC.add(temp);
    }
    else if (data.get(i).get(0) == startJunction) {
      startJunction temp = new startJunction(data.get(i).get(5).intValue(),data.get(i).get(6).intValue());
     mainC.add(temp);
    }
    else if (data.get(i).get(0) == endJunction) {
      endJunction temp = new endJunction(data.get(i).get(5).intValue(),data.get(i).get(6).intValue(),mainC.get(0));
     mainC.add(temp);
    }
  }
  for (int i = 0; i < data.size(); i++) {
    for (int k = 7; k < data.get(i).size()-1; k+=2) {
      Component temp = mainC.chooseComp(data.get(i).get(k).intValue(),data.get(i).get(k+1).intValue());
      mainC.get(i).connectFol(temp);
      temp.connectPre(mainC.get(i));
    }
  }
}

//Display Objects
void run(int x, int y) {
  int target = get(x,y);
  fill(0);
  arc(x,y,60,60,PI/12,5*PI/12);
  arc(x,y,60,60,7*PI/12,11*PI/12);
  arc(x,y,60,60,13*PI/12,17*PI/12);
  arc(x,y,60,60,19*PI/12,23*PI/12);
  fill(target);
  circle(x,y,40);
}

  public void resistorIcon(int x, int y, boolean tag) {
    if (tag) {
    Component target = mainC.chooseComp(x,y);
    textSize(20);
    fill(0);
    text(round((float)target.resistance()*1000.0)/1000.0+"",x-15,y-20);
    }
    fill(0);
    rect(x-12.5,y,25,30,15,0,0,15);
    fill(205,85,124);
    rect(x+12.5,y,25,30,0,15,15,0);
  }

    public void endJunctionIcon(int x, int y) {
      fill(0);
  rect(x,y,40,10);
  quad(x+40,y+10,x+34,y+2,x+54,y-23,x+60,y-15);
  quad(x+40,y,x+34,y+8,x+54,y+33,x+60,y+25);
  }

    public void endJunctionDisplay(int x, int y) {
    fill(0);
    square(x,y,20);
  }

     public void startJunctionIcon(int x, int y) {
       fill(0);
  rect(x,y,40,10);
  quad(x,y+10,x+6,y+2,x-24,y-23,x-30,y-15);
  quad(x,y,x+6,y+8,x-24,y+33,x-30,y+25);
   }

    public void startJunctionDisplay(int x, int y) {
          fill(0);
    circle(x,y,20);
   }public class endJunction extends Component{
  Component prev1, prev2;
Component follow;
Component start;
  public endJunction(int x, int y, Component newStart) {
    super(0,0,x,y,endJunction);
    follow = null;
    prev1 = null;
    prev2 = null;
    start = newStart;
  }

  // general get methods
   public Component fol() {
    return follow;
  }

  public Component prev1() {
    return prev1;
  }

  public Component prev2() {
    return prev2;
  }

  public Component start() {
    return start;
  }

    public ArrayList<Component> prepFollowList() {
    clearFollowList();
    super.addFollowList  (follow);
    return super.followList();
  }

  //general set methods
  public Component setFol(Component newFol, int mode) {
    Component temp = follow;
    follow = newFol;
    return temp;
  }

    public Component setPre(Component newPre, int mode) {
    Component temp;
    if (mode == 0) {
    temp = prev1;
    prev1 = newPre;
    }
    else {
      temp = prev2;
      prev2 = newPre;
    }
    return temp;
  }

  //connect methodss
  public boolean connectPre(Component newComp) {
    if (prev1() == null) {
      setPre(newComp,0);
      return true;
    }
    else if (prev2() == null && prev1() != newComp && fol() != newComp) {
      setPre(newComp,1);
      return true;
    }
    else return false;
  }

  public boolean connectFol(Component newComp) {
    if (fol() == null && prev1() != newComp && prev2() != newComp) {
      setFol(newComp, 0);
      return true;
    }
    else return false;
  }

    public void setStart(Component start_) {
      start = (startJunction) start_;
    }

  //change to list, use loop
  public void calculate() {
    setCur(start.current());
    if (follow != null) {
    follow.calculate();
    setVol(follow.voltage());
    }
  }

      public double REQsub() {
      if (follow == null || follow.type() == endJunction) {
        setREQsub(0);
      }
      else if (follow != null) {
        setREQsub(follow.REQsub());
      }
      else {
        setREQsub(0);
      }
    return getREQsub();
  }

      public void trace() {
      setTarget(true);
      if (follow != null) {
      follow.trace();
      }
  }

  public void tracker(startJunction starter) {
    if (target()) {
      start = starter;
      starter.setEnd(this);
    }
    else if (follow != null) {
    follow.tracker(starter);
    }
  }

  public void clearTrack() {
    setTarget(false);
    if (follow != null) {
    follow.clearTrack();
    }
  }

}public class startJunction extends Component{
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

   public ArrayList<Component> prepFollowList() {
    clearFollowList();
    super.addFollowList(fol1);
    super.addFollowList(fol2);
    return super.followList();
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
}

