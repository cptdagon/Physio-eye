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
PFont font;

void setup() {
  size(800, 500);  
  c = -20;
  HeartRate = new ArrayList<PVector>();
  frameRate(5);
  smooth(4);
  stroke(255);
  font = createFont("FranklinGothicHeavyRegular.ttf", 15);
  textFont(font);
}

void draw(){
  background(0); 
  c = random(30, 221);
  b = 250 - c;
  a = 50;
  stroke(255);
  line(a,20,a,250);
  line(a,250,(500+a),250);
  
  float x = 35;
  float y = 140;
  textAlign(CENTER,BOTTOM);
  pushMatrix();
  translate(x,y);
  rotate(-HALF_PI);
  text("Heart Rate (BPM)",0,0);
  popMatrix();
  textAlign(CENTER);
  text("time (s)",275,270);
  ellipse(a, b, 5, 5); 
  circlePosition = new PVector(a, b);
  HeartRate.add(circlePosition);
  trailLength = HeartRate.size()-1;
  for (int i = 0; i < trailLength; i++) {
    PVector currentTrail = HeartRate.get(i);
    newcirclePosition = new PVector((currentTrail.x + 10),currentTrail.y);
    HeartRate.set(i, newcirclePosition);
  }
  for (int i = 0; i < trailLength; i++) {
    PVector currentTrail = HeartRate.get(i);
    PVector previousTrail = HeartRate.get(i + 1);
    e = 250 - previousTrail.y;
    d = 250 - currentTrail.y;
    xmidpoint = (currentTrail.x + previousTrail.x)/2;
    ymidpoint = (currentTrail.y + previousTrail.y)/2;
    if (d>29){
    stroke(0,255,0);
    }
    if (d>100){
      stroke(255,255,0);
    }
    if (d>180){
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
