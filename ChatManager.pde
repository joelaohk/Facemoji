class ChatManager {
  private ArrayList<Chat> chats;
  private int xPos;
  int chatStartXPos;
  int chatStartYPos;
  final int chatTextSize = 15;
  final int chatBorderPad = 10;
  final int chatMargin = 10;
  
  public ChatManager() {
    chatStartXPos = 10;
    chatStartYPos = 100;
    chats = new ArrayList<Chat>();
  }
  
  void loadChatData() {
    JSONArray chatJsonA = loadJSONObject("chat.json").getJSONArray("chat");
    for (int i = 0; i < chatJsonA.size(); i++) {
      JSONObject chatJsonO = chatJsonA.getJSONObject(i);
      int side = chatJsonO.getInt("side");
      String msg = chatJsonO.getString("msg");
      Chat chat = new Chat(side, msg);
      chats.add(chat);
    }
  }
  
  void addChat(Chat c) {
    println("chatAdded");
    chats.add(c);
  }
  
  void displayChats(int x) {
    xPos = x;
    for (Chat c:chats) {
      if (c.getSide() == 0) {
        speechBubbleSelf(c.getMsg());
      } else {
        speechBubbleOpposite(c.getMsg());
      }
    }
    chatStartYPos = 100;
  }
  
  void speechBubbleSelf(String content) {
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
    float chatfinalXPos = width - chatStartXPos - wid - chatBorderPad*2 + xPos;
    float chatfinalWidth = wid + chatBorderPad*2;
    float chatfinalHeight = hei + chatBorderPad*2;
    rect(chatfinalXPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 3, 30);
    textAlign(LEFT);
    fill(0);
    text(content, width - chatStartXPos - wid - chatBorderPad + xPos, chatStartYPos + chatBorderPad, wid+10, hei+15);
    
    chatStartYPos += chatfinalHeight + chatMargin;
  }
  
  void speechBubbleOpposite(String content) {
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
    float chatfinalWidth = wid + chatBorderPad*2;
    float chatfinalHeight = hei + chatBorderPad*2;
    rect(chatStartXPos + xPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 30, 3);
    
    textAlign(LEFT);
    fill(255);
    text(content, chatStartXPos + chatBorderPad + xPos, chatStartYPos + chatBorderPad, wid+10, hei+15);
    
    chatStartYPos += chatfinalHeight + chatMargin;
  }
  
  void speechBubbleSelf(PImage emoji) {
  }
}