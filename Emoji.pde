

public class Emoji {
  final private static String EMOJIFOLDER = "emoji/";
  
  private String name;
  private String filePath;
  
  public Emoji(String name) {
    this.name = name;
    this.filePath = EMOJIFOLDER + name + ".png";
  }
  
  public String getEName() {
    return name;
  }
  
  public String getPath() {
    return filePath;
  }
  
}