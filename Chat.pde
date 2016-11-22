
abstract class Chat {
  private int side;
  
  public Chat(int side) {
    this.side = side;
  }
  
  public int getSide() {
    return side;
  }
  
  public abstract float speechBubbleOpposite(float initialX, float yPos);
  public abstract float speechBubbleSelf(float initialX, float yPos);
}