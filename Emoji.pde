enum Emoji {
  final private static String EMOJIFOLDER = "emoji/";
  
  private static final SMILE = new Emoji("");
  
  private String filePath;
  
  private Emoji(String filename) {
    filePath = EMOJIFOLDER + filename + ".png";
  }
  
  private String getPath() {
    return filePath;
  }
  
}