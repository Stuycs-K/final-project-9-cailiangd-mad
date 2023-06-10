import java.time.LocalDateTime; // Import the LocalDateTime class
import java.time.format.DateTimeFormatter; // Import the DateTimeFormatter class
PrintWriter output;
private int battery = -550;
private final int resistor = 15;
private final int startJunction = 1;
private final int endJunction = 0;

Circuit mainC;
Component prev;
boolean undo, debug;
int compType, alternative, decimal, signal;
double level = 120;
double level2 = 100;
boolean tab;
double typing, experimental;
boolean isEditMode = true;
PFont font;
void setup() {
  size(1300,800);
  //fullScreen();
  font = loadFont("CenturyGothic-72.vlw");
  textFont(font);
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
  if (key == 'd') {
    debug = !debug;
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
    LocalDateTime myDateObj = LocalDateTime.now();
    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm-ss");
    String formattedDate = myDateObj.format(myFormatObj);
      output = createWriter(formattedDate+".txt");
      output.print(dataReturn());
        output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  signal = 100;
    }
    if (key == 'g') {
      selectInput("Select a file to process:", "fileRead");
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
