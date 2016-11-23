class TextInput extends Textfield {
  public TextInput(ControlP5 cp5, String name) {
    super(cp5, name);
  }
  
  @Override
  void onClick() {
    if (!screen1.getFuncBar().isUp()) {
      screen1.getFuncBar().raiseUpFuncBar();
      screen1.raiseUpKeyboard();
    } else {
      if (!screen1.keyboardUp) {
        screen1.getPanel.pushDownPanel();
        screen1.raiseUpKeyboard();
      }
    }
  }
  
}