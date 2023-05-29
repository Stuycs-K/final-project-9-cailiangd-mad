private final int battery = -350;
private final int resistor = 15;
private final int startJunction = 0;
private final int endJunction = 0;
Circuit mainC;
Component prev;
boolean undo, debug;
int Cx, Cy;
int compType = 0;
boolean isEditMode = true;
void setup() {
  //fullScreen();
  size(1200,800);
  surface.setResizable(true);
  mainC = new Circuit();
  prev = mainC.get(0);
}

void draw() {
  screen();
  generateConnections();
    rectMode(CENTER);
  for (int i = 1; i < mainC.size(); i++) {
    resistor(mainC.get(i).getX(),mainC.get(i).getY());
  }
    dataExtract();
        circlePrev();
    rectMode(CORNER);
    dataDisplay();
}

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
  if (isEditMode) {
    text("Edit Mode", width-400, 40);
  }
  else {
    text("Run Mode", width-400, 40);
  }
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
  resistor(330,25);
  startJunction(440,35);
  endJunction(510,35);
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

void resistor(int x, int y) {
    fill(0);
    rect(x-12.5,y,25,30,15,0,0,15);
    fill(205,85,124);
    rect(x+12.5,y,25,30,0,15,15,0);
}

void startJunction(int x, int y) {
  fill(0);
  rect(x,y,40,10);
  quad(x,y+10,x+6,y+2,x-24,y-23,x-30,y-15);
  quad(x,y,x+6,y+8,x-24,y+33,x-30,y+25);
}

void endJunction(int x, int y) {
  fill(0);
  rect(x,y,40,10);
  quad(x+40,y+10,x+34,y+2,x+54,y-23,x+60,y-15);
  quad(x+40,y,x+34,y+8,x+54,y+33,x+60,y+25);
}

void run(int x, int y) {
  color target = get(x,y);
  fill(0);
  arc(x,y,60,60,PI/12,5*PI/12);
  arc(x,y,60,60,7*PI/12,11*PI/12);
  arc(x,y,60,60,13*PI/12,17*PI/12);
  arc(x,y,60,60,19*PI/12,23*PI/12);
  fill(target);
  circle(x,y,40);
}

void dataDisplay() {
    if (!isEditMode) {
        mainC.calculate();
    textSize(40);
    if (prev == mainC.get(0)) {
    text("REQ: "+round((float)mainC.getREQ()*100.0)/100.0,10,700);
    text("PEQ: "+round((float)mainC.getPEQ()*100.0)/100.0,10,750);
    text("IEQ: "+round((float)mainC.getIEQ()*100.0)/100.0,350,700);
    text("VEQ: "+round((float)mainC.getVEQ()*100.0)/100.0,350,750);
    stroke(0);
    }
    else {
      text("resistance: "+round((float)prev.resistance()*100.0)/100.0,10,700);
      text("        power: "+round((float)prev.power()*100.0)/100.0,10,750);
      text("   current: "+round((float)prev.current()*100.0)/100.0,350,700);
      text("   voltage: "+round((float)prev.voltage()*100.0)/100.0,350,750);
    }
}
}

void mouseClicked() {
  if (isEditMode) {
  if (mouseButton == LEFT && prev != null) {
    boolean temp = true;
    for (int i = 1; i < mainC.size(); i++) {
    if (Math.sqrt(Math.pow(mouseX-mainC.get(i).getX(),2) + Math.pow(mouseY-mainC.get(i).getY(),2)) < 60) {
      //prev.addFollowing(mainC.get(i));
      //mainC.get(i).addPrevious(prev);
      //------------------------------------------//
      //ADD CODE HERE
      //------------------------------------------//
      temp = false;
    }
  }
  if (temp && mouseY < 650 && mouseY > 70 && (mouseY > 450 || (mouseX > 50 && mouseX < 700))) {
    Component target = new Resistor(10,mouseX,mouseY);
  mainC.add(target);
  //prev.addFollowing(target);
  //target.addPrevious(prev);
  //------------------------------------------//
  //ADD CODE HERE
  //------------------------------------------//
  }
  }
  else if (mouseButton == RIGHT) {
      choosePrev(mouseX,mouseY);
  }
  }
  else {
        if (prev != mainC.get(0) && Math.sqrt(Math.pow(mouseX-prev.getX(),2) + Math.pow(mouseY-prev.getY(),2)) < 60) {
        prev = mainC.get(0);
        }
       else {
         for (int i = 1; i < mainC.size(); i++) {
             if (Math.sqrt(Math.pow(mouseX-mainC.get(i).getX(),2) + Math.pow(mouseY-mainC.get(i).getY(),2)) < 60) {
               prev = mainC.get(i);
         }
        }
  }
}
}

void dataExtract() {
  if (debug) {
  textSize(30);
  text(mainC.chooseComp(mouseX,mouseY).toString(),50,25);
  if (prev != null) {
  text(prev.toString(), 50, 55);
  }
  }
}


void choosePrev(int x, int y) {
  prev = mainC.chooseComp(x,y);
}
/**
  the generateConnections() method helps connect a newly connected component to the rest of the circuit.
  It does so by first detecting where it was clicked; then, it inserts it into the arraylist of Components and recalculates the instance variables.
*/

void generateConnections() {
  for (int i = 0; i < mainC.size(); i++) {
    for (int k = 0; k < mainC.get(i).followList().size(); k++) {
      stroke(0);
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(i).followList().get(k).getX()-mainC.get(i).followList().get(k).type(),mainC.get(i).followList().get(k).getY());
    }
    if (!isEditMode && mainC.get(i).followList().size() == 0) {
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(0).getX()-mainC.get(0).type(),mainC.get(0).getY());
    }
  }
}

void circlePrev() {
    noFill();
  stroke(255,0,0,100);
  circle(prev.getX(),prev.getY(),50);
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
  if (key == 'e') {
    isEditMode = !isEditMode;
  }
  if (key == 'c') {
      compType = (compType+1)%3;   
  }
}
