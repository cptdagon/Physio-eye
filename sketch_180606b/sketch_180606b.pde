float a;
float b;
float c;
float d;
float e;
float xmidpoint;
float ymidpoint;
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
  frameRate(240);
  smooth(4);
  stroke(255);
}

void draw(){
  background(0); 
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
    e = 400 - previousTrail.y;
    d = 400 - currentTrail.y;
    xmidpoint = (currentTrail.x + previousTrail.x)/2;
    ymidpoint = (currentTrail.y + previousTrail.y)/2;
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
      xmidpoint, ymidpoint
    );
    if (e>29){
    stroke(0,255,0);
    }
    if (e>100){
      stroke(255,255,0);
    }
    if (e>160){
      stroke(255,0,0);
    }
    strokeWeight(2);
    line(
      xmidpoint, ymidpoint,
      previousTrail.x, previousTrail.y
    );
  }
  if (trailLength >= trailSize) {
    HeartRate.remove(0);
  }
}
