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
  resistorIcon(330,25);
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

void dataDisplay() {
    if (!isEditMode) {
        mainC.calculate();
    textSize(40);
    if (prev == mainC.get(0)) {
    text("REQ: "+round((float)mainC.getREQ()*1000.0)/1000.0,10,height-100);
    text("PEQ: "+round((float)mainC.getPEQ()*1000.0)/1000.0,10,height-50);
    text("IEQ: "+round((float)mainC.getIEQ()*1000.0)/1000.0,350,height-100);
    text("VEQ: "+round((float)mainC.getVEQ()*1000.0)/1000.0,350,height-50);
    stroke(0);
    }
    else /*if (prev.type() == resistor)*/ {
      text("resistance: "+round((float)prev.resistance()*1000.0)/1000.0,10,height-100);
      text("        power: "+round((float)prev.power()*1000.0)/1000.0,10,height-50);
      text("   current: "+round((float)prev.current()*1000.0)/1000.0,350,height-100);
      text("   voltage: "+round((float)prev.voltage()*1000.0)/1000.0,350,height-50);
      text("   REQ: "+prev.getREQsub(),700,height-100);
    }
}
}

void generateConnections() {
  for (int i = 0; i < mainC.size(); i++) {
    for (int k = 0; k < mainC.get(i).followList().size(); k++) {
      stroke(0);
      if (mainC.get(i).followList().get(k) != null) {
        println(mainC.get(i).followList().get(k));
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(i).followList().get(k).getX()-mainC.get(i).followList().get(k).type(),mainC.get(i).followList().get(k).getY());
      }
  }
    if (!isEditMode && mainC.get(i).followList().size() != 0 && mainC.get(i).followList().get(0) == null) {
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(0).getX()-mainC.get(0).type(),mainC.get(0).getY());
    }
  }
}

void circlePrev() {
    noFill();
  stroke(255,0,0,100);
  circle(prev.getX(),prev.getY(),50);
}

void choosePrev(int x, int y) {
  prev = mainC.chooseComp(x,y);
}

void EditModeChange() {
      if(mouseX > 70 && mouseX < 170 && mouseY > 0 && mouseY < 80) {
    isEditMode = !isEditMode;
  }
}

void Editing() {
   if (!tab && mouseButton == LEFT && prev != null) {
     left();
  }
  else if (mouseButton == RIGHT || (tab && mouseButton == LEFT)) {
      choosePrev(mouseX,mouseY);
  }
  }

void left() {
      boolean temp = true;
    for (int i = 1; i < mainC.size(); i++) {
    if (Math.sqrt(Math.pow(mouseX-mainC.get(i).getX(),2) + Math.pow(mouseY-mainC.get(i).getY(),2)) < 60) {
      if (prev.connectFol(mainC.get(i))) {
      mainC.get(i).connectPre(prev);
      }
      else {
        prev = mainC.get(0);
      }
      temp = false;
    }
  }
  if (temp && mouseY < height-150-30 && mouseY > 70+30 && (mouseY > height/2+50+30 || (mouseX > 50+30 && mouseX < width-100-30))) {
    Component target = new Component(0,0,0,0,startJunction);
    if (compType == 0) {
      target = new Resistor(10,mouseX,mouseY,mainC.getVEQ());
    }
    else if (compType == 1) {
      target = new startJunction(mouseX,mouseY);
    }
    else if (compType == 2) {
      target = new endJunction(mouseX,mouseY,mainC.get(0));
    }
  mainC.add(target); //<>//
  if (prev.connectFol(target)) {
  target.connectPre(prev);
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

void Running() {
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

void generateNodes() {
      rectMode(CENTER);
    noStroke();
    for (int i = 1; i < mainC.size(); i++) {
    if (mainC.get(i).type() == resistor) {
    resistorIcon(mainC.get(i).getX(),mainC.get(i).getY());
    }
    else if (mainC.get(i).type() == startJunction) {
    startJunctionDisplay(mainC.get(i).getX(),mainC.get(i).getY());
    }
    else if (mainC.get(i).type() == endJunction) {
    endJunctionDisplay(mainC.get(i).getX(),mainC.get(i).getY());
    }
  }
}

  public void resistorIcon(int x, int y) {
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
   }

   void dataExtract() {
  if (debug) {
  textSize(30);
  text(mainC.chooseComp(mouseX,mouseY).toString(),25,500);
  if (prev != null) {
  text(prev.toString(), 25, 550);
  }
  text(mainC.chooseComp(mouseX,mouseY).followList().toString(),25,600);
  }
}

void findPartnerAll() {
  if (!isEditMode) {
  for (int i = 0; i < mainC.compList.size(); i++) {
    if (mainC.compList.get(i).type() == startJunction) {
      mainC.compList.get(i).findPartner();
    }
  }
  }
}

void slider(int x, int y, double level, String attach) {
  fill(0);
  stroke(0);
  textSize(50);
  text(attach+level/10.0,x-textWidth(attach+level/10)-20,y+40);
  strokeWeight(4);
  fill(0,255,0);
  rect(x,y,300,50,10);
  fill(0,0,255);
  rect(x,y,(float)level,50,10,0,0,10);
}
