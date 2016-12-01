class FacemojiPanel {
  private Capture cam;
  private OpenCV opencv;
  private OscP5 oscp5;
  private float camX, camY;
  private int camW, camH;
  private boolean panelUp = false;
  private ArrayList<Emoji> emojis;
  private ArrayList<PImage> related;
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
  float relatedXPos, relatedWidth;
  PImage emoji_img;
  PImage cropped;
  
  public FacemojiPanel(PApplet pa) {
    cam = new Capture(pa, 320, 240);
    cam.start();
    camY = height;
    camW = 280;
    camH = 683*width/1242;
    emojis = new ArrayList<Emoji>();
    related = new ArrayList<PImage>();
    
    opencv = new OpenCV(pa, camW, camH);
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
    cropped = cam.get((320-camW)/2,0,camW,camH);
    image(cropped, camX, camY);
    opencv.loadImage(cropped);
    faces = opencv.detect();
    
    relatedWidth = width - camW;
    relatedXPos = camX + camW;
    imageMode(CENTER);
    for (int i = 0; i < 8 && i < related.size(); i++) {
      float xPos, yPos;
      if (i%2 == 0) {
        xPos = relatedXPos + relatedWidth * 1/4;
        yPos = camY + camH * ((i/2.0 + 1)/5.0);
        image(related.get(i),xPos, yPos, emojiLength, emojiLength);
      } else {
        xPos = relatedXPos + relatedWidth * 3/4;
        yPos = camY + camH * (ceil(i/2.0)/5.0);
        image(related.get(i),xPos, yPos, emojiLength, emojiLength);
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
      JSONObject emojiJson = emojiJsonA.getJSONObject(i);
      PImage first = loadImage("emoji/" + emojiJson.getString("first"));
      JSONArray emojiA = emojiJson.getJSONArray("related");
      ArrayList<PImage> related = new ArrayList<PImage>();
      for (int j = 0; j < emojiA.size(); j++) {
        PImage r = loadImage("emoji/" + emojiA.getString(j));
        related.add(r);
      }
      Emoji e = new Emoji(first, related);
      emojis.add(e);
    }
  }
  
  void placeEmojiOnFace() {
    if(found > 0) {
      if (mouthWidth/mouthHeight>1.3 && mouthWidth/mouthHeight< 1.9)
      {
        if (emoji==1)
          time++;
        else
          time=0;
          
        emoji=1;
        //println("emoji: "+emoji);
        //println("time: "+time);
      }
      else if (mouthWidth/mouthHeight>3.8 && mouthWidth/mouthHeight<6.3)
      {
        if (emoji==2)
          time++;
        else
          time=0;
   
        emoji=2;
        println("emoji: "+emoji);
        println("time: "+time);    
      }
      else if (mouthWidth/mouthHeight>11 && mouthWidth/mouthHeight<15)
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
        if (emoji==0)
          time++;
        else
          time=0;
         
        emoji=0;
        println("emoji: "+emoji);
        println("time: "+time);
      }
    }
    if (time >= 8) {
        
      if (faces.length>0 && emoji != 0) {
        try {
          emoji_img = emojis.get(emoji).first;
          image(emoji_img, camX + faces[0].x, camY + faces[0].y,faces[0].width,faces[0].height);
          related = emojis.get(emoji).related;
          
        } catch (NullPointerException e) {println ("no dude");}
        
      } else if (emoji == 0) {
        pushMatrix();
        println("hey!!");
        fill(#CC0000);
        rect(camX, camY, camW, 30);
        textSize(20);
        fill(255);
        textAlign(CENTER);
        text("No emoji found", camX, camY+2, camW, 30);
        textAlign(LEFT);
        popMatrix();
        
        related = new ArrayList<PImage>();
      }
    }
  }
  
  void mousePressed() {
    if (panelUp) {
      if(faces.length>0 && emoji != 0) {
        if (withinCamArea()) {
          float dx = mouseX - (camX + faces[0].x);
          float dy = mouseY - (camY + faces[0].y);
          if (dx > 0 && dx < faces[0].width && dy > 0 && dy < faces[0].height) {
            PImage cropSave = cropped.get((camW-camH)/2,0,camH,camH);
            Chat c = new FacemojiChat(0, emoji_img, cropSave);
            chatScreen.getChatManager().addChat(c);
          }
        } else if (withinRelatedArea()) {
          for (int i = 0; i < related.size(); i++) {
            float xPos, yPos;
            if (i%2 == 0) {
              xPos = relatedXPos + relatedWidth * 1/4;
              yPos = camY + camH * ((i/2.0 + 1)/5.0);
            } else {
              xPos = relatedXPos + relatedWidth * 3/4;
              yPos = camY + camH * (ceil(i/2.0)/5.0);
            }
            float dx = mouseX - xPos;
            float dy = mouseY - yPos;
            if (dx > -emojiLength/2 && dx < emojiLength/2 && dy > -emojiLength/2 && dy < emojiLength/2) {
              PImage cropSave = cropped.get((camW-camH)/2,0,camH,camH);
              Chat c = new FacemojiChat(0, related.get(i), cropSave);
              chatScreen.getChatManager().addChat(c);
            }
          }
        }
        
      }
    }
    
  }
  
  boolean withinCamArea() {
    float dx = mouseX - camX;
    float dy = mouseY - camY;
    if (dx > 0 && dx < camW && dy > 0 && dy < camH) return true;
    else return false;
  }
  
  boolean withinRelatedArea() {
    float dx = mouseX - relatedXPos;
    float dy = mouseY - (camY);
    if (dx > 0 && dx < relatedWidth && dy > 0 && dy < camH) return true;
    else return false;
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