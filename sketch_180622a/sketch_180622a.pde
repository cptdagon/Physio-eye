PImage img;
PFont font, largefont;

void setup() {
  //
  size(720, 1280);
  //
  img = loadImage("Untitled.png");
  //
  frameRate(60);
  //
  font = createFont("FranklinGothicHeavyRegular.ttf", 20);
  largefont = createFont("FranklinGothicHeavyRegular.ttf",30);
  //
  fill(0);
  stroke(255);
  smooth(4);
}

void draw() {
  background(27, 214, 135); 
  image(img, 0, 0);  
  //
  textFont(largefont);
  textAlign(CENTER);
  text("Login",width/2,height/2);
  text("Username:",width/2,height*16/30);
  text("Password:",width/2,height*17/30);
  text("Sign Up",width/2,height*13/20);
  //
  textFont(font);
  textAlign(CENTER);
  text("Forgotten Password",width/2,height*12/20);
  text("© DagonIM 2018", width/2, (height*8)/9);
}
