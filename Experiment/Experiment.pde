private int battery = -550;
private final int resistor = 15;

Circuit mainC;
Component prev;
boolean undo, debug;
double level = 120;
double level2 = 100;
boolean tab;
boolean isEditMode = true;
void setup() {
  size(1250,800);
  //fullScreen();
  battery = -width/2+50;
  mainC = new Circuit();
  prev = mainC.get(0);
}

void draw() {
  screen();
  generateConnections();
  generateNodes();
  dataExtract();
  circlePrev();
  rectMode(CORNER);
  dataDisplay();
  level = 10.0 * mainC.get(0).voltage();
  slider(width-350,15,level,"Voltage: ");
  if (isEditMode && prev.type() == resistor) {
   level2 = 10.0*prev.resistance();
  slider(width/2-100,height-120,level2,"Resistance: "); //<>//
  }
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
  if (key == 'e') {
    isEditMode = !isEditMode;
  }
  if (key == 'r') {
    isEditMode = true;
    setup();
  }
  //if (key == 'u') {
  //  mainC.undo();
  //  prev = mainC.get(0);
  //}
    if(key == TAB) {
      tab = true;
    }
}

void mouseClicked() {
   EditModeChange();
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
    //mainC.get(0).setVol(level / 10);
  }
  if (isEditMode && prev.type() == resistor && mouseY > height - 120 && mouseY < height-120+50 && mouseX > width/2-100 && mouseX < width/2-100+300) {
    level2 = mouseX - (width/2-100);
    if (level2 > 285) {
      level2 = 285;
    }
    prev.setRes(level2 / 10); 
  }
  }
  void keyReleased() {
    if(key == TAB) {
      tab = true;
    }
  }
