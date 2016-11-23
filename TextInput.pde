class TextInput extends Textfield {
  public TextInput(ControlP5 cp5, String name) {
    super(cp5, name);
  }
  
  @Override
  void onClick() {
    if (!chatScreen.getFuncBar().isUp()) {
      chatScreen.getFuncBar().raiseUpFuncBar();
      chatScreen.raiseUpKeyboard();
    } else {
      if (!chatScreen.keyboardUp) {
        chatScreen.getPanel().pushDownPanel();
        chatScreen.raiseUpKeyboard();
      }
    }
  }
  
}