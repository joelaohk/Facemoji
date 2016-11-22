class ChatManager {
  private ArrayList<Chat> chats;
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
  
  void displayChats(int x) {
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
      chatStartYPos += appendY;
    }
    chatStartYPos = 100;
  }
}