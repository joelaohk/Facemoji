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
TextInput draft;
controlP5.Button facemojiTrigger;
int keyY;
int keyH;
boolean keyboardUp = false;

boolean faceDisplayMode = false;

FacemojiPanel panel;
FuncBar funcBar;
ChatManager manager;

void settings() {
  size(405,720);
}

void setup() {
  
  cp5 = new ControlP5(this);
  
  backButton = loadImage("back.png");
  contactImg = loadImage("contact/bart.png");
  
  panel = new FacemojiPanel(this);
  funcBar = new FuncBar();
  manager = new ChatManager();
  
  keyboard = loadImage("keyboard.jpg");
  keyY = height;
  keyH = 683*width/1242;
}


void draw() {
  background(220);
  chatTopBar("Bart");
  manager.displayChats(0);
  image(keyboard,0,keyY,width,keyH);
  panel.display(0);
  funcBar.display(0);
}

void chatTopBar(String contact) {
  pushMatrix();
  fill(240);
  rect(0,0,width,90);
  textSize(32);
  textAlign(CENTER);
  fill(50);
  text(contact,width/2,45+15);
  image(backButton, 15, 15, 60, 60);
  image(contactImg, width-75, 15, 60, 60);
  popMatrix();
}

void controlEvent(ControlEvent theEvent) {
  funcBar.controlEvent(theEvent);
}

void mousePressed() {
  if (!manager.hoverOnEmoji() && !manager.getDisplayMode()){
    if (!(funcBar.isUp() && reachPanel())) {
      funcBar.pushDownFuncBar();
      if (keyboardUp) pushDownKeyboard();
      if (panel.isPanelUp()) panel.pushDownPanel();
    }
  }
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

boolean reachPanel() {
  if (mouseY>=height-keyH-funcBar.getHeight() && mouseY<=height) {
    return true;
  } else {
    return false;
  }
}