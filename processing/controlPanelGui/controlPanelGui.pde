import g4p_controls.*;
import processing.serial.*; 
 
int lf = 10;      // ASCII linefeed

boolean mouseOverBox = false;
boolean runToggle = true;
boolean directionToggle = true;
String enteredText;
GTabManager tt;

GTextField sysMsg;
GTextField txf1;
GTextField txf2;
GTextField txf3;
GTextField txf4;

GImageToggleButton imgTogButton11;
GImageToggleButton imgTogButton12;

// text labels
GLabel label11;
GLabel label12;
GLabel label13;
GLabel label14;

Serial port; 
 
// sample ASCII command 'IP247G'
 
void setup()  {
  
    size(1080, 821);
    
    //textSize(32);
    textFont(createFont("Georgia", 32)); 
    fill(50);
    text("System", 20, 50, 10);
    text("Projector", 20, 250, 10);
    
    sysMsg = new GTextField(this, 20, 65, 120, 30, G4P.SCROLLBARS_NONE);
    sysMsg.setOpaque(true);
    sysMsg.setDefaultText("MESSAGES");
    sysMsg.addEventHandler(this, "sysMsg_display");
    
    // left, top, width, height
    txf1 = new GTextField(this, 20, 270, 100, 20);
    txf1.tag = "txf1";
    txf1.setDefaultText("Frame");
     
    txf2 = new GTextField(this, 20, 300, 100, 20);
    txf2.tag = "txf2";
    txf2.setDefaultText("Start");
         
    txf3 = new GTextField(this, 20, 330, 100, 20);
    txf3.tag = "txf3";
    txf3.setDefaultText("End");
         
    txf4 = new GTextField(this, 20, 360, 100, 20);
    txf4.tag = "txf4";
    txf4.setDefaultText("GoTo");
    
    imgTogButton11 = new GImageToggleButton(this, 20, 120);// x,y
    imgTogButton11.addEventHandler(this, "imgTogButton11_click1");
    
    imgTogButton12 = new GImageToggleButton(this, 90, 120);// x,y
    imgTogButton12.addEventHandler(this, "imgTogButton12_click1");

    label11 = new GLabel(this, 20, 100, 40, 20);
    label11.setText("RUN");
    label11.setOpaque(false);

    label12 = new GLabel(this, 20, 170, 40, 20);
    label12.setText("STOP");
    label12.setOpaque(false);
    
    label13 = new GLabel(this, 90, 100, 40, 20);
    label13.setText("FWD");
    label13.setOpaque(false);

    label14 = new GLabel(this, 90, 170, 40, 20);
    label14.setText("REV");
    label14.setOpaque(false);

     // List all the available serial ports in the output pane. 
     // You will need to choose the port that the Arduino board is 
     // connected to from this list. The first port in the list is 
     // port #0 and the third port in the list is port #2. 
    println(Serial.list()); 
     
     // Open the port that the Arduino board is connected to 
     // Make sure to open the port at the same speed Arduino is using (9600bps) 
    
    port = new Serial(this, Serial.list()[0], 9600); 
    port.bufferUntil(lf);
    tt = new GTabManager();
    tt.addControls(txf1, txf2, txf3, txf4);

}
 
void draw() { 
    // how neccessary is draw? It seems the program will not run without it
    // maybe we'll make some fancy backgrounds here
}

public void handleTextEvents(GEditableTextControl tc, GEvent event) { 
  System.out.print("\n" + tc.tag + "   Event type: ");
  switch(event) {
  case CHANGED:
    System.out.println("CHANGED");
    System.out.println(tc.getText());
    break;
  case SELECTION_CHANGED:
    System.out.println("SELECTION_CHANGED");
    System.out.println(tc.getSelectedText() + "\n");
    break;
  case ENTERED:
    System.out.println("ENTER KEY TYPED");
    System.out.println(tc.getText());
    
    enteredText = tc.getText();
    sendSerialCommand(enteredText);
    break;
  default:
    System.out.println("UNKNOWN");
  }
}

public void sendSerialCommand(String ASCIICommand) {
  System.out.println("from sendSerialCommand: " + ASCIICommand);
  port.write(ASCIICommand);  
  sysMsg.setText(ASCIICommand);
}

public void imgTogButton11_click1(GImageToggleButton source, GEvent event) {
  if (runToggle) {
    sendSerialCommand("RUN");
    runToggle = false;
  } else {
    sendSerialCommand("STOP");
    runToggle = true;
  }
}

public void imgTogButton12_click1(GImageToggleButton source, GEvent event) {
  if (directionToggle) {
    sendSerialCommand("FWD");
    directionToggle = false;
  } else {
    sendSerialCommand("REV");
    directionToggle = true;
  }
}


