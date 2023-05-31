private final int battery = -550;
private final int resistor = 15;
private final int startJunction = 1;
private final int endJunction = 0;

Circuit mainC;
Component prev;
boolean undo, debug;
int compType = 0;
boolean isEditMode = true;
void setup() {
    //fullScreen();
  size(1200,800);
  //surface.setResizable(true);
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
    findPartnerAll();
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
