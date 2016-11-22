class FacemojiChat extends Chat {
  PImage emoji;
  PImage face;
  int emojiXPos, emojiYPos;
  int emojiSideLength = 40;
  boolean emojiClicked = false;
  
  public FacemojiChat(int side, PImage _emoji, PImage _face) {
    super(side);
    emoji = _emoji;
    face = _face;
  }
  
  void mousePressed() {
    if (emojiHovered() && !emojiClicked) imageClicked = true;
    if (imageClicked) emojiClicked = false;
  }
  
  float chatBubbleSelf(int initialX, int yPos) {
    int bubbleFinalXPos = initialX - emojiSideLength;
    int bubbleSideLength = emojiSideLength + manager.getBubblePadding()*2;
    pushMatrix();
    noStroke();
    fill(255);
    rect(bubblefinalXPos, yPos, bubbleSideLength, bubbleSideLength, 30, 30, 3, 30);
    emojiXPos = bubbleFinalXPos + manager.getBubblePadding();
    emojiYPos = yPos + manager.getBubblePadding();
    image(emoji, emojiXPos, emojiYPos, emojiSideLength, emojiSideLength);
    if (imageClicked) displayFace();
    popMatrix();
    return bubbleSideLength;
  }
  
  float chatBubbleOpposite(int initialX, int yPos) {
    int bubbleFinalXPos = initialX;
    int bubbleSideLength = emojiSideLength + manager.getBubblePadding()*2;
    noStroke();
    fill(#00bfff);
    rect(chatFinalXPos, yPos, bubbleSideLength, bubbleSideLength, 30, 30, 30, 3);
    emojiXPos = bubbleFinalXPos + manager.getBubblePadding();
    emojiYPos = yPos + manager.getBubblePadding();
    image(emoji, emojiXPos, emojiYPos, emojiSideLength, emojiSideLength);
    if (imageClicked) displayFace();
    popMatrix();
    return bubbleSideLength;
  }
  
  boolean emojiHovered() {
    int dx = mouseX - emojiXPos;
    int dy = mouseY - emojiYPos;
    return (dx => 0 && dx <= emojiSideLength && dy => 0 && dy <= emojiSideLength);
  }
  
  void displayFace() {
    fill(240);
    rect(10, 10, width-20, width-20, 30);
    image(face, 20, 20, width-40, width-40);
  }
}