class FuncBar {
  int barHeight = 42;
  float xPos = 0;
  float yPos;
  boolean funcBarUp = false;
  controlP5.Button facemojiTrigger;
  TextInput draft;
  PImage icon;
  PImage icon_on;
  
  public FuncBar() {
    yPos = height-barHeight;
    
    icon = loadImage("icon.png");
    icon_on = loadImage("icon_on.png");
    icon.resize(26,28);
    icon_on.resize(26,28);
    
    facemojiTrigger = cp5.addButton("trigger")
                         .setImage(icon)
                         .setPosition(xPos + 7 + width*2/3 + 30,height-7-28)
                         .setSize(26,28)
                         .setValue(0);
    
    draft = new TextInput(cp5, "draft");
    draft.setColor(0)
         .setPosition(xPos + 7,height-7-28)
         .setColorBackground(#FAFAFA)
         .setSize(width*2/3,28)
         .setFocus(false)
         .setFont(createFont("arial",15))
         .setLabelVisible(true);
    
    
  }
  
  void display(float x) {
    xPos = x;
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
  
  boolean isUp() {
    return funcBarUp;
  }
  
  int getHeight () {
    return barHeight;
  }
  
  void trigger(int value) {
    println(value);
    if (!funcBar.isUp()) {
      funcBar.raiseUpFuncBar();
      panel.raiseUpPanel();
    } else {
      if (!panel.isPanelUp()) {
        pushDownKeyboard();
        panel.raiseUpPanel();
      } else {
        panel.pushDownPanel();
        raiseUpKeyboard();
      }
    }
  }
  
  void controlEvent(ControlEvent theEvent) {
    if(theEvent.isAssignableFrom(TextInput.class)) {
      println("controlEvent: accessing a string from controller '"
              +theEvent.getName()+"': "
              +theEvent.getStringValue()
              );
      Chat c = new TextChat(0, draft.getText());
      manager.addChat(c);
    }
    
    
  }
}