float a;
float b;
float c;
ArrayList<PVector> HeartRate;
PVector circlePosition;
PVector newcirclePosition;
int trailSize = 50;
int trailLength;
PImage img,img2;
PFont font;

void setup() {
  size(1280, 720);  
  stroke(255);
  fill(0);
  c = -20;
  HeartRate = new ArrayList<PVector>();
  frameRate(30);
  smooth(4);
}

void draw(){
  background(27, 214, 135); 
  b = random(30, 221);
  a = 0;
  ellipse(a, b, 5, 5); 
  circlePosition = new PVector(a, b);
  HeartRate.add(circlePosition);
  trailLength = HeartRate.size()-2;
  for (int i = 0; i < trailLength; i++) {
    PVector currentTrail = HeartRate.get(i);
    currentTrail.x = currentTrail.x + 5;
    newcirclePosition = new PVector((currentTrail.x + 10),currentTrail.y);
    HeartRate.set(i, newcirclePosition);
  }
  for (int i = 0; i < trailLength; i++) {
    PVector currentTrail = HeartRate.get(i);
    PVector previousTrail = HeartRate.get(i + 1);
    stroke(0);//255*i/trailLength);
    strokeWeight(2);
    line(
      currentTrail.x, currentTrail.y,
      previousTrail.x, previousTrail.y
    );
  }
  
  if (trailLength >= trailSize) {
    HeartRate.remove(0);
  }
}
