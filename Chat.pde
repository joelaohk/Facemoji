
abstract class Chat {
  private int side;
  
  public Chat(int side) {
    this.side = side;
    this.message = msg;
  }
  
  public int getSide() {
    return side;
  }
  
  public abstract chatBubbleOpposite(float initialX, float yPos);
  public abstract chatBubbleSelf(float initialX, float yPos);
}