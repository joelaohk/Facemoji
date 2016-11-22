class TextChat extends Chat {
  private String message;
  
  
  public Chat(int side, String msg) {
    super(side);
    this.message = msg;
  }
  
  public float chatBubbleSelf(int initialX, int yPos) {
    textSize(chatTextSize);            
    float wid = min(200,textWidth(content));
    float hei = chatTextSize;
    if (wid == 200) {
      int scaleFact = ceil(textWidth(content)/200);
      hei *= scaleFact;
      hei += 10*(scaleFact-1);
    }
    
    noStroke();
    fill(255);
    float bubbleFinalXPos = initialX - wid;
    float bubbleFinalWidth = wid + manager.getBubblePadding()*2;
    float bubbleFinalHeight = hei + manager.getBubblePadding()*2;
    rect(bubbleFinalXPos, yPos, bubbleFinalWidth, bubbleFinalHeight, 30, 30, 3, 30);
    textAlign(LEFT);
    fill(0);
    
    float textXPos = bubbleFinalXPos + manager.getBubblePadding();
    float textYPos = yPos + manager.getBubblePadding();
    text(content, textXPos, textYPos, wid+10, hei+15);
  }
  
  public float chatBubbleOpposite(int initialX, int yPos) {
    textSize(chatTextSize);            
    float wid = min(200,textWidth(content));
    float hei = chatTextSize;
    if (wid == 200) {
      int scaleFact = ceil(textWidth(content)/200);
      hei *= scaleFact;
      hei += 10*(scaleFact-1);
    }
    
    noStroke();
    fill(#00bfff);
    float bubbleFinalXPos = initialX;
    float bubbleFinalWidth = wid + manager.getBubblePadding()*2;
    float bubbleFinalHeight = hei + manager.getBubblePadding()*2;
    rect(bubbleFinalXPos, yPos, bubbleFinalWidth, bubbleFinalHeight, 30, 30, 30, 3);
    textAlign(LEFT);
    fill(0);
    
    float textXPos = bubbleFinalXPos + manager.getBubblePadding();
    float textYPos = yPos + manager.getBubblePadding();
    text(content, textXPos, textYPos, wid+10, hei+15);
  }
}