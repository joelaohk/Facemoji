import controlP5.*;
//import com.temboo.core.*;
import java.util.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.*;
import oscP5.*;

int currScreen;
int currContact;

float chatScreenXPos;
float easing = 0.35;

ContactScreen contactScreen;
ChatScreen chatScreen;
ControlP5 cp5;

void settings() {
  size(405,720);
}

void setup() {
  cp5 = new ControlP5(this);
  currScreen = 0;
  currContact = 0;
  chatScreenXPos = width;
  contactScreen = new ContactScreen();
  chatScreen = new ChatScreen(this);
  
}


void draw() {
  smooth();
  background(220);
  contactScreen.display(0);
  chatScreen.display(chatScreenXPos,currContact);
  if (currScreen == 0) chatScreenSlideOut();
  if (currScreen == 1) chatScreenSlideIn();
}

void controlEvent(ControlEvent theEvent) {
  if (currScreen == 1) chatScreen.getFuncBar().controlEvent(theEvent);
}

void mousePressed() {
  if (currScreen == 0) contactScreen.mousePressed();
  if (currScreen == 1) chatScreen.mousePressed();
}

void setCurrScreen(int i) {
  currScreen = i;
}

void setCurrContact(int i) {
  currContact = i;
}

void chatScreenSlideIn() {
  if (chatScreenXPos > 0) {
    float dx = chatScreenXPos - 0;
    chatScreenXPos -= dx*easing;
  }
}

void chatScreenSlideOut() {
  if (chatScreenXPos < width) {
    float dx = width - chatScreenXPos;
    chatScreenXPos += dx*easing;
  }
}

void trigger(int value) {
  if (currScreen == 1) chatScreen.trigger(value);
}

public void found(int i) {
  if (currScreen == 1) chatScreen.found(i);
}

public void mouthWidthReceived(float w) {
  if (currScreen == 1) chatScreen.mouthWidthReceived(w);
}

public void mouthHeightReceived(float h) {
  if (currScreen == 1) chatScreen.mouthHeightReceived(h);
}

void oscEvent(OscMessage m) {
  if (currScreen == 1) chatScreen.oscEvent(m);
}