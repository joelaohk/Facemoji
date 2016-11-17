

public class Emoji {
  final private static String EMOJIFOLDER = "emoji/";
  
  private String name;
  private String filePath;
  
  public Emoji(String name, String filename) {
    this.name = name;
    this.filePath = EMOJIFOLDER + filename + ".png";
  }
  
  public String getName() {
    return name;
  }
  
  public String getPath() {
    return filePath;
  }
  
}