float scaledwidth;
float scaledheight;
float counter;
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
  scaledwidth = width/2.77;
  scaledheight = height/1.6;
  counter = -20;
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
  scaledwidth = scaledwidth + (width/720);
  if(counter<10 && counter>-1){
  }
  if(counter<40 && counter>19){
  scaledheight = scaledheight - (height/320);
  }
  if(counter<75 && counter>39){
  scaledheight = scaledheight + (height/320);
  }
  if(counter<95 && counter>74){
  scaledheight = scaledheight - (height/256);
  }
  if(counter<120 && counter>94){
  scaledheight = scaledheight + (height/426.67);
  }
  if(counter<132 && counter>119){
  scaledheight = scaledheight - (height/441.38);
  }
  if(counter<215 && counter>204){
  }
  counter++;
  circlePosition = new PVector(scaledwidth, scaledheight);
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
  ellipse(scaledwidth, scaledheight, 15, 15); 
  if (trailLength >= trailSize) {
    circleTrail.remove(0);
  }
 
  if (counter>162){
  counter = -20;
  scaledwidth = width/2.77;
  scaledheight = height/1.6;
  circleTrail.clear();
  }
  textAlign(CENTER);
  text("© DagonIM 2018", width/2, (height*8)/9);
}
