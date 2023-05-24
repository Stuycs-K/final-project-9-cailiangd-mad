Circuit mainC;
Component start;
int Cx, Cy;
void setup() {
  size(800,800);
  mainC = new Circuit();
}

void draw() {
  /*
  The top blue bar and side bars.
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
  
  /*
  Add resistors.
  I haven't figure out how I want the connecting components UI should work.
  */
  for (int i = 1; i < mainC.getCompNum(); i++) {
    rect(mainC.getComp(i).getX(),mainC.getComp(i).getY(),25,30,15,0,0,15);
    fill(205,85,124);
    rect(mainC.getComp(i).getX()+25,mainC.getComp(i).getY(),25,30,0,15,15,0);
    fill(0);
  }
  
    //Ender();
  //Connector();
    dataExtract();
}

void mouseClicked() {
  boolean temp = true;
    for (int i = 1; i < mainC.getCompNum(); i++) {
    if (abs(mouseX-mainC.getComp(i).getX()) + abs(mouseY-mainC.getComp(i).getY()) < 70) {
      temp = false;
    }
  }
  if(mouseY < 70 || (mouseY < 450 && (mouseX < 50 || mouseX > 700))) {
    temp = false;
  }
  if (temp) {
  mainC.add(new Component(10,mouseX, mouseY));
  }
}

//void mouseDragged() {
//    Cx = mouseX;
//    Cy = mouseY;
//}

//void mousePressed() {
//  start = mainC.chooseComp(mouseX,mouseY);
//}

//void Ender() {
//  Component end = mainC.chooseComp(Cx,Cy);
//  if (start != null && end != null) {
//  start.addFollowing(end);
//  end.addPrevious(start);
//      println(start);
//  println(end);
//  println(start.getFollowing());
//}
//}

//void Connector() {
//  for (int i = 1; i < mainC.getCompNum(); i++) {
//    for (int k = 0; k < mainC.getComp(i).getFollowing().size();k++) {
//    line(mainC.getComp(i).getX(),mainC.getComp(i).getY(),mainC.getComp(i).getFollowing().get(k).getX(),mainC.getComp(i).getFollowing().get(k).getY());
//    }
//}
//}

void dataExtract() {
  textSize(30);
  text(mainC.chooseComp(mouseX,mouseY).toString(),50,50);  
}
