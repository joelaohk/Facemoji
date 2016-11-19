class EmojiFace extends Emoji {
  private PImage image;
  
  public EmojiFace(String name, PImage img) {
    super(name);
    image = img;
  }
  
  public PImage getFaceImg() {
    return image;
  }
}