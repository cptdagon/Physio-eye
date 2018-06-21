float Xoffset;
float Yoffset;
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
int trailSize = 60;
int trailLength;
PFont font;

void setup() {
  size(800, 500);  
  HeartRate = new ArrayList<PVector>();
  frameRate(1);
  smooth(8);
  stroke(255);
  font = createFont("FranklinGothicHeavyRegular.ttf", 15);
  textFont(font);
  hr = 60;
  hrcounter = 2;
  Xoffset = 60;
  Yoffset = 270;
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
  depth = Yoffset - Vpos;
  //gridlines;
  stroke(100);
  for(int i = 0; i<6; i++){
    line(Xoffset,Yoffset-(50*i),(600+Xoffset),Yoffset-(50*i));    
  }
  for(int i = 0; i<13; i++){
  line(Xoffset+(50*i),Yoffset-(250),Xoffset+(50*i),Yoffset);
  }
  //axis
  stroke(255);
  line(Xoffset,Yoffset-(250),Xoffset,Yoffset);
  line(Xoffset,Yoffset,(600+Xoffset),Yoffset);
  
  
  float x = Xoffset-30;
  float y = Yoffset-110;
  
  textAlign(CENTER,BOTTOM);
  pushMatrix();
  translate(x,y);
  rotate(-HALF_PI);
  text("Heart Rate (BPM)",0,0);
  popMatrix();
  
  textAlign(CENTER);
  text("time (s)",Xoffset+(600/2)-25,Yoffset+50);
  
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
    previousvalue = Yoffset - previousTrail.y;
    currentvalue = Yoffset - currentTrail.y;
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
