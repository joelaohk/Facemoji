class FacemojiPanel {
  private Capture cam;
  private OpenCV opencv;
  private OscP5 oscp5;
  private float camX, camY;
  private int camH;
  private boolean panelUp = false;
  private ArrayList<PImage> recents;
  private float emojiLength = 45;
  private Rectangle[] faces;
  
  // num faces found
  int found;
  
  // pose
  float poseScale;
  PVector posePosition = new PVector();
  PVector poseOrientation = new PVector();
  
  // gesture
  float mouthHeight;
  float mouthWidth;
  float eyeLeft;
  float eyeRight;
  float eyebrowLeft;
  float eyebrowRight;
  float jaw;
  float nostrils;
  
  //for emoji
  int emoji=0;
  int max=0;
  int time=0;
  int emoji_chosen=0;
  PImage emoji_img;
  PImage cropped;
  
  public FacemojiPanel(PApplet pa) {
    cam = new Capture(pa, 320, 240);
    cam.start();
    camY = height;
    camH = 683*width/1242;
    recents = new ArrayList<PImage>();
    
    opencv = new OpenCV(pa, camH, camH);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    
    oscp5 = new OscP5(this, 8338);
    oscp5.plug(this, "found", "/found");
    oscp5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
    oscp5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
    
    loadEmojisData();
  }
  
  public void display(float x) {
    camX = x;
    pushMatrix();
    fill(140);
    rect(camX,camY,width,camH);
    if (cam.available()==true) cam.read();
    cropped = cam.get((320-camH)/2,0,camH,camH);
    image(cropped, camX, camY);
    opencv.loadImage(cropped);
    faces = opencv.detect();
    
    float recentWidth = width - camH;
    float recentXPos = camX + camH;
    imageMode(CENTER);
    for (int i = 0; i < 8; i++) {
      float xPos, yPos;
      if (i%2 == 0) {
        xPos = recentXPos + recentWidth * 1/4;
        yPos = camY + camH * ((i/2.0 + 1)/5.0);
        image(recents.get(i),xPos, yPos, emojiLength, emojiLength);
      } else {
        xPos = recentXPos + recentWidth * 3/4;
        yPos = camY + camH * (ceil(i/2.0)/5.0);
        image(recents.get(i),xPos, yPos, emojiLength, emojiLength);
      }
    }
    imageMode(CORNER);
    placeEmojiOnFace();
    popMatrix();
    
  }
  
  void raiseUpPanel() {
    camY = height - camH;
    chatScreen.getFuncBar().turnOnTrigger();
    panelUp = true;
  }
  
  void pushDownPanel() {
    camY = height;
    chatScreen.getFuncBar().turnOffTrigger();
    panelUp = false;
  }
  
  void loadEmojisData() {
    JSONArray emojiJsonA = loadJSONObject("emoji.json").getJSONArray("emoji");
    for (int i = 0; i < emojiJsonA.size(); i++) {
      String filename = emojiJsonA.getString(i);
      PImage emoji = loadImage("emoji/" + filename);
      recents.add(emoji);
    }
  }
  
  void placeEmojiOnFace() {
    if(found > 0) {
      if (mouthWidth/mouthHeight>0.9 && mouthWidth/mouthHeight<3)
      {
        if (emoji==1)
          time++;
        else
          time=0;
          
        emoji=1;
        //println("emoji: "+emoji);
        //println("time: "+time);
      }
      else if (mouthWidth/mouthHeight>3 && mouthWidth/mouthHeight<8)
      {
        if (emoji==2)
          time++;
        else
          time=0;
   
        emoji=2;
        println("emoji: "+emoji);
        println("time: "+time);    
      }
      else if (mouthWidth/mouthHeight>8 && mouthWidth/mouthHeight<16)
      {
        if (emoji==3)
          time++;
        else
          time=0;
         
        emoji=3;
        println("emoji: "+emoji);
        println("time: "+time);
      }
      else
      {
        time=0; 
        emoji=0;
        println("emoji: "+emoji);
        println("time: "+time);
      }
    }
    if (time >= 8) {
      if (emoji==1) 
        emoji_img = loadImage("emoji/scream.png");
      else if (emoji==2)
        emoji_img = loadImage("emoji/grin.png");
      else if (emoji==3) 
        emoji_img = loadImage("emoji/bored.png");
        
      if (faces.length>0) {
        try {
          image(emoji_img, camX + faces[0].x, camY + faces[0].y,faces[0].width,faces[0].height);
        } catch (NullPointerException e) {}
        
      }
      
      
    }
  }
  
  void mousePressed() {
    if (panelUp) {
      if(faces.length>0) {
        float dx = mouseX - camX + faces[0].x;
        float dy = mouseY - camY + faces[0].y;
        if (dx > 0 && dx < faces[0].width && dy > 0 && dy < faces[0].height) {
          Chat c = new FacemojiChat(0, emoji_img, cropped);
          manager.addChat(c);
        }
      }
    }
    
  }
  
  // OSC CALLBACK FUNCTIONS
  public void found(int i) {
    //println("found: " + i);
    found = i;
  }
  
  
  public void mouthWidthReceived(float w) {
    //println("mouth Width: " + w);
    mouthWidth = w;
  }
  
  public void mouthHeightReceived(float h) {
    //println("mouth height: " + h);
    mouthHeight = h;
  }
  
  // all other OSC messages end up here
  void oscEvent(OscMessage m) {
    if(m.isPlugged() == false) {
      //println("UNPLUGGED: " + m);
    }
  }
  
  boolean isPanelUp() {
    return panelUp;
  }
}