float Xoffset;
float depth;
float Vpos;
float currentvalue;
float previousvalue;
float xmidpoint;
float ymidpoint;
int hrcounter;
int hr;
ArrayList<PVector> HeartRate;
PVector circlePosition;
PVector newcirclePosition;
int trailSize = 50;
int trailLength;
PFont font;

void setup() {
  size(800, 500);  
  HeartRate = new ArrayList<PVector>();
  frameRate(15);
  smooth(8);
  stroke(255);
  font = createFont("FranklinGothicHeavyRegular.ttf", 15);
  textFont(font);
  hr = 60;
  hrcounter = 2;
  Xoffset = 50;
  strokeWeight(2);
}

void draw(){
  background(0); 
  if(hr >= 220){
  hrcounter = -2;
  }
  if (hr <= 30){
  hrcounter = 2;
  }
  hr = hr + hrcounter;
  Vpos = hr;
  depth = 250 - Vpos;
  
  stroke(255);
  line(Xoffset,20,Xoffset,250);
  line(Xoffset,250,(500+Xoffset),250);
  
  float x = Xoffset-15;
  float y = 140;
  
  textAlign(CENTER,BOTTOM);
  pushMatrix();
  translate(x,y);
  rotate(-HALF_PI);
  text("Heart Rate (BPM)",0,0);
  popMatrix();
  
  textAlign(CENTER);
  text("time (s)",Xoffset+225,270);
  
  ellipse(Xoffset, depth, 5, 5); 
  circlePosition = new PVector(Xoffset, depth);
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
    previousvalue = 250 - previousTrail.y;
    currentvalue = 250 - currentTrail.y;
    xmidpoint = (currentTrail.x + previousTrail.x)/2;
    ymidpoint = (currentTrail.y + previousTrail.y)/2;
    
    if (currentvalue>29){
    stroke(0,255,0);
    }
    if (currentvalue>100){
      stroke(255,255,0);
    }
    if (currentvalue>180){
      stroke(255,0,0);
    }
    
    line(
      currentTrail.x, currentTrail.y,
      xmidpoint, ymidpoint
    );
    
    if (previousvalue>29){
    stroke(0,255,0);
    }
    if (previousvalue>100){
      stroke(255,255,0);
    }
    if (previousvalue>180){
      stroke(255,0,0);
    }
    
    line(
      xmidpoint, ymidpoint,
      previousTrail.x, previousTrail.y
    ); 
  }
  
  if (trailLength >= trailSize) {
    HeartRate.remove(0);
  }
}
