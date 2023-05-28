private final int battery = -350;
private final int resistor = 15;
private final int startJunction = 0;
private final int endJunction = 0;
Circuit mainC;
Component prev;
boolean undo, debug;
int Cx, Cy;
boolean isEditMode = true;
void setup() {
  size(800,800);
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
  rect(0,0,800,80);
  rect(0,50,50,400);
  rect(750,50,50,400);
  fill(0);
  rect(18,400,10,40);
  rect(4,416,40,10);
  rect(740,400,10,40);
  //hit boxes for connections
  rect(755,416,40,10);
  rect(50,400,10,40);
  //display area
  fill(100);
  rect(0,650,800,150);
  textSize(30);
  if (isEditMode) {
    text("Edit Mode", 48, 40, 40);
  }
  else {
    text("Run Mode", 48, 40);
  }
}

void resistor(int x, int y) {
    fill(0);
    rect(x-12.5,y,25,30,15,0,0,15);
    fill(205,85,124);
    rect(x+12.5,y,25,30,0,15,15,0);
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
  //------------------------------------------//
  //ADD CODE HERE
  //------------------------------------------//
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
}
