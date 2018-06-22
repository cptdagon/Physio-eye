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
  
  textAlign(CENTER);
  text("Sign Up",width/2,height*3/4);
  text("Sign Up",width/2,height*3/4);
  
  textAlign(CENTER);
  text("© DagonIM 2018", width/2, (height*8)/9);
}
