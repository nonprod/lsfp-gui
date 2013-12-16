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

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:476379:
  println("SystemRunStop send ASCII 1 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button1:476379:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:365925:
  println("SystemForRev send ASCII 2 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button2:365925:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:549539:
  println("SystemStep send ASCII 3 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button3:549539:

public void button4_click1(GButton source, GEvent event) { //_CODE_:button4:813418:
  println("SystemGOTO sned ASCII 4 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button4:813418:

public void button5_click1(GButton source, GEvent event) { //_CODE_:button5:201421:
  println("CameraEnable send ASCII 5 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button5:201421:

public void button6_click1(GButton source, GEvent event) { //_CODE_:button6:957036:
  println("ProjectorEnable send ASCII 6 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button6:957036:

public void button7_click1(GButton source, GEvent event) { //_CODE_:button7:493778:
  println("SystemLock send ASCII 7 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button7:493778:

public void button9_click1(GButton source, GEvent event) { //_CODE_:button9:869574:
  println("DisplayPage send ASCII 9 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button9:869574:

public void button48_click1(GButton source, GEvent event) { //_CODE_:button48:561550:
  println("ProjectorRunStop send ASCII 48 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button48:561550:

public void button49_click1(GButton source, GEvent event) { //_CODE_:button49:554932:
  println("ProjectorForRev send ASCII 49 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button49:554932:

public void button50_click1(GButton source, GEvent event) { //_CODE_:button50:267916:
  println("ProjectorGOTO send ASCII 50 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button50:267916:

public void button51_click1(GButton source, GEvent event) { //_CODE_:button51:720078:
  println("ProjectorStep send ASCII 51 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button51:720078:

public void button52_click1(GButton source, GEvent event) { //_CODE_:button52:988977:
  println("ProjectorLoad send ASCII 52 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button52:988977:

public void button53_click1(GButton source, GEvent event) { //_CODE_:button53:966913:
  println("ProjectorHold send ASCII 53 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button53:966913:

public void button44_click1(GButton source, GEvent event) { //_CODE_:button44:798783:
  println("CameraForRev send ASCII 44 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button44:798783:

public void button45_click1(GButton source, GEvent event) { //_CODE_:button45:274143:
  println("CameraStep send ASCII 45 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button45:274143:

public void button47_click1(GButton source, GEvent event) { //_CODE_:button47:611176:
  println("CameraLoad send ASCII 47 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button47:611176:

public void button46_click1(GButton source, GEvent event) { //_CODE_:button46:892386:
  println("CameraGOTO send ASCII 46 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button46:892386:

public void button37_click1(GButton source, GEvent event) { //_CODE_:button37:431742:
  println("CameraShutterMode send ASCII 37 " + System.currentTimeMillis()%10000000 );
} //_CODE_:button37:431742:

public void textfieldFPS_change1(GTextField source, GEvent event) { //_CODE_:FPSentry:406971:
  println("FPSentry - machine speed selected " + System.currentTimeMillis()%10000000 );
} //_CODE_:FPSentry:406971:

public void textfieldPR_change1(GTextField source, GEvent event) { //_CODE_:PROJratio:359613:
  println("PROJratio - Projector Ratio selected " + System.currentTimeMillis()%10000000 );
} //_CODE_:PROJratio:359613:

public void textfieldCR_change1(GTextField source, GEvent event) { //_CODE_:CAMERAratio:567001:
  println("CAMERAratio - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:CAMERAratio:567001:

public void textfieldPF_change1(GTextField source, GEvent event) { //_CODE_:ProjFrame:557086:
  println("ProjFrame - current frame postion defined " + System.currentTimeMillis()%10000000 );
} //_CODE_:ProjFrame:557086:

public void textfieldPG_change1(GTextField source, GEvent event) { //_CODE_:ProjGOTO:902111:
  println("ProjGOTO - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:ProjGOTO:902111:

public void textfieldSF_change1(GTextField source, GEvent event) { //_CODE_:ShutterFrom:794372:
  println("ShutterFrom - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:ShutterFrom:794372:

public void textfieldST_change1(GTextField source, GEvent event) { //_CODE_:ShutterTo:268963:
  println("ShutterTo - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:ShutterTo:268963:

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:ShutterStart:801757:
  println("ShutterStart - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:ShutterStart:801757:

public void textfieldSE_change1(GTextField source, GEvent event) { //_CODE_:ShutterEnd:636296:
  println("ShutterEnd - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:ShutterEnd:636296:

public void textfieldCF_change1(GTextField source, GEvent event) { //_CODE_:CameraFrame:616465:
  println("CameraFrame - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:CameraFrame:616465:

public void textfieldCE_change1(GTextField source, GEvent event) { //_CODE_:CameraEnd:330704:
  println("CameraEnd - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:CameraEnd:330704:

public void textfieldCG_change1(GTextField source, GEvent event) { //_CODE_:CameraGOTO:785165:
  println("CameraGOTO - GTextField event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:CameraGOTO:785165:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  button1 = new GButton(this, 45, 108, 56, 54);
  button1.setText("RUN STOP");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 111, 107, 57, 56);
  button2.setText("FOR   REV");
  button2.addEventHandler(this, "button2_click1");
  button3 = new GButton(this, 45, 173, 56, 55);
  button3.setText("STEP");
  button3.addEventHandler(this, "button3_click1");
  button4 = new GButton(this, 111, 172, 58, 56);
  button4.setText("GOTO");
  button4.addEventHandler(this, "button4_click1");
  button5 = new GButton(this, 196, 93, 38, 35);
  button5.setText("C");
  button5.addEventHandler(this, "button5_click1");
  button6 = new GButton(this, 195, 143, 39, 36);
  button6.setText("P");
  button6.addEventHandler(this, "button6_click1");
  button7 = new GButton(this, 195, 193, 39, 36);
  button7.setText("L");
  button7.addEventHandler(this, "button7_click1");
  button9 = new GButton(this, 666, 43, 37, 35);
  button9.setText("PAGE");
  button9.addEventHandler(this, "button9_click1");
  button48 = new GButton(this, 45, 566, 56, 55);
  button48.setText("RUN STOP");
  button48.addEventHandler(this, "button48_click1");
  button49 = new GButton(this, 110, 566, 58, 55);
  button49.setText("FOR    REV");
  button49.addEventHandler(this, "button49_click1");
  button50 = new GButton(this, 178, 565, 56, 56);
  button50.setText("GOTO");
  button50.addEventHandler(this, "button50_click1");
  button51 = new GButton(this, 42, 633, 57, 55);
  button51.setText("STEP");
  button51.addEventHandler(this, "button51_click1");
  button52 = new GButton(this, 111, 633, 57, 56);
  button52.setText("LOAD");
  button52.addEventHandler(this, "button52_click1");
  button53 = new GButton(this, 179, 631, 56, 56);
  button53.setText("HOLD");
  button53.addEventHandler(this, "button53_click1");
  button44 = new GButton(this, 282, 634, 56, 56);
  button44.setText("FOR    REV");
  button44.addEventHandler(this, "button44_click1");
  button45 = new GButton(this, 350, 634, 56, 55);
  button45.setText("STEP");
  button45.addEventHandler(this, "button45_click1");
  button47 = new GButton(this, 418, 633, 56, 56);
  button47.setText("LOAD");
  button47.addEventHandler(this, "button47_click1");
  button46 = new GButton(this, 486, 634, 57, 56);
  button46.setText("GOTO");
  button46.addEventHandler(this, "button46_click1");
  button37 = new GButton(this, 253, 324, 40, 36);
  button37.setText("MODE");
  button37.addEventHandler(this, "button37_click1");
  MessageBlock = new GLabel(this, 46, 63, 122, 28);
  MessageBlock.setText("MESSAGE8");
  MessageBlock.setOpaque(false);
  DisplayBlock1 = new GLabel(this, 262, 42, 268, 28);
  DisplayBlock1.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  DisplayBlock1.setText("NOT LOCKED");
  DisplayBlock1.setOpaque(false);
  DisplayBlock2 = new GLabel(this, 262, 96, 378, 27);
  DisplayBlock2.setText("PROJ 1     CAMERA");
  DisplayBlock2.setOpaque(false);
  DisplayBlock3 = new GLabel(this, 262, 148, 269, 28);
  DisplayBlock3.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  DisplayBlock3.setText("FRAME");
  DisplayBlock3.setOpaque(false);
  DisplayBlock4 = new GLabel(this, 264, 204, 378, 27);
  DisplayBlock4.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  DisplayBlock4.setText("END");
  DisplayBlock4.setOpaque(false);
  ProjStartDisplay = new GLabel(this, 106, 388, 74, 27);
  ProjStartDisplay.setText("00000");
  ProjStartDisplay.setOpaque(false);
  ProjEndDisplay = new GLabel(this, 107, 454, 75, 28);
  ProjEndDisplay.setText("00000");
  ProjEndDisplay.setOpaque(false);
  CameraStartDisplay = new GLabel(this, 578, 400, 74, 27);
  CameraStartDisplay.setText("00000");
  CameraStartDisplay.setOpaque(false);
  FPSentry = new GTextField(this, 531, 42, 33, 28, G4P.SCROLLBARS_NONE);
  FPSentry.setText("1");
  FPSentry.setDefaultText("1");
  FPSentry.setOpaque(true);
  FPSentry.addEventHandler(this, "textfieldFPS_change1");
  PROJratio = new GTextField(this, 531, 148, 37, 28, G4P.SCROLLBARS_NONE);
  PROJratio.setText("1");
  PROJratio.setDefaultText("1");
  PROJratio.setOpaque(true);
  PROJratio.addEventHandler(this, "textfieldPR_change1");
  CAMERAratio = new GTextField(this, 603, 148, 38, 28, G4P.SCROLLBARS_NONE);
  CAMERAratio.setText("1");
  CAMERAratio.setDefaultText("1");
  CAMERAratio.setOpaque(true);
  CAMERAratio.addEventHandler(this, "textfieldCR_change1");
  RatioColon = new GLabel(this, 570, 148, 33, 28);
  RatioColon.setText(":");
  RatioColon.setTextBold();
  RatioColon.setOpaque(false);
  FPS = new GLabel(this, 565, 42, 75, 28);
  FPS.setText("FPS");
  FPS.setOpaque(false);
  ProjFrame = new GTextField(this, 106, 322, 74, 29, G4P.SCROLLBARS_NONE);
  ProjFrame.setText("00000");
  ProjFrame.setDefaultText("00000");
  ProjFrame.setOpaque(true);
  ProjFrame.addEventHandler(this, "textfieldPF_change1");
  ProjGOTO = new GTextField(this, 106, 518, 75, 28, G4P.SCROLLBARS_NONE);
  ProjGOTO.setText("00000");
  ProjGOTO.setOpaque(true);
  ProjGOTO.addEventHandler(this, "textfieldPG_change1");
  ShutterFrom = new GTextField(this, 354, 406, 76, 28, G4P.SCROLLBARS_NONE);
  ShutterFrom.setText("160˚");
  ShutterFrom.setDefaultText("160˚");
  ShutterFrom.setOpaque(true);
  ShutterFrom.addEventHandler(this, "textfieldSF_change1");
  ShutterTo = new GTextField(this, 354, 463, 76, 29, G4P.SCROLLBARS_NONE);
  ShutterTo.setText("0˚");
  ShutterTo.setDefaultText("0˚");
  ShutterTo.setOpaque(true);
  ShutterTo.addEventHandler(this, "textfieldST_change1");
  ShutterStart = new GTextField(this, 355, 526, 76, 29, G4P.SCROLLBARS_NONE);
  ShutterStart.setText("00000");
  ShutterStart.setDefaultText("00000");
  ShutterStart.setOpaque(true);
  ShutterStart.addEventHandler(this, "textfield1_change1");
  ShutterEnd = new GTextField(this, 356, 588, 74, 28, G4P.SCROLLBARS_NONE);
  ShutterEnd.setText("00000");
  ShutterEnd.setDefaultText("00024");
  ShutterEnd.setOpaque(true);
  ShutterEnd.addEventHandler(this, "textfieldSE_change1");
  CameraFrame = new GTextField(this, 577, 345, 74, 27, G4P.SCROLLBARS_NONE);
  CameraFrame.setText("00000");
  CameraFrame.setDefaultText("00000");
  CameraFrame.setOpaque(true);
  CameraFrame.addEventHandler(this, "textfieldCF_change1");
  CameraEnd = new GTextField(this, 576, 462, 75, 29, G4P.SCROLLBARS_NONE);
  CameraEnd.setText("00000");
  CameraEnd.setDefaultText("00000");
  CameraEnd.setOpaque(true);
  CameraEnd.addEventHandler(this, "textfieldCE_change1");
  CameraGOTO = new GTextField(this, 577, 521, 75, 28, G4P.SCROLLBARS_NONE);
  CameraGOTO.setText("00000");
  CameraGOTO.setDefaultText("00000");
  CameraGOTO.setOpaque(true);
  CameraGOTO.addEventHandler(this, "textfieldCG_change1");
  ShutterModeDisplay = new GLabel(this, 318, 348, 110, 28);
  ShutterModeDisplay.setText("MANUAL");
  ShutterModeDisplay.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GButton button1; 
GButton button2; 
GButton button3; 
GButton button4; 
GButton button5; 
GButton button6; 
GButton button7; 
GButton button9; 
GButton button48; 
GButton button49; 
GButton button50; 
GButton button51; 
GButton button52; 
GButton button53; 
GButton button44; 
GButton button45; 
GButton button47; 
GButton button46; 
GButton button37; 
GLabel MessageBlock; 
GLabel DisplayBlock1; 
GLabel DisplayBlock2; 
GLabel DisplayBlock3; 
GLabel DisplayBlock4; 
GLabel ProjStartDisplay; 
GLabel ProjEndDisplay; 
GLabel CameraStartDisplay; 
GTextField FPSentry; 
GTextField PROJratio; 
GTextField CAMERAratio; 
GLabel RatioColon; 
GLabel FPS; 
GTextField ProjFrame; 
GTextField ProjGOTO; 
GTextField ShutterFrom; 
GTextField ShutterTo; 
GTextField ShutterStart; 
GTextField ShutterEnd; 
GTextField CameraFrame; 
GTextField CameraEnd; 
GTextField CameraGOTO; 
GLabel ShutterModeDisplay; 

