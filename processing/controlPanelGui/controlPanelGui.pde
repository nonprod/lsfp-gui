import g4p_controls.*;
import processing.serial.*; // a fun library
 
float boxX;
float boxY;
int boxSize = 20;
int lf = 10;      // ASCII linefeed

boolean mouseOverBox = false;
String enteredText;
GTabManager tt;
GTextField txf1;
Serial port; 
 
// sample ASCII command 'IP247G'
 
void setup()  {
  
    size(1080, 821);
    
    textSize(24); 
    fill(0, 102, 153, 255);
    text("System", 10, 50);
    
    txf1 = new GTextField(this, 10, 70, 200, 20);
    txf1.tag = "txf1";
    txf1.setDefaultText("Enter command");
     
     // List all the available serial ports in the output pane. 
     // You will need to choose the port that the Arduino board is 
     // connected to from this list. The first port in the list is 
     // port #0 and the third port in the list is port #2. 
    println(Serial.list()); 
     
     // Open the port that the Arduino board is connected to 
     // Make sure to open the port at the same speed Arduino is using (9600bps) 
    
    port = new Serial(this, Serial.list()[6], 9600); 
    port.bufferUntil(lf);
    tt = new GTabManager();
    tt.addControls(txf1);

}
 
void draw() { 
    // how neccessary is draw? It seems the program will not run without it
    background(230);
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
}

