class FuncBar {
  int xPos, yPos;
  int barHeight;
  boolean funcBarUp = false;
  controlP5.Button facemojiTrigger;
  TextInput draft;
  PImage icon;
  PImage icon_on;
  
  public FuncBar(int x) {
    barHeight = 42;
    xPos = x;
    yPos = height-barHeight;
    
    icon = loadImage("icon.png");
    icon_on = loadImage("icon_on.png");
    icon.resize(26,28);
    icon_on.resize(26,28);
    
    facemojiTrigger = cp5.addButton("trigger")
                         .setPosition(xPos + 7 + width*2/3 + 30,height-7-28)
                         .setImage(icon)
                         .setSize(26,28)
                         .setValue(0);
    
    draft = new TextInput(cp5, "draft");
    draft.setPosition(xPos + 7,height-7-28)
         .setColor(0)
         .setColorBackground(#FAFAFA)
         .setSize(width*2/3,28)
         .setFocus(false)
         .setFont(createFont("arial",15))
         .setLabelVisible(true);
    
    
  }
  
  void display() {
    pushMatrix();
    fill(255);
    noStroke();
    rect(xPos,yPos,width,barHeight);
    popMatrix();
  }
  
  void raiseUpFuncBar() {
    draft.setPosition(xPos + 7,height-keyH-7-28);
    facemojiTrigger.setPosition(xPos + 7 + width*2/3 + 30,height-7-28-keyH);
    yPos = height-keyH-barHeight;
    funcBarUp = true;
  }
  
  void pushDownFuncBar() {
    draft.setPosition(xPos + 7,height-7-28);
    facemojiTrigger.setPosition(xPos + 7 + width*2/3 + 30,height-7-28);
    yPos = height-barHeight;
    funcBarUp = false;
  }
  
  void turnOnTrigger() {
    facemojiTrigger.setImage(icon_on);
  }
  
  void turnOffTrigger() {
    facemojiTrigger.setImage(icon);
  }
  
  void adjustXPos(int x) {
    xPos = x;
  }
  
  boolean isUp() {
    return funcBarUp;
  }
  
  int getHeight () {
    return barHeight;
  }
}