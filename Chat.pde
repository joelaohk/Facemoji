
class Chat {
  private int side;
  private String message;
  
  public Chat(int side, String msg) {
    this.side = side;
    this.message = msg;
  }
  
  public int getSide() {
    return side;
  }
  
  public String getMsg() {
    return message;
  }
}