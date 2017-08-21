//test
import processing.serial.*;

import processing.sound.*;
WhiteNoise noise;
LowPass lowPass;

float amp=0.0;

float LOW = 0.05;
float HIGH = 1.0;
boolean intense = false;
Serial arduinoSerial;
float threshold = 100;

void setup() {
  fullScreen();
  background(0);
  noise = new WhiteNoise(this);
  lowPass = new LowPass(this);
  //noise.amp(LOW);
  noise.play(0.5);
  lowPass.process(noise, 800);
  arduinoSerial = new Serial(this, Serial.list()[1], 9600);
}

void draw() {
  float random = random(5000);

  if (arduinoSerial.available() > 0) {
    String valueAsString = arduinoSerial.readStringUntil('\n');
    //println("###" + valueAsString + "###");
    if (valueAsString != null) {
      valueAsString = valueAsString.replace("\n", "");
      //println("+++" + valueAsString + "+++");
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