class TextInput extends Textfield {
  public TextInput(ControlP5 cp5, String name) {
    super(cp5, name);
  }
  
  @Override
  void onClick() {
    if (!funcBar.isUp()) {
      funcBar.raiseUpFuncBar();
      raiseUpKeyboard();
    } else {
      if (!keyboardUp) {
        panel.pushDownPanel();
        raiseUpKeyboard();
      }
    }
  }
  
}