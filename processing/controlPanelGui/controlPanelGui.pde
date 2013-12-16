import g4p_controls.*;
import processing.serial.*; 
 
float boxX;
float boxY;
int boxSize = 20;
int lf = 10;      // ASCII linefeed
boolean mouseOverBox = false;
String enteredText;
GTabManager tt;
GTextField txf1;

//PShape dashboard;

Serial port; 
 
void setup()  {
  
    // settting up the stage - size and background image
    size(1080, 821);
    //dashboard = loadShape("dashboard.svg");
    
    
  txf1 = new GTextField(this, 10, 10, 200, 20);
  txf1.tag = "txf1";
  txf1.setDefaultText("Text field 1");
 
    PImage img;
    img = loadImage("dashboard.png");
    background(img);
    
    textSize(32); 
    fill(0, 102, 153, 255);
    text("biscuchi", 100, 100);

    boxX = width/2.0;
    boxY = height/2.0;
    rectMode(RADIUS); 
     
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

     //background(255);
     //shape(dashboard, 0,0,1080,821);
 
   // Test if the cursor is over the box 
   if (mouseX > boxX-boxSize && mouseX < boxX+boxSize && 
     mouseY > boxY-boxSize && mouseY < boxY+boxSize) {
     mouseOverBox = true;  
     // draw a line around the box and change its color:
     stroke(0); 
     fill(195,50,204);
     // send an 'H' to indicate mouse is over square:
     //port.write('1');   
     //--port.write('H');    
   } else {
     // return the box to it's inactive state:
     stroke(60);
     fill(103,204,148);
     // send an 'L' to turn the LED off: 
     //port.write('0');   
     //--port.write('L');      
     mouseOverBox = false;
  }
 
   // Draw the box
   rect(boxX, boxY, boxSize, boxSize);
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
  // check status of last fired command
  //--port.write('H');
  port.write(ASCIICommand);  

}
