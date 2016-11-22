class ChatTopBar {
  private PImage backButton;
  
  public ChatTopBar() {
    backButton = loadImage("back.png");
  }

  void display(float xPos, String contact, PImage contactImg) {
    pushMatrix();
    fill(240);
    rect(xPos,0,width,90);
    textSize(32);
    textAlign(CENTER);
    fill(50);
    text(contact,width/2 + xPos,45+15);
    image(backButton, 15 + xPos, 15, 60, 60);
    image(contactImg, width-75 + xPos, 15, 60, 60);
    popMatrix();
  }
}