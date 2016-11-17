

class Chat {
  private String message;
  private int side;
  private PImage emoji;
  
  public Chat(int side, String msg, String pathToEmoji) {
    this.side = side;
    this.message = msg;
    this.emoji = loadImage(pathToEmoji);
  }
  
}