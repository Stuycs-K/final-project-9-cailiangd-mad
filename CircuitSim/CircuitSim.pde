/*
Below is a TEMPORARY arraylist for debugging
*/
ArrayList<int[]> temp;


void setup() {
  size(800,800);
  temp = new ArrayList<int[]>();
}

void draw() {
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
  rect(755,416,40,10);
  rect(50,400,10,40);
  
  /*
  Add resistors.
  I haven't figure out how I want the connecting components UI should work.
  */
  for (int[] vals: temp) {
    rect(vals[0],vals[1],25,30,15,0,0,15);
    fill(205,85,124);
    rect(vals[0]+25,vals[1],25,30,0,15,15,0);
    fill(0);
  }
}

void mousePressed() {
  temp.add(new int[] {mouseX,mouseY});
}
