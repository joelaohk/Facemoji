class ContactScreen {
  PImage chat1, chat2, chat3, setting;

  PFont font;
  String title;
  
  float xPos;
  
  public ContactScreen(){
    chat1 = loadImage("chat1.jpg"); 
    chat2 = loadImage("chat2.jpg"); 
    chat3 = loadImage("chat3.jpg"); 
    setting = loadImage("setting.jpg");
  }
  
  void display(float x){
    xPos = x;
    pushMatrix();
    fill(0, 102, 204);
    rect(0 , 0 , 405, 100);
    font = createFont("Arial", 40);
    title = "Chats         +";
    
    image(chat1, 0, 105);
    image(chat2, 0, 210);
    image(chat3, 0, 315);
    image(setting, 0, 620);
    
    fill(255, 255, 255);
    textFont(font);
    textSize(40);
    text(title, 150, 65);
    popMatrix();
  }
  
  void mousePressed(){
    if(mouseY>105 && mouseY<210){
      setCurrContact(0);
      setCurrScreen(1);
    }
    if(mouseY>210 && mouseY<315){
      setCurrContact(1);
      setCurrScreen(1);
    }
    if(mouseY>315 && mouseY<420){
      setCurrContact(2);
      setCurrScreen(1);
    }
  }
}