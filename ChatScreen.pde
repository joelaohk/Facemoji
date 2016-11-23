class ChatScreen {
  private float xPos;
  private ControlP5 cp5;
  private PImage contactImg;
  private PImage backButton;
  private PImage keyboard;
  private int keyY;
  private int keyH;
  private boolean keyboardUp = false;

  private ArrayList<Contact> contacts;

  private ChatTopBar topBar;
  private FacemojiPanel panel;
  private FuncBar funcBar;
  private ChatManager manager;
  
  public ChatScreen(PApplet pa) {
    cp5 = new ControlP5(pa);

    backButton = loadImage("back.png");
    contacts = new ArrayList<Contact>();
    prepareContacts();
    topBar = new ChatTopBar();
    
    panel = new FacemojiPanel(pa);
    funcBar = new FuncBar();
    manager = new ChatManager();
    
    keyboard = loadImage("keyboard.jpg");
    keyY = height;
    keyH = 683*width/1242;
  }
    
  public void display(float xPos, int contactIdx) {
    chatTopBar.display(xPos, contacts.get(contactIdx));
    manager.displayChats(xPos);
    image(keyboard,xPos,keyY,width,keyH);
    panel.display(xPos);
    funcBar.display(xPos);
  }
    
  void prepareContacts() {
    JSONArray contactJsonA = loadJSONObject("contact.json").getJSONArray("contact");
    for (int i = 0; i < contactJsonA.size(); i++) {
      Contact c;
      JSONObject contactJsonO = contactJsonA.getJSONObject(i);
      String name = contactJsonO.getString("name");
      PImage profilePic = loadImage("contact/" + contactJsonO.getString("profile_pic"));
      c = new Contact(name, profilePic);
      contacts.add(c);
    }
  }
  
  void controlEvent(ControlEvent theEvent) {
    funcBar.controlEvent(theEvent);
  }
    
  public void mousePressed() {
    if (!manager.hoverOnEmoji() && !manager.getDisplayMode()){
      if (!(funcBar.isUp() && reachPanel())) {
        funcBar.pushDownFuncBar();
        if (keyboardUp) pushDownKeyboard();
        if (panel.isPanelUp()) panel.pushDownPanel();
      }
    }
    panel.mousePressed();
    manager.chatListMousePressed();
  }
  
  void trigger(int value) {
    funcBar.trigger(value);
  }

  public void found(int i) {
    panel.found(i);
  }

  public void mouthWidthReceived(float w) {
    panel.mouthWidthReceived(w);
  }

  public void mouthHeightReceived(float h) {
    panel.mouthHeightReceived(h);
  }

  void oscEvent(OscMessage m) {
    panel.oscEvent(m);
  }

  void raiseUpKeyboard() {
    keyY = height - keyH;
    keyboardUp = true;
  }

  void pushDownKeyboard() {
    keyY = height;
    keyboardUp = false;
  }
  
  ChatTopBar getTopBar() {
    return topBar;
  }
  
  FacemojiPanel getPanel() {
    return panel;
  }
  
  FuncBar getFuncBar() {
    return funcBar;
  }
  
  ChatManager getChatManager() {
    return manager;
  }

  boolean reachPanel() {
    if (mouseY>=height-keyH-funcBar.getHeight() && mouseY<=height) {
      return true;
    } else {
      return false;
    }
  }
}