class TextChat extends Chat {
  private String message;
  private final int chatTextSize = 15;
  
  public TextChat(int side, String msg) {
    super(side);
    this.message = msg;
  }
  
  public float speechBubbleSelf(float initialX, float yPos) {
    textSize(chatTextSize);            
    float wid = min(200,textWidth(message));
    float hei = chatTextSize;
    if (wid == 200) {
      int scaleFact = ceil(textWidth(message)/200);
      hei *= scaleFact;
      hei += 10*(scaleFact-1);
    }
    
    noStroke();
    fill(255);
    float bubbleFinalXPos = initialX - wid;
    float bubbleFinalWidth = wid + chatScreen.getChatManager().getBubblePadding()*2;
    float bubbleFinalHeight = hei + chatScreen.getChatManager().getBubblePadding()*2;
    rect(bubbleFinalXPos, yPos, bubbleFinalWidth, bubbleFinalHeight, 30, 30, 3, 30);
    textAlign(LEFT);
    fill(0);
    
    float textXPos = bubbleFinalXPos + chatScreen.getChatManager().getBubblePadding();
    float textYPos = yPos + chatScreen.getChatManager().getBubblePadding();
    text(message, textXPos, textYPos, wid+10, hei+15);
    
    return bubbleFinalHeight;
  }
  
  public float speechBubbleOpposite(float initialX, float yPos) {
    textSize(chatTextSize);            
    float wid = min(200,textWidth(message));
    float hei = chatTextSize;
    if (wid == 200) {
      int scaleFact = ceil(textWidth(message)/200);
      hei *= scaleFact;
      hei += 10*(scaleFact-1);
    }
    
    noStroke();
    fill(#00bfff);
    float bubbleFinalXPos = initialX;
    float bubbleFinalWidth = wid + chatScreen.getChatManager().getBubblePadding()*2;
    float bubbleFinalHeight = hei + chatScreen.getChatManager().getBubblePadding()*2;
    rect(bubbleFinalXPos, yPos, bubbleFinalWidth, bubbleFinalHeight, 30, 30, 30, 3);
    textAlign(LEFT);
    fill(255);
    
    float textXPos = bubbleFinalXPos + chatScreen.getChatManager().getBubblePadding();
    float textYPos = yPos + chatScreen.getChatManager().getBubblePadding();
    text(message, textXPos, textYPos, wid+10, hei+15);
    
    return bubbleFinalHeight;
  }
}