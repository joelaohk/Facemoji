

public class Emoji {
  final private static String EMOJIFOLDER = "emoji/";
  
  private String name;
  private String filePath;
  
  public Emoji(String name, String filename) {
    this.name = name;
    this.filePath = EMOJIFOLDER + filename;
  }
  
  public String getEName() {
    return name;
  }
  
  public String getPath() {
    return filePath;
  }
  
}