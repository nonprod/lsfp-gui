/*
 * Test Echo to see if LabView package sends and receives characters with the Arduino.
 */

#define BOTHGo 65 // Char A
#define CAMGo 67 // Char C
#define FORWARD 43 // Char +
#define REVERSE 45 // Char -
#define PROJGo 80 // Char P
#define NOGo 73 // Char I
#define HOME 72 // Char H
#define RATIO 77 // Char M
#define GO 71 // Char 
#define LOCK 76 // Char L
#define UNLOCK 85 //Char U
#define CAMRATIO 77 // Char M
#define PROJRATIO 78 // Char N
#define SHOW 83 // Char S
#define KILL 75 // Char K

 
char incomingByte = 0; // Bytes in Fnnn or Rnnn for direction and step count

void setup() {
  Serial.begin(38400); // start reading from serial line
}

void loop() { 
  int i=0, steps=0; // general index

  boolean waiting=true; // Accumulate number and command
 
  while(waiting) { // - 2
    if(Serial.available() > 0) { // - 3
      incomingByte = Serial.read();
      if((incomingByte > 47) && (incomingByte < 58)) { // character is number, accumulate - 4
	steps = 10*steps + incomingByte-48;
      } // incoming 47-58 - 3

      if(incomingByte == FORWARD) { //if character is F select LOW (forward) - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
        Serial.print(" Forward ");
        Serial.println(steps, DEC);
      } // incoming = FORWARD "+"
      
      if(incomingByte == REVERSE) { //if character is R select HIGH (reverse) - 4
        Serial.print("Doing ");
	Serial.print(incomingByte);
        Serial.print(" Reverse ");
	Serial.println(steps, DEC);
      } // incoming = REVERSE "-"
      
      if(incomingByte == BOTHGo) { // character is "A" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to enable both Camera and Projector");
      }  // incoming = BOTHGo "A" - 3 
    
      if(incomingByte == PROJGo) { // character is "P" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to enable Projector");
      }  // incoming = PROGGo "P" - 3
      
      if(incomingByte == CAMGo) {  // character is "C" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to enable Camera");
      }  // incoming = CAMGo "C" - 3
      
      if(incomingByte == NOGo) {  // character is "I" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to idle both Camera and Projector");
      }  // incoming = NOGo "I" - 3

      if(incomingByte == LOCK) {  // character is "L" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to lock to sensors");
      }  // incoming = NOGo "L" - 3

      if(incomingByte == UNLOCK) {  // character is "U" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to unlock from sensors");
      }  // incoming = NOGo "U" - 3
      
      if(incomingByte == SHOW) {  // character is "S" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to print sensor values");
      }  // incoming = NOGo "S" - 3
      
      if(incomingByte == KILL) {  // character is "K" - 4
        Serial.print("Setting ");
	Serial.print(incomingByte);
	Serial.println(" to kill pringout of sensor values");
      }  // incoming = NOGo "K" - 3   
      
      if(incomingByte == HOME) { //H for home - 4
        steps = 2;
        Serial.print("Doing ");
	Serial.print(incomingByte);
	Serial.println(steps, DEC);
        waiting = false;
      }  // incoming = HOME "H" - 3
      
      if(incomingByte == CAMRATIO) { //M for multiple-Ratio - 4
        if(steps == 0) steps = 1;
        Serial.print("Setting Camera Ratio ");
	Serial.print(incomingByte);
	Serial.println(steps, DEC);
        steps = 0;
      }  // incoming = RATIO "M" - 3
      
      if(incomingByte == PROJRATIO) { //N for multiple-Ratio - 4
        if(steps == 0) steps = 1;
        Serial.print("Setting Projector Ratio ");
	Serial.print(incomingByte);
	Serial.println(steps, DEC);
        steps = 0;
      }  // incoming = RATIO "M" - 3
      
      if(incomingByte == GO) { //G to execute commands entered
        Serial.print("Executing ");
	Serial.print(incomingByte);
        Serial.print(" with steps = ");
	Serial.println(steps, DEC);
        Serial.flush();
        waiting = false; // execute commands
      }  // incoming = RATIO "G" - 3
      
    } // if serial available - 2
  } // while waiting - 1
} // routine void - 0
