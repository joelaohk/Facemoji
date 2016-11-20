import controlP5.*;
//import com.temboo.core.*;
import java.util.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.*;
import oscP5.*;

ControlP5 cp5;
PImage contactImg;
PImage backButton;
PImage keyboard;
Textfield draft;
controlP5.Button facemojiTrigger;
boolean buttonTriggered = false;
ArrayList<Chat> chats;
Capture cam;
int camY;
int keyY;
int keyH;
int funcBarY;
int funcBarH;
boolean funcBarUp = false;
int chatStartXPos = 10;
int chatStartYPos = 100;
final int chatTextSize = 15;
final int chatBorderPad = 10;
final int chatMargin = 10;

OpenCV opencv;
OscP5 oscP5;

void settings() {
  size(405,720);
}

void setup() {
  chats = new ArrayList<Chat>();
  
  cp5 = new ControlP5(this);
  cp5.addTextfield("draft")
     .setPosition(7,height-7-28)
     .setColor(0)
     .setColorBackground(#FAFAFA)
     .setSize(width*2/3,28)
     .setFocus(false)
     .setFont(createFont("arial",15))
     .setLabelVisible(true);
  draft = cp5.get(Textfield.class, "draft");
  
  PImage icon = loadImage("icon.png");
  icon.resize(26,28);
  facemojiTrigger = cp5.addButton("trigger")
                       //.setPosition(7 + width*2/3 + 30,height-7-28)
                       .setPosition(7 + width*2/3 + 30,height-7-28)
                       .setImage(icon)
                       .setSize(26,28)
                       .setValue(0);
  backButton = loadImage("back.png");
  contactImg = loadImage("contact/bart.png");
  
  cam = new Capture(this, 320, 240);
  cam.start();
  
  loadChatData();
  
  keyboard = loadImage("keyboard.jpg");
  keyY = camY = height;
  keyH = 683*width/1242;
  funcBarH = 42;
  funcBarY = height-funcBarH;
}


void draw() {
  background(220);
  chatTopBar("Bart");
  displayChats();
  image(keyboard,0,keyY,width,keyH);
  if (buttonTriggered) {
    fill(140);
    rect(0,keyY,width,keyH);
    if (cam.available()==true) cam.read();
    pushMatrix();
    PImage cropped = cam.get((320-keyH)/2,0,keyH,keyH);
    image(cropped, 0, camY);
    popMatrix();
  }
  
  funcBar();
}

void chatTopBar(String contact) {
  fill(240);
  rect(0,0,width,90);
  textSize(32);
  textAlign(CENTER);
  fill(50);
  text(contact,width/2,45+15);
  image(backButton, 15, 15, 60, 60);
  image(contactImg, width-75, 15, 60, 60);
}

void speechBubbleSelf(String content, int index) {
  textSize(chatTextSize);
  
  //Textarea ta = cp5.addTextarea(str(index))
  //                 .setWidth(200)
  //                 .setFont(createFont("arial",chatTextSize))
  //                 .setColor(0)
  //                 .setLineHeight(chatTextSize+2)
  //                 .setText(content);
                   
  float wid = min(200,textWidth(content));
  float hei = chatTextSize;
  if (wid == 200) {
    int scaleFact = ceil(textWidth(content)/200);
    hei *= scaleFact;
    hei += 10*(scaleFact-1);
  }
  //ta.setPosition(width - chatStartXPos - wid - chatBorderPad, chatStartYPos + chatBorderPad);
  noStroke();
  fill(255);
  float chatfinalXPos = width - chatStartXPos - wid - chatBorderPad*2;
  float chatfinalWidth = wid + chatBorderPad*2;
  float chatfinalHeight = hei + chatBorderPad*2;
  rect(chatfinalXPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 3, 30);
  textAlign(LEFT);
  fill(0);
  text(content, width - chatStartXPos - wid - chatBorderPad, chatStartYPos + chatBorderPad, wid+10, hei+15);
  
  chatStartYPos += chatfinalHeight + chatMargin;
}

void speechBubbleOpposite(String content, int index) {
  textSize(chatTextSize);
  
  //Textarea ta = cp5.addTextarea(str(index))
  //                 .setWidth(200)
  //                 .setFont(createFont("arial",chatTextSize))
  //                 .setColor(255)
  //                 .setLineHeight(chatTextSize+2)
  //                 .setText(content);
  
  float wid = min(200,textWidth(content));
  float hei = chatTextSize;
  if (wid == 200) {
    int scaleFact = ceil(textWidth(content)/200);
    hei *= scaleFact;
    hei += 10*(scaleFact-1);
  }
  //ta.setPosition(chatStartXPos + chatBorderPad, chatStartYPos + chatBorderPad);
  
  noStroke();
  fill(#00bfff);
  float chatfinalWidth = wid + chatBorderPad*2;
  float chatfinalHeight = hei + chatBorderPad*2;
  rect(chatStartXPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 30, 3);
  
  textAlign(LEFT);
  fill(255);
  text(content, chatStartXPos + chatBorderPad, chatStartYPos + chatBorderPad, wid+10, hei+15);
  
  chatStartYPos += chatfinalHeight + chatMargin;
}

void displayChats() {
  int idx = 0;
  for (Chat c:chats) {
    if (c.getSide() == 0) {
      speechBubbleSelf(c.getMsg(), idx);
    } else {
      speechBubbleOpposite(c.getMsg(), idx);
    }
    idx++;
  }
  chatStartYPos = 100;
}

void funcBar() {
  fill(255);
  noStroke();
  rect(0,funcBarY,width,funcBarH);
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
            
    Chat c = new Chat(0, draft.getText(), "");
    chats.add(c);
  }
  
  
}

void mousePressed() {
  if (draft.isFocus()) {
    //facemojiTrigger.setValue(0);
    keyY = height-keyH;
    raiseUpFuncBar();
  } else if (!draft.isFocus()) {
    if (funcBarUp == true) {
      return;
    }
    
    if (keyboardTyped()) {
      draft.setFocus(true);
      return;
    }
    buttonTriggered = false;
    keyY = height;
    pushdownFuncBar();
  }
}

void loadChatData() {
  JSONArray chatJsonA = loadJSONObject("chat.json").getJSONArray("chat");
  for (int i = 0; i < chatJsonA.size(); i++) {
    JSONObject chatJsonO = chatJsonA.getJSONObject(i);
    int side = chatJsonO.getInt("side");
    String msg = chatJsonO.getString("msg");
    String emoji = chatJsonO.getString("emoji");
    Chat chat = new Chat(side, msg, emoji);
    chats.add(chat);
  }
  displayChats();
}

void trigger(int value) {
  if (!buttonTriggered) {
    raiseUpFuncBar();
    keyY = height;
    camY = height-keyH;
    buttonTriggered = true;
  } else {
    pushdownFuncBar();
    buttonTriggered = false;
  }
}

void raiseUpFuncBar() {
  draft.setPosition(7,height-keyH-7-28);
  facemojiTrigger.setPosition(7 + width*2/3 + 30,height-7-28-keyH);
  funcBarY = height-keyH-funcBarH;
  funcBarUp = true;
}

void pushdownFuncBar() {
  draft.setPosition(7,height-7-28);
  facemojiTrigger.setPosition(7 + width*2/3 + 30,height-7-28);
  funcBarY = height-funcBarH;
  funcBarUp = false;
}

boolean keyboardTyped() {
  if (mouseY>=height-keyH-funcBarH && mouseY<=height) {
    draft.setFocus(true);
    return true;
  } else {
    return false;
  }
}