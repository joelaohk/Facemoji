class FuncBar {
  int barHeight = 42;
  float xPos;
  float yPos;
  boolean funcBarUp = false;
  controlP5.Button facemojiTrigger;
  TextInput draft;
  PImage icon;
  PImage icon_on;
  PImage camera;
  PImage send;
  
  public FuncBar() {
    
    yPos = height-barHeight;
    
    icon = loadImage("icon.png");
    icon_on = loadImage("icon_on.png");
    icon.resize(26,28);
    icon_on.resize(26,28);
    camera = loadImage("camera.png");
    camera.resize(32,32);
    send = loadImage("send.png");
    send.resize(28,28);
    
    facemojiTrigger = cp5.addButton("trigger")
                         .setImage(icon)
                         .setSize(26,28)
                         .setValue(0);
    
    draft = new TextInput(cp5, "draft");
    draft.setColor(0)
         .setColorBackground(#FAFAFA)
         .setSize(325,28)
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
    draft.setPosition(xPos + 7,yPos+7);
    if (!draft.getText().equals("")) {
      textSize(20);
      fill(#00bfff);
      draft.setSize(290, 28);
      image(camera, xPos + 290 + 7*2,yPos+7);
      facemojiTrigger.setPosition(xPos + 290 + 28 + 7*3,yPos+7);
      image(send, xPos + 290 + 28 + 26 + 7*4, yPos + 7);
    } else {
      facemojiTrigger.setPosition(xPos + 325 + 28 + 7*3,yPos+7);
      image(camera, xPos + 325 + 7*2,yPos+7);
      draft.setSize(325, 28);
    }
    popMatrix();
  }
  
  void raiseUpFuncBar() {
    yPos = height-chatScreen.getKeyboardHeight()-barHeight;
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
  
  void mousePressed() {
    float dx = mouseX - (xPos + 290 + 28 + 26 + 7*4);
    float dy = mouseY - (yPos+7);
    if (dx > 0 && dx < 28 && dy > 0 && dy < 28 && !draft.getText().equals("")) {
      println("dude");
      draft.submit();
    }
  }
  
  void trigger(int value) {
    println(value);
    if (!chatScreen.getFuncBar().isUp()) {
      raiseUpFuncBar();
      chatScreen.getPanel().raiseUpPanel();
    } else {
      if (!chatScreen.getPanel().isPanelUp()) {
        chatScreen.pushDownKeyboard();
        chatScreen.getPanel().raiseUpPanel();
      } else {
        chatScreen.getPanel().pushDownPanel();
        chatScreen.raiseUpKeyboard();
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
      chatScreen.getChatManager().addChat(c);
    }
    
    
  }
}