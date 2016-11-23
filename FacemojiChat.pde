class FacemojiChat extends Chat {
  PImage emoji;
  PImage face;
  int emojiSideLength = 40;
  float emojiXPos, emojiYPos;
  boolean emojiClicked = false;
  
  public FacemojiChat(int side, PImage _emoji, PImage _face) {
    super(side);
    emoji = _emoji;
    face = _face;
  }
  
  void mousePressed() {
    println("clicked: " + emojiClicked);
    if (emojiHovered() && !emojiClicked) emojiClicked = true;
    else if (emojiClicked) {
      emojiClicked = false;
      chatScreen.getChatManager().setFaceDisplayMode(false);
    }
    println(emojiClicked);
    println(emojiXPos + " " + emojiYPos);
  }
  
  float speechBubbleSelf(float initialX, float yPos) {
    float bubbleFinalXPos = initialX - emojiSideLength;
    float bubbleSideLength = emojiSideLength + chatScreen.getChatManager().getBubblePadding()*2;
    pushMatrix();
    noStroke();
    fill(255);
    rect(bubbleFinalXPos, yPos, bubbleSideLength, bubbleSideLength, 30, 30, 3, 30);
    emojiXPos = bubbleFinalXPos + chatScreen.getChatManager().getBubblePadding();
    emojiYPos = yPos + chatScreen.getChatManager().getBubblePadding();
    image(emoji, emojiXPos, emojiYPos, emojiSideLength, emojiSideLength);
    if (emojiClicked) displayFace();
    popMatrix();
    return bubbleSideLength;
  }
  
  float speechBubbleOpposite(float initialX, float yPos) {
    float bubbleFinalXPos = initialX;
    float bubbleSideLength = emojiSideLength + chatScreen.getChatManager().getBubblePadding()*2;
    pushMatrix();
    noStroke();
    fill(#00bfff);
    rect(bubbleFinalXPos, yPos, bubbleSideLength, bubbleSideLength, 30, 30, 30, 3);
    emojiXPos = bubbleFinalXPos + chatScreen.getChatManager().getBubblePadding();
    emojiYPos = yPos + chatScreen.getChatManager().getBubblePadding();
    image(emoji, emojiXPos, emojiYPos, emojiSideLength, emojiSideLength);
    if (emojiClicked) displayFace();
    popMatrix();
    return bubbleSideLength;
  }
  
  boolean emojiHovered() {
    float dx = mouseX - emojiXPos;
    float dy = mouseY - emojiYPos;
    boolean hovered = (dx >= 0 && dx <= emojiSideLength && dy >= 0 && dy <= emojiSideLength);
    println(hovered);
    return hovered;
  }
  
  void displayFace() {
    chatScreen.getChatManager().setFaceImage(face);
  }
}