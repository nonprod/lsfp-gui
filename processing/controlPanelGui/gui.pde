/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:710762:
  println("button1 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button1:710762:

public void imgTogButton1_click1(GImageToggleButton source, GEvent event) { //_CODE_:imgTogButton1:262823:
  println("imgTogButton1 - GImageToggleButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:imgTogButton1:262823:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:400630:
  println("button2 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button2:400630:

public void checkbox1_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkbox1:801168:
  println("checkbox1 - GCheckbox event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:checkbox1:801168:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  button1 = new GButton(this, 558, 261, 80, 30);
  button1.setText("Face text");
  button1.addEventHandler(this, "button1_click1");
  imgTogButton1 = new GImageToggleButton(this, 526, 104);
  imgTogButton1.addEventHandler(this, "imgTogButton1_click1");
  button2 = new GButton(this, 722, 174, 80, 30);
  button2.setText("Face text");
  button2.addEventHandler(this, "button2_click1");
  checkbox1 = new GCheckbox(this, 117, 136, 120, 20);
  checkbox1.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkbox1.setText("checkbox text");
  checkbox1.setOpaque(false);
  checkbox1.addEventHandler(this, "checkbox1_clicked1");
}

// Variable declarations 
// autogenerated do not edit
GButton button1; 
GImageToggleButton imgTogButton1; 
GButton button2; 
GCheckbox checkbox1; 
