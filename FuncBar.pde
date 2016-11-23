class FuncBar {
  int barHeight = 42;
  float xPos;
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
                         .setSize(26,28)
                         .setValue(0);
    
    draft = new TextInput(cp5, "draft");
    draft.setColor(0)
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
    facemojiTrigger.setPosition(xPos + 7 + width*2/3 + 30,yPos+7);
    draft.setPosition(xPos + 7,yPos+7);
    if (!draft.getText().equals("")) {
      textSize(28);
      fill(#00bfff);
      text("Send", xPos + width*2/3 + 65, yPos+7);
    }      
    popMatrix();
  }
  
  void raiseUpFuncBar() {
    yPos = height-keyH-barHeight;
    funcBarUp = true;
  }
  
  void pushDownFuncBar() {
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
      raiseUpFuncBar();
      screen1.getPanel().raiseUpPanel();
    } else {
      if (!panel.isPanelUp()) {
        screen1.pushDownKeyboard();
        screen1.getPanel().raiseUpPanel();
      } else {
        screen1.getPanel().pushDownPanel();
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
      screen1.getChatManager().addChat(c);
    }
    
    
  }
}