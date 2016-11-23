class Contact {
  private String name;
  private PImage profilePic;
  
  public Contact(String _name, PImage _profilePic) {
    name = _name;
    profilePic = _profilePic;
  }
  
  public String getName() {
    return name;
  }
  
  public PImage getProfilePic() {
    return profilePic;
  }

}