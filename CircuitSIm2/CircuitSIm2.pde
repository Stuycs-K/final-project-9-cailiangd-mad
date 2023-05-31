private int battery = -550;
private final int resistor = 15;
private final int startJunction = 1;
private final int endJunction = 0;

Circuit mainC;
Component prev;
boolean undo, debug;
int compType = 0;
int level = 120;
int level2 = 100;
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
  slider(width-350,15,level,"Voltage: ");
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
  if (key == 'r') {
    setup();
  }
    if(key == TAB) {
      tab = true;
    }
    println(key);
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

void mouseDragged() {
  if (mouseY > 15 && mouseY < 65 && mouseX > 800 && mouseX < 1100) {
    level = mouseX - 800;
    mainC.setVEQ(level / 10);
  }
}

  void keyReleased() {
    if(key == TAB) {
      tab = true;
    }
  }
