import controlP5.*;
//import com.temboo.core.*;
import java.util.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.*;
import oscP5.*;

int currScreen;
ChatScreen chatScreen;
ControlP5 cp5;

void settings() {
  size(405,720);
}

void setup() {
  cp5 = new ControlP5(this);
  currScreen = 1;
  chatScreen = new ChatScreen(this);
  
}


void draw() {
  background(220);
  chatScreen.display(0,0);
}

void controlEvent(ControlEvent theEvent) {
  if (currScreen == 1) chatScreen.getFuncBar().controlEvent(theEvent);
}

void mousePressed() {
  if (currScreen == 1) chatScreen.mousePressed();
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