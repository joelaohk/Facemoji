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


FacemojiPanel panel;
FuncBar funcBar;
ChatManager manager;
OpenCV opencv;
OscP5 oscP5;

void settings() {
  size(405,720);
}

void setup() {
  
  cp5 = new ControlP5(this);
  
  backButton = loadImage("back.png");
  contactImg = loadImage("contact/bart.png");
  
  panel = new FacemojiPanel(this, 0);
  funcBar = new FuncBar(0);
  manager = new ChatManager();
  manager.loadChatData();
  
  keyboard = loadImage("keyboard.jpg");
  keyY = height;
  keyH = 683*width/1242;
}


void draw() {
  background(220);
  chatTopBar("Bart");
  manager.displayChats(0);
  image(keyboard,0,keyY,width,keyH);
  panel.display();
  funcBar.display();
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
  if(theEvent.isAssignableFrom(TextInput.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
    Chat c = new Chat(0, draft.getText());
    manager.addChat(c);
  }
  
  
}

void mousePressed() {
  if (!(funcBar.isUp() && reachPanel())) {
    funcBar.pushDownFuncBar();
    if (keyboardUp) pushDownKeyboard();
    if (panel.isPanelUp()) panel.pushDownPanel();
  }
}

void trigger(int value) {
  println(value);
  if (!funcBar.isUp()) {
    funcBar.raiseUpFuncBar();
    panel.raiseUpPanel();
  } else {
    if (!panel.isPanelUp()) {
      pushDownKeyboard();
      panel.raiseUpPanel();
    } else {
      panel.pushDownPanel();
      raiseUpKeyboard();
    }
  }
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