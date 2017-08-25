import processing.serial.*;

import processing.sound.*;
WhiteNoise noise;
//SoundFile file;

float LOW = 0.05;
float HIGH = 1.0;
boolean intense = false;
Serial arduinoSerial;
float threshold = 100;

void setup() {
  // fullScreen();
  size(100, 100);
  background(0);
  noise = new WhiteNoise(this);
  noise.amp(LOW);
  noise.play();
  //  file = new SoundFile (this, "Gewitterchen.wav");
  //  file.play();
  arduinoSerial = new Serial(this, Serial.list()[1], 9600);
}

void draw() {
  float random = random(5000);

  if (arduinoSerial.available() > 0) {
    String valueAsString = arduinoSerial.readStringUntil('\n');
   // println("###" + valueAsString + "###");
    if (valueAsString != null) {
      valueAsString = valueAsString.replace("\n", "");
   // println("+++" + valueAsString + "+++");
      threshold = Float.parseFloat(valueAsString);
    }
    //println(threshold);
  }
  //if (intense) {
  //  threshold = 1000;
  //} else {
  //  threshold = 100;
  //}

  if (random < threshold) {
    background(255);
  } else {
    background(0);
  }
}

void keyPressed() {
  if (intense) noise.amp(LOW);
  else noise.amp(HIGH);
  intense = !intense;
}