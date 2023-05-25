  private final int battery = -350;
  private final int resistor = 15;
Circuit mainC;
Component prev;
boolean isPrevMode, undo, debug;
int Cx, Cy;
boolean isEditMode = true;
void setup() {
  size(800,800);
  mainC = new Circuit();
  prev = mainC.getFirstComp();
}

void draw() {
  if (isPrevMode) {
    mainC.calculate();
  }
  /*
  Build the background graphics.
  */
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
    text("Run Mode", 48, 50);
  }
  /*
  Add resistors.
  I haven't figure out how I want the connecting components UI should work.
    */
  generateConnections();
    rectMode(CENTER);
  for (int i = 1; i < mainC.getCompNum(); i++) {
    rect(mainC.get(i).getX()-12.5,mainC.get(i).getY(),25,30,15,0,0,15);
    fill(205,85,124);
    rect(mainC.get(i).getX()+12.5,mainC.get(i).getY(),25,30,0,15,15,0);
    fill(0);
  }

    dataExtract();
        circlePrev();
    rectMode(CORNER);
}

void mouseClicked() {
  if (isPrevMode) {
  if (mouseButton == LEFT && prev != null) {
    boolean temp = true;
    for (int i = 1; i < mainC.getCompNum(); i++) {
    if (abs(mouseX-mainC.get(i).getX()) + abs(mouseY-mainC.get(i).getY()) < 65) {
      prev.addFollowing(mainC.get(i));
      mainC.get(i).addPrevious(prev);
      temp = false;
    }
  }
  if (temp && mouseY < 650 && mouseY > 70 && (mouseY > 450 || (mouseX > 50 && mouseX < 700))) {
    Component target = new Component(10,mouseX,mouseY);
  mainC.add(target);
  prev.addFollowing(target);
  target.addPrevious(prev);
  }
  }
  else if (mouseButton == RIGHT) {
      choosePrev(mouseX,mouseY);
  }
  }
  else {

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
  isPrevMode = !isPrevMode;
}

void generateConnections() {
  for (int i = 0; i < mainC.getCompNum(); i++) {
    for (int k = 0; k < mainC.get(i).getFollowing().size(); k++) {
      stroke(0);
      line(mainC.get(i).getX()+mainC.get(i).getType(),mainC.get(i).getY(),mainC.get(i).getFollowing().get(k).getX()-mainC.get(i).getFollowing().get(k).getType(),mainC.get(i).getFollowing().get(k).getY());
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
}
