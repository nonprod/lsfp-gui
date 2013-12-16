/*
 * Generate upramp, fullspeed, and downramp to stepper motor
 * J. Wehrley Chapman
 * umjwc@umich.edu
 *
 * TIMEFACTOR at 1360000 is ? 1/6 second exposure
 * TIMEFACTOR at 2000000 is ? 1/4 second exposure
 * TIMEFACTOR at 3000000 is ? 3/8 second exposure
 
 * Generate pulse ramp up, continues for time, and ramp down
 * using a simple algorithm in finite difference. NUMSTEPS is
 * twice the ramp up steps, i.e., it is the ramp up and down.
 * Program goes NUMSTEPS/2, puts in FASTSTEPS=2000-NUMSTEPS/2
 * at the fastest rate, then continues with the NUMSTEPS/2 down.
 * to get the full TOTALSTEPS = 2000, takes about .25 seconds.
 
 18 A√∏ camera - interrupt 5
 19 B√∏ camera - interurpt 4
 20 A√∏ projector - interrupt 3
 21 B√∏ projector - interrupt 2
 
 */

// Define the number of steps for one rotation. The higher the number, the more the steps
// will be taken. Using a #define rather than a normal variable lets us use this value to
// determine the size of the step rate array.

#define NUMSTEPS 200
#define UPTOSPEED NUMSTEPS/2
#define SCALE 6800
#define FIRST 10
#define MULT 4
#define CAMTIMEFACTOR 2400000/SCALE
#define PROJTIMEFACTOR 1000000/SCALE
#define CAMERAA 18
#define CAMERAB 19
#define PROJECTORA 20
#define PROJECTORB 21
#define CAMFIRST 1285
#define PROJFIRST 976
#define CAMBACK 516
#define PROJBACK 831

#define BOTHGo 65 // Char A
#define CAMGo 67 // Char C
#define GO 71 // Char G
#define REVERSE 45 // Char -
#define FORWARD 43 // Char +
#define PROJGo 80 // Char P
#define NOGo 73 // Char I
#define LOCK 76 // Char L
#define UNLOCK 85 //Char U
#define CAMRATIO 77 // Char M
#define PROJRATIO 78 // Char N
#define SHOW 83 // Char S
#define KILL 75 // Char K

int camtimes[NUMSTEPS]; // the wait time for next step
int projtimes[NUMSTEPS]; // the wait time for next step

int trx18, trx20; // captures rotation position of camera A projector A
int trx19, trx21; // captures rotation position of camera B and projector B
int camcount, projcount;
int correctcam = 0, correctproj = 0;
int MasSysEna = 4; // 5volts for system enable

int CamStepPin = 12; // cam motor step
int CamRotationPin = 13; // Forward is LOW and reverse is HIGH
int CamEnablePin = 11; // cam motor drive enable
int CamHomePin = 18; // Pin for input sensing
int CamHomePinB = 19; // B input sensing

int ProjStepPin = 6;                // proj motor step
int ProjRotationPin = 7;            // Forward is LOW and reverse is HIGH
int ProjEnablePin = 5;              // proj motor drive enable
int ProjHomePin = 20;               // Pin for input sensing 
int ProjHomePinB = 21;              // Projector input B sensor

int FaderStepPin = 8;               // proj motor step
int FaderRotationPin = 10;          // Forward is LOW and reverse is HIGH
int FaderEnablePin = 9;             // proj motor drive enable

char incomingByte = 0; // Bytes in Fnnn or Rnnn for direction and step count
int loc; // Current rotation position
void setup() {
  float current = 0; // the running total
  float dPds = 0; // the index of the current reading
  int i; // general index
  current = FIRST; // Build table of times
  for (i = 0; i < NUMSTEPS; i++) {
    dPds = current*(NUMSTEPS-current)/SCALE;
    current += dPds;
    camtimes[i] = CAMTIMEFACTOR/dPds;
    projtimes[i] = PROJTIMEFACTOR/dPds;
  }
  pinMode(MasSysEna, OUTPUT); // sets 5 volts for sys enable/defeat

  pinMode(CamStepPin, OUTPUT); // sets the Cam digital pin as step pulse
  pinMode(CamRotationPin, OUTPUT); // sets up Cam rotation control pin
  pinMode(CamEnablePin, OUTPUT); // sets Cam motor current active
  pinMode(CamHomePin, INPUT); // Pin set at point in Cam motor rotation
  pinMode(CamHomePinB, INPUT); // B home pin 

  pinMode(ProjStepPin, OUTPUT); // sets the Proj digital pin as step pulse
  pinMode(ProjRotationPin, OUTPUT); // sets up Proj rotation control pin
  pinMode(ProjEnablePin, OUTPUT); // sets Proj motor current active
  pinMode(ProjHomePin, INPUT); // Pin set at point in Proj motor rotation
  pinMode(ProjHomePinB, INPUT); // Pin home B

  pinMode(FaderEnablePin, OUTPUT); // sets Fader motor current active

  digitalWrite(MasSysEna, HIGH); // set for enable
  digitalWrite(CamRotationPin, LOW); // set for Cam forward at init
  digitalWrite(CamEnablePin, HIGH); // set for Cam no movement
  digitalWrite(ProjEnablePin, HIGH); // set for Proj no movement 
  digitalWrite(ProjRotationPin, LOW); // set for Proj reverse at init
  // digitalWrite(FaderEnablePin, LOW); // set for Fader movement
  attachInterrupt(5, set18, RISING); // Camera first transition
  attachInterrupt(4, set19, RISING); // Camera B transition
  attachInterrupt(3, set20, RISING); // Projector first transition
  attachInterrupt(2, set21, RISING); // Projector B transition

  Serial.begin(38400); // start reading from serial line
  Serial.println("Film Printer Version 14");
}
void set18() {  // Interrupt routine
  trx18 = camcount; // count seen at location (loc)
}
void set19() {  // Interrupt routine 
  trx19 = camcount;   // capture location at interrupt
}
void set20() {  // Interrupt routine for histogram
  trx20 = projcount; // count seen at location (loc)
}
void set21() {  // Interrupt routine
  trx21 = projcount;   // Capture location when signal chances
}

void loop() { //to get the full TOTALSTEPS = 2000, takes about .25 seconds. // - 1 number is depth of nesting "{"
  int i; // general index
  int steps = 0, cammult=4, projmult=4; // Number of rotations to do
  int camratio = 1, projratio = 1; // Set default ratio to 1
  int cycle, camcycle, projcycle, gona; // Current rotation count
  boolean waiting=true; // To accumulate number and command
  boolean camsel=true, projsel=true, fadersel=true; // Set default to run both
  boolean adjust=true; // true but protected to take place only transition sample has been seen
  boolean DoLoop=true; // cycle through action command
  boolean prnt = false; // show transitions
  boolean forward = true;
  boolean projforward=true, camforward=true;
  steps = 0;
  while(waiting) { // - 2 waiting for command entry
    if(Serial.available() > 0) { // - 3 Any characters entered
      incomingByte = Serial.read();
      if(incomingByte == FORWARD) { //if character is + select LOW (forward) - 4
        forward = true;
        Serial.print("Setting forward = "); // Feedback to tell operator
        Serial.print(forward);
        Serial.print(" from command ");
        Serial.println(incomingByte); // Tell operator doing +
        Serial.flush(); // Flush out buffer now that all of line is loaded
      } // incoming = FORWARD - 3 End the Forward command
      if(incomingByte == REVERSE) { //if character is - select HIGH (reverse) - 4
        forward = false; // set the direction not forward
        Serial.print("Setting forward = "); // Feedback to tell operator
        Serial.print(forward); // Tell operator forward = false
        Serial.print(" from command ");
        Serial.print(incomingByte); // Tell operator doing -
        Serial.println(steps, DEC); // Kick it out with linefeed
        Serial.flush(); // Flush out buffer now that all of line is loaded
      } // incoming = REVERSE "-" - 3 End of the reverse command
      if(incomingByte == GO) { //if character is G select HIGH (reverse) - 4
        if(forward) {
          digitalWrite(CamRotationPin, LOW); // Set rotation to reverse
          digitalWrite(ProjRotationPin, HIGH); //proj reverse for 16mm 1R
        }
        else {
          digitalWrite(CamRotationPin, HIGH); // Set rotation to reverse
          digitalWrite(ProjRotationPin, LOW); //proj reverse for 16mm 1R
        }        
        Serial.print("Doing "); // Feedback to tell operator
        Serial.print(incomingByte); // Tell operator doing G
        Serial.println(steps, DEC); // Kick it out with linefeed
        Serial.flush(); // Flush out buffer now that all of line is loaded
        waiting = false; // Exit waiting loop - have received a command
      } // incoming = GO "G" - 3 End of the reverse command
      if(incomingByte == BOTHGo) { // character is "A" - 4
        camsel = true;
        projsel = true;
        Serial.print("Setting ");
        Serial.print(incomingByte);
        Serial.println(" to enable both Camera and Projector");
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = BOTHGo "A" - 3  
      if(incomingByte == PROJGo) { // character is "P" - 4      
        projsel = true;
        projforward = forward;
        projmult = steps;
        if(projmult == 0) projmult=MULT; //if setting mult forgotten set to MULT
        Serial.print("Setting ");
        Serial.print(incomingByte);
        Serial.print(" to enable Projector with forward = ");
        Serial.print(forward);
        Serial.print(" with mult = ");
        Serial.println(projmult);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = PROGGo "P" - 3
      if(incomingByte == CAMGo) {  // character is "C" - 4     
        camsel = true;
        camforward = forward;
        cammult = steps;
        if(cammult == 0) cammult = MULT; // if setting mut forgotten set to MULT
        Serial.print("Setting ");
        Serial.print(incomingByte);
        Serial.print(" to enable Camera with forward = ");
        Serial.print(camforward);
        Serial.print(" with mult = ");
        Serial.println(cammult);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = CAMGo "C" - 3
      if(incomingByte == NOGo) {  // character is "I" - 4
        camsel = false;
        projsel =  false;
        Serial.print("Setting ");
        Serial.print(incomingByte);
        Serial.println(" to idle both Camera and Projector");
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = NOGo "I" - 3
      if(incomingByte == LOCK) { //L for home - 4
        adjust = true;
        Serial.print("Locking to sensor with ");
        Serial.println(incomingByte);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = HOME "L" - 3
      if(incomingByte == UNLOCK) { //U for home - 4
        adjust = false;
        Serial.print("UnLocking to sensor with ");
        Serial.println(incomingByte);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = HOME "U" - 3
      if(incomingByte == CAMRATIO) { //M for multiple-Ratio - 4
        camratio = steps;
        Serial.print("Setting Camera Ratio ");
        Serial.print(incomingByte);
        Serial.println(steps, DEC);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = RATIO "M" - 3
      if(incomingByte == PROJRATIO) { //N for multiple-Ratio - 4
        projratio = steps;
        Serial.print("Setting Projector Ratio ");
        Serial.print(incomingByte);
        Serial.println(steps, DEC);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = PROJRATIO "N" - 3
      if(incomingByte == KILL) { //K for kill printout - 4
        prnt = false;
        Serial.print("Killing printout ");
        Serial.println(incomingByte);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = kill printout "K" - 3
      if(incomingByte == SHOW) { //S for show printout - 4
        prnt = true;
        Serial.print("Enable Print of Transitions ");
        Serial.println(incomingByte);
        Serial.flush();
        steps = 0; // get some command that requires action, clean step
      }  // incoming = show transitions "S" - 3
      if((incomingByte > 47) && (incomingByte < 58)) { // character is number, accumulate - 4
        steps = 10*steps + incomingByte-48;
      } // incoming 47-58 - 3
    } // if serial available - 2
  } // while waiting - 1
  correctcam = 0;
  correctproj = 0;
  DoLoop = true;
  while(DoLoop) { // - 2
    if(projsel) digitalWrite(ProjEnablePin, LOW); // Projector enabled
    if(camsel) digitalWrite(CamEnablePin, LOW); // Camera enable
    if(fadersel) digitalWrite(FaderEnablePin, LOW);  // Enable Fader
    delay(1000); //delay 1 second in ms
    for (cycle=0; cycle < steps; cycle++) { // start number of rotations - 3
      camcount = 0;
      if(camsel) { // - 4
        camcycle = cycle % camratio; // if zero going to do a frame on camera
        projcycle = cycle % projratio;
        if(camcycle == 0) { // - 5
          for (loc = 0; loc < UPTOSPEED; loc++) { // - 6
            for (i=0; i<cammult; i++) { // - 7
              digitalWrite(CamStepPin, HIGH); // sets the STEP on
              delayMicroseconds(10); // waits for 0.01 milli-second
              digitalWrite(CamStepPin, LOW); // sets the STEP off
              if(((camcycle == 0) && projsel) || (cycle == 0)) delayMicroseconds(camtimes[loc]); // waits for specified period 
              else delayMicroseconds(camtimes[UPTOSPEED]);
              camcount ++;
            } // - 6 for i
          } // - 5 for loc
          for (i = 0; i < 2000-cammult*NUMSTEPS+correctcam; i++) { // - 6
            digitalWrite(CamStepPin, HIGH); // This loop just spits out
            delayMicroseconds(10); // pulses at the fastest rate.
            digitalWrite(CamStepPin, LOW); // Pulses are everywhere 1ms
            delayMicroseconds(camtimes[UPTOSPEED]);
            camcount++;
          } // - 5 for i
          for (loc = UPTOSPEED; loc < NUMSTEPS; loc++) { // Next finish the rampdown - 6
            for(i=0; i<cammult; i++) { // - 7
              digitalWrite(CamStepPin, HIGH); // sets the LED on
              delayMicroseconds(10); // waits for 0.01 milli-second
              digitalWrite(CamStepPin, LOW); // Pulses are everywhere 1ms
              if(((projcycle == 0) && projsel) || (cycle == (steps-1))) delayMicroseconds(camtimes[loc]); // waits for specified period
              else delayMicroseconds(camtimes[UPTOSPEED]);
            camcount++;
            } // - 6 for i
          } // - 5 for loc
        } // - 4 modulo
      } // - 3 camsel
      if(projsel) { // - 4 
        projcount = 0;
        projcycle = cycle % projratio;
        camcycle = (cycle+1) % camratio;
        if(projcycle == 0) { // - 5
          for (loc = 0; loc < UPTOSPEED; loc++) { // - 6
            for(i=0; i<projmult; i++) { // - 7
              digitalWrite(ProjStepPin, HIGH); // sets the STEP on
              delayMicroseconds(10); // waits for 0.01 milli-second
              digitalWrite(ProjStepPin, LOW); // sets the STEP off
              if(((projcycle == 0) && camsel) || (cycle == 0)) delayMicroseconds(projtimes[loc]); // waits for specified period 
              else delayMicroseconds(projtimes[UPTOSPEED]);
              projcount++;
            } // - 6 i
          } // - 5 loc
          for (i = 0; i < 2000-projmult*NUMSTEPS+correctproj; i++) { // - 6
            digitalWrite(ProjStepPin, HIGH); // This loop just spits out
            delayMicroseconds(10); // pulses at the fastest rate.
            digitalWrite(ProjStepPin, LOW); // Pulses are everywhere 1ms
            delayMicroseconds(projtimes[UPTOSPEED]);
            projcount++;
          } // - 5 i
          for (loc = UPTOSPEED; loc < NUMSTEPS; loc++) { // Next finish the rampdown - 6
            for(i=0; i<projmult; i++) { // - 7
              digitalWrite(ProjStepPin, HIGH); // sets the LED on
              delayMicroseconds(10); // waits for 0.01 milli-second
              digitalWrite(ProjStepPin, LOW); // Pulses are everywhere 1ms
              if(((camcycle == 0) && camsel) || (cycle == (steps-1)))delayMicroseconds(projtimes[loc]); // waits for specified period
              else delayMicroseconds(projtimes[UPTOSPEED]);
              projcount++;
            } // - 6 i
          } // - 5 loc
        } // -4 modulo
      } // - 3 projsel
      if(prnt) {
        gona=2000+correctcam;    
        Serial.print("Camera steps to Home / steps taken ");
        Serial.print(gona, DEC);
        Serial.print(" / ");
        Serial.println(camcount, DEC);
        gona=2000-correctproj;
        Serial.print("Projector steps to Home / steps taken ");
        Serial.print(gona, DEC);
        Serial.print(" / ");
        Serial.println(projcount, DEC);
      }

      if(adjust) { // - 4
        if(forward) {
          if(trx18 != 0) correctcam = trx18-CAMFIRST-correctcam;
          if(trx20 != 0) correctproj = trx20-PROJFIRST-correctproj;
        } 
        else {
          if(trx18 != 0) correctcam = trx18-CAMBACK-correctcam;
          if(trx20 != 0) correctproj = trx20-PROJBACK-correctproj;
        }          
      } // -  3 end adjust 
      if(prnt) { // show transitions
        Serial.print(" After sensing Pin 18/Pin 19/Pin 20/Pin 21/ ");
        Serial.print(trx18, DEC);
        Serial.print(" / ");
        Serial.print(trx19, DEC);
        Serial.print(" / ");
        Serial.print(trx20, DEC);
        Serial.print(" / ");
        Serial.print(trx21, DEC);
        Serial.print(" / ");
        Serial.print(" Correction for Camera and Projector /");
        Serial.print(correctcam, DEC);
        Serial.print(" / ");
        Serial.println(correctproj, DEC);
        Serial.flush();
      }
      trx18 = 0;
      trx20 = 0;

    } // - 2 cycles end
    DoLoop = false;
  } // - 1 while loop
  digitalWrite(CamEnablePin, HIGH); // for idle
  digitalWrite(ProjEnablePin, HIGH); //
  digitalWrite(FaderEnablePin, HIGH); //
} // routine void - 0


















