import controlP5.*;
//import com.temboo.core.*;
import java.util.*;

ControlP5 cp5;
Textlabel t2;
PImage keyboard;
Textfield draft;
Button facemojiTrigger;
JSONArray emojis;
ArrayList<Emoji> emojiList;
int keyY;
int keyH;
int funcBarY;
int funcBarH;

void settings() {
  size(405,720);
}

void setup() {
  
  cp5 = new ControlP5(this);
  speechOppSet();
  
  cp5.addTextfield("draft")
     .setPosition(7,height-7-28)
     .setColor(0)
     .setColorBackground(232232232) 
     .setSize(width*2/3,28)
     .setFocus(false)
     .setFont(createFont("arial",15))
     .setLabelVisible(false);
     
  prepareEmojiData();
  draft = cp5.get(Textfield.class, "draft");
  
  facemojiTrigger = cp5.addButton("trigger")
                       .setPosition(7 + width*2/3 + 30,height-7-28)
                       .setImage(loadImage("icon.png"))
                       .setSize(26,28);
  
  keyboard = loadImage("keyboard.jpg");
  keyY = height;
  keyH = 683*width/1242;
  funcBarH = 42;
  funcBarY = height-funcBarH;
}


void draw() {
  background(244);
  speechBubbleOpposite("What\'s up dud?");
  speechBubbleSelf("Gay!!!");
  image(keyboard,0,keyY,width,keyH);
  funcBar();
}

void speechOppSet() {
  t2 = cp5.addTextlabel("opposite")
          .setFont(createFont("Arial",20))
          .setPosition(24, 26)
          .setColorValue(255);
}

void speechBubbleSelf(String content) {
  cp5.addTextlabel("self")
     .setFont(createFont("Arial",20))
     .setPosition(width-24, 35)
     .setColorValue(#00bfff)
     .setText(content)
     .setWidth(70);
  noStroke();
  fill(255);
  rect(width - 16 - t2.getWidth()+20, 20 + t2.getHeight()+16 + 9, t2.getWidth()+20, t2.getHeight()+16, 30, 30, 3, 30);
}

void speechBubbleOpposite(String content) {
  t2.setText(content);
  
  noStroke();
  fill(#00bfff);
  rect(16, 20, t2.getWidth()+20, t2.getHeight()+16, 30, 30, 30, 3);
  t2.draw(this);
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

void prepareEmojiData() {
  emojis = loadJSONObject("emoji.json").getJSONArray("emoji");
  emojiList = new ArrayList<Emoji>();
  for (int i = 0; i < emojis.size(); i++) {
    JSONObject emoji = emojis.getJSONObject(i);
    String eName = emoji.getString("name");
    String eFilename = emoji.getString("filename");
    Emoji e = new Emoji(eName, eFilename);
    emojiList.add(e);
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