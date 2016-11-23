class ChatTopBar {
  private PImage backButton;
  private float xPos;
  
  public ChatTopBar() {
    backButton = loadImage("back.png");
  }

  void display(float x, Contact c) {
    xPos = x;
    pushMatrix();
    fill(240);
    rect(xPos,0,width,90);
    textSize(32);
    textAlign(CENTER);
    fill(50);
    text(c.getName(),width/2 + xPos,45+15);
    image(backButton, 15 + xPos, 15, 60, 60);
    image(c.getProfilePic(), width-75 + xPos, 15, 60, 60);
    popMatrix();
  }
  
  void mousePressed() {
    if (!chatScreen.getChatManager().getDisplayMode()) {
      float dx = mouseX - (15 + xPos);
      float dy = mouseY - 15;
      if (dx > 0 && dx < 60 && dy > 0 && dy < 60) {
        setCurrScreen(0);
      }
      
    }
    
  }
}