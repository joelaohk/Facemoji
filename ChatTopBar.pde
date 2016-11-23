class ChatTopBar {
  private PImage backButton;
  
  public ChatTopBar(Contact c) {
    backButton = loadImage("back.png");
  }

  void display(float xPos, Contact c) {
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
}