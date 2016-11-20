





class Chat {
  private int side;
  private String message;
  private Emoji emoji;
  
  public Chat(int side, String msg, String emojiName) {
    this.side = side;
    this.message = msg;
    this.emoji = new Emoji(emojiName);
  }
  
  public int getSide() {
    return side;
  }
  
  public String getMsg() {
    return message;
  }
  
  public Emoji getEmoji() {
    return emoji;
  }
}