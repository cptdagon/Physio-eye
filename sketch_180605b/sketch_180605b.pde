float a;
float b;
float c;
ArrayList<PVector> circleTrail;
PVector circlePosition;
int trailSize = 20;
int trailLength;
PImage img,img2;
PFont font;

void setup() {
  size(720, 1280);
  img = loadImage("Untitled.png");
  stroke(255);
  fill(0);
  a = width/2.77;
  b = height/1.6;
  c = -20;
  circleTrail = new ArrayList<PVector>();
  frameRate(60);
  font = createFont("FranklinGothicHeavyRegular.ttf", 20);
  textFont(font);
  smooth(4);
}

void draw() {
  background(27, 214, 135); 
  image(img, 0, 0);  
  //line(800,800,0,800);
  a = a + (width/720);
  if(c<10 && c>-1){
  }
  if(c<40 && c>19){
  b = b - (height/320);
  }
  if(c<75 && c>39){
  b = b + (height/320);
  }
  if(c<95 && c>74){
  b = b - (height/256);
  }
  if(c<120 && c>94){
  b = b + (height/426.67);
  }
  if(c<132 && c>119){
  b = b - (height/441.38);
  }
  if(c<215 && c>204){
  }
  c++;
  circlePosition = new PVector(a, b);
  circleTrail.add(circlePosition);
  trailLength = circleTrail.size() - 2;
  for (int i = 0; i < trailLength; i++) {
    PVector currentTrail = circleTrail.get(i);
    PVector previousTrail = circleTrail.get(i + 1);
    stroke(0);
    strokeWeight(10);    
    line(
      currentTrail.x, currentTrail.y,
      previousTrail.x, previousTrail.y
    );
  }
  ellipse(a, b, 15, 15); 
  if (trailLength >= trailSize) {
    circleTrail.remove(0);
  }
 
  if (c>162){
  c = -20;
  a = width/2.77;
  b = height/1.6;
  circleTrail.clear();
  }
  text("© DagonIM 2018", 270, 1200);
}
