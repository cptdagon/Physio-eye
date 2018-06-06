float a;
float b;
float c;
float d;
ArrayList<PVector> HeartRate;
PVector circlePosition;
PVector newcirclePosition;
int trailSize = 50;
int trailLength;
PImage img;

void setup() {
  size(800, 500);  
  c = -20;
  HeartRate = new ArrayList<PVector>();
  frameRate(1);
  smooth(4);
  stroke(0);
}

void draw(){
  background(255); 
  c = random(30, 221);
  b = 400 - c;
  a = 0;
  ellipse(a, b, 1, 1); 
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
    d = 400 - currentTrail.y;
    if (d>29){
    stroke(0,255,0);
    }
    if (d>100){
      stroke(255,255,0);
    }
    if (d>160){
      stroke(255,0,0);
    }
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
