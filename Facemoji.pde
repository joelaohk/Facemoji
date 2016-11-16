import controlP5.*;

ControlP5 cp5;
Textlabel t2;
PImage keyboard;
Textfield draft;
int keyY;
int keyH;
int funcBarY;
int funcBarH;

void settings() {
  size(405,720);
}

void setup() {
  
  cp5 = new ControlP5(this);
  speechOppSet();
  
  cp5.addTextfield("draft")
     .setPosition(7,height-7-28)
     .setColor(0)
     .setColorBackground(232232232) 
     .setSize(width*2/3,28)
     .setFocus(false)
     .setFont(createFont("arial",15))
     .setLabelVisible(false);
     
  draft = cp5.get(Textfield.class, "draft");
  keyboard = loadImage("keyboard.jpg");
  keyY = height;
  keyH = 683*width/1242;
  funcBarH = 42;
  funcBarY = height-funcBarH;
}


void draw() {
  background(244);
  speechBubbleOpposite("What\'s up dud?");
  image(keyboard,0,keyY,width,keyH);
  funcBar();
}

void speechOppSet() {
  t2 = cp5.addTextlabel("opposite")
          .setFont(createFont("Arial",20))
          .setPosition(24, 26)
          .setColorValue(255);
}

void speechBubbleOpposite(String content) {
  t2.setText(content);
  
  noStroke();
  fill(#00bfff);
  rect(16, 20, t2.getWidth()+20, t2.getHeight()+16, 30, 30, 30, 3);
  t2.draw(this);
}

void funcBar() {
  fill(255);
  noStroke();
  rect(0,funcBarY,width,funcBarH);
  
}

void mousePressed() {
  if (draft.isFocus()) {
    draft.setPosition(7,height-keyH-7-28).setFocus(true);
    keyY = height-keyH;
    funcBarY = height-keyH-funcBarH;
  } else if (!draft.isFocus()) {
    if (keyboardTyped()) {
      draft.setFocus(true);
      return;
    }
    draft.setPosition(7,height-7-28).setFocus(false);
    keyY = height;
    funcBarY = height-funcBarH;
  }
}

boolean keyboardTyped() {
  if (mouseY>=height-keyH-funcBarH && mouseY<=height) {
    return true;
  } else {
    return false;
  }
}