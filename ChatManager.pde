class ChatManager {
  private ArrayList<Chat> chats;
  float chatStartXPos;
  float chatStartYPos;
  boolean faceDisplayMode = false;
  PImage displayFace;
  final float chatBorderPad = 10;
  final float chatMargin = 10;
  
  public ChatManager() {
    chatStartXPos = 10;
    chatStartYPos = 100;
    chats = new ArrayList<Chat>();
    loadChatData();
  }
  
  void loadChatData() {
    JSONArray chatJsonA = loadJSONObject("chat.json").getJSONArray("chat");
    for (int i = 0; i < chatJsonA.size(); i++) {
      JSONObject chatJsonO = chatJsonA.getJSONObject(i);
      int side = chatJsonO.getInt("side");
      Chat chat;
      if (chatJsonO.getString("type").equals("text")) {
        String msg = chatJsonO.getString("msg");
        chat = new TextChat(side, msg);
      } else {
        PImage emoji = loadImage("emoji/" + chatJsonO.getString("emoji"));
        PImage face = loadImage("face/" + chatJsonO.getString("face"));
        chat = new FacemojiChat(side, emoji, face);
      }
      chats.add(chat);
    }
  }
  
  void addChat(Chat c) {
    println("chatAdded");
    chats.add(c);
  }
  
  float getBubblePadding() {
    return chatBorderPad;
  }
  
  void chatListMousePressed() {
    for (Chat c:chats) {
      if (c.getClass().equals(FacemojiChat.class)) ((FacemojiChat)c).mousePressed();
    }
    println("hey!!!");
  }
  
  void setFaceImage(PImage img) {
    displayFace = img;
    faceDisplayMode = true;
  } 
  
  void displayChats(float x) {
    float xPos = x;
    for (Chat c:chats) {
      float appendY;
      if (c.getSide() == 0) {
        float initialX = width - chatStartXPos - chatBorderPad*2 + xPos;
        appendY = c.speechBubbleSelf(initialX, chatStartYPos);
      } else {
        float initialX = chatStartXPos + xPos;
        appendY = c.speechBubbleOpposite(initialX, chatStartYPos);
      }
      chatStartYPos += appendY + chatMargin;
    }
    chatStartYPos = 100;
    if (faceDisplayMode) displayFace();
  }
  
  void setFaceDisplayMode(boolean val) {
    faceDisplayMode = val;
  }
  
  boolean hoverOnEmoji() {
    boolean hovered = false;
    for (Chat c:chats) {
      if (c.getClass().equals(FacemojiChat.class)) {
        hovered = ((FacemojiChat)c).emojiHovered();
        if (hovered) return hovered;
      }
    }
    return hovered;
  }
  
  boolean getDisplayMode() {
    return faceDisplayMode;
  }
  
  void displayFace() {
    fill(240);
    rect(10, 10, width-20, width-20, 30);
    image(displayFace, 20, 20, width-40, width-40);
  }
}