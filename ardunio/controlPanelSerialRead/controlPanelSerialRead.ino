String content = "";
char character;
const int ledPin = 13; // the pin that the LED is attached to
char incomingByte;      // a variable to read incoming serial data into
int pingBackASCII;

void setup() {
  // initialize serial communication:
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // see if there's incoming serial data:
  
  
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();  
    content.concat(incomingByte);
    
    if (content == "IP247G") {
      digitalWrite(ledPin, HIGH);
      Serial.write("IP247G");
    } 

    if (content == "OFF") {
      digitalWrite(ledPin, LOW);
    } 

    Serial.flush();
    
  }
  
}

