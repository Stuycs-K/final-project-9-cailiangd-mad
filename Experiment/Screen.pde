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
  run(120,40);
    stroke(0);
  strokeWeight(6);
  strokeCap(SQUARE);
  line(70,0,70,80);
  line(170,0,170,80);
}

void dataDisplay() {
    if (!isEditMode) {
        mainC.calculate();
    if (prev != mainC.get(0)) {
      textSize(40);
      text("resistance: "+round((float)prev.resistance()*1000.0)/1000.0,10,height-100);
      text("        power: "+round((float)prev.power()*1000.0)/1000.0,10,height-50);
      text("   current: "+round((float)prev.current()*1000.0)/1000.0,350,height-100);
      text("   voltage: "+round((float)prev.voltage()*1000.0)/1000.0,350,height-50);
    }
}
}

void generateConnections() {
  for (int i = 0; i < mainC.size(); i++) {
    for (int k = 0; k < mainC.get(i).fol().size(); k++) {
      stroke(0);
      if (mainC.get(i).fol().get(k) != null) {
      line(mainC.get(i).getX()+mainC.get(i).type(),mainC.get(i).getY(),mainC.get(i).fol().get(k).getX()-mainC.get(i).fol().get(k).type(),mainC.get(i).fol().get(k).getY());
      }
  }
    if (!isEditMode && mainC.get(i).fol().size() != 0 && mainC.get(i).fol().get(0) == null) {
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
      prev.connectFol(mainC.get(i));
      mainC.get(i).connectPre(prev);
      temp = false;
    }
  }
  if (temp && mouseY < height-150-30 && mouseY > 70+30 && (mouseY > height/2+50+30 || (mouseX > 50+30 && mouseX < width-100-30))) {
    Component newComp = new Resistor(10,mouseX,mouseY,mainC.count());
    prev.connectFol(newComp);
    newComp.connectPre(prev);
    mainC.add(newComp);
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
    println("help");
    }
    /*Need to implement.*/
  }
}

  public void resistorIcon(int x, int y) {
        fill(0);
    rect(x-12.5,y,25,30,15,0,0,15);
    fill(205,85,124);
    rect(x+12.5,y,25,30,0,15,15,0);
  }

   void dataExtract() {
  if (debug) {
  textSize(30);
  text(mainC.chooseComp(mouseX,mouseY).toString(),25,500);
  if (prev != null) {
  text(prev.toString(), 25, 550);
  }
  text(mainC.chooseComp(mouseX,mouseY).fol().toString(),25,600);
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
