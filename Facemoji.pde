import controlP5.*;
//import com.temboo.core.*;
import java.util.*;

ControlP5 cp5;
PImage keyboard;
Textfield draft;
Button facemojiTrigger;
ArrayList<Chat> chats;
int keyY;
int keyH;
int funcBarY;
int funcBarH;
int chatStartXPos = 10;
int chatStartYPos = 100;
final int chatTextSize = 15;
final int chatBorderPad = 10;
final int chatMargin = 10;

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
     .setLabelVisible(false);
  draft = cp5.get(Textfield.class, "draft");
  
  facemojiTrigger = cp5.addButton("trigger")
                       .setPosition(7 + width*2/3 + 30,height-7-28)
                       .setImage(loadImage("icon.png"))
                       .setSize(26,28);
  
  loadChatData();
  
  keyboard = loadImage("keyboard.jpg");
  keyY = height;
  keyH = 683*width/1242;
  funcBarH = 42;
  funcBarY = height-funcBarH;
}


void draw() {
  background(220);
  chatTopBar("Bart", "contact/bart.png");
  displayChats();
  image(keyboard,0,keyY,width,keyH);
  funcBar();
}

void chatTopBar(String contact, String contactImgPath) {
  fill(240);
  rect(0,0,width,90);
  textSize(32);
  textAlign(CENTER);
  fill(50);
  text(contact,width/2,45+15);
  image(loadImage("back.png"), 15, 15, 60, 60);
  image(loadImage(contactImgPath), width-75, 15, 60, 60);
}

void speechBubbleSelf(String content) {
  textSize(chatTextSize);
  
  noStroke();
  fill(255);
  float chatfinalXPos = width - chatStartXPos - textWidth(content) - chatBorderPad*2;
  float chatfinalWidth = textWidth(content) + chatBorderPad*2;
  float chatfinalHeight = chatTextSize + chatBorderPad*2;
  rect(chatfinalXPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 3, 30);
  
  textAlign(LEFT);
  fill(0);
  text(content, width - chatStartXPos - textWidth(content) - chatBorderPad, chatStartYPos + chatTextSize + chatBorderPad);
  
  chatStartYPos += chatfinalHeight + chatMargin;
}

void speechBubbleOpposite(String content) {
  textSize(chatTextSize);
  
  noStroke();
  fill(#00bfff);
  float chatfinalWidth = textWidth(content) + chatBorderPad*2;
  float chatfinalHeight = chatTextSize + chatBorderPad*2;
  rect(chatStartXPos, chatStartYPos, chatfinalWidth, chatfinalHeight, 30, 30, 30, 3);
  
  textAlign(LEFT);
  fill(255);
  text(content, chatStartXPos + chatBorderPad, chatStartYPos + chatTextSize + chatBorderPad);
  
  chatStartYPos += chatfinalHeight + chatMargin;
}

void displayChats() {
  for (Chat c:chats) {
    if (c.getSide() == 0) {
      speechBubbleSelf(c.getMsg());
    } else {
      speechBubbleOpposite(c.getMsg());
    }
  }
  chatStartYPos = 100;
}

void funcBar() {
  fill(255);
  noStroke();
  rect(0,funcBarY,width,funcBarH);
}

void mousePressed() {
  if (draft.isFocus()) {
    draft.setPosition(7,height-keyH-7-28).setFocus(true);
    keyY = height-keyH;
    funcBarY = height-keyH-funcBarH;
  } else if (!draft.isFocus()) {
    if (keyboardTyped()) {
      draft.setFocus(true);
      return;
    }
    draft.setPosition(7,height-7-28).setFocus(false);
    keyY = height;
    funcBarY = height-funcBarH;
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
}

boolean keyboardTyped() {
  if (mouseY>=height-keyH-funcBarH && mouseY<=height) {
    draft.setFocus(true);
    return true;
  } else {
    return false;
  }
}