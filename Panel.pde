class FacemojiPanel {
  private Capture cam;
  private int camX, camY;
  private int camH;
  private boolean panelUp = false;
  
  public FacemojiPanel(PApplet pa, int x) {
    cam = new Capture(pa, 320, 240);
    cam.start();
    camX = x;
    camY = height;
    camH = 683*width/1242;
  }
  
  public void display() {
    pushMatrix();
    fill(140);
    rect(camX,camY,width,camH);
    if (cam.available()==true) cam.read();
    PImage cropped = cam.get((320-camH)/2,0,camH,camH);
    image(cropped, camX, camY);
    popMatrix();
  }
  
  void raiseUpPanel() {
    camY = height - camH;
    funcBar.turnOnTrigger();
    panelUp = true;
  }
  
  void pushDownPanel() {
    camY = height;
    funcBar.turnOffTrigger();
    panelUp = false;
  }
  
  boolean isPanelUp() {
    return panelUp;
  }
}