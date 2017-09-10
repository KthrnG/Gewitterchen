import processing.serial.*;
import processing.sound.*;

int schieberegler = 0;
int MAXIMUM = 100;
int MINIMUM = 0;

WhiteNoise regen;

void setup() {
  //println(Serial.list());
  Serial arduino = new Serial(this, Serial.list()[32], 9600);
  arduino.bufferUntil('\n');

  fullScreen(FX2D, SPAN);
  frameRate(10);

  regen = new WhiteNoise(this);
  regen.play();
}

void draw() {
  blitz();
  regen();
}

void blitz() {
  float zufallsZahl = random(MAXIMUM * 80);
  if (zufallsZahl < schieberegler) {
    background(255);
    // Ansatz für zwei Bildschirme
    //fill(255);
    //rect(1680, 0, 2704, 768);
    donner();
  } else {
    background(0);
  }
}

void donner() {
  SoundFile file = new SoundFile(this, "Donner.wav");
  float RATE = 1;
  float volume = map(schieberegler, MINIMUM, MAXIMUM, 0, 1);
  file.play(RATE, volume);
}

void regen() {
  float volume = map(schieberegler, MINIMUM, MAXIMUM, 0, 1);
  regen.amp(volume);
}

void serialEvent(Serial arduino) {
  String rawString = arduino.readString();
  //println(rawString);
  if (rawString != null) {
    schieberegler = int(Float.parseFloat(rawString));
  }
}