import processing.serial.*;
import processing.sound.*;

int schieberegler = 0;
int MAXIMUM = 100;
int MINIMUM = 0;

int BEAMER_X = 1680;
int BEAMER_Y = 1050;
int DISPLAY_X = 1024;
int DISPLAY_Y = 768;

int GRENZWERT_BEAMER = 70;

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
  float zufallsZahl;
  if (schieberegler > GRENZWERT_BEAMER) { 
    zufallsZahl = random(MAXIMUM * 30);
  } else {
    zufallsZahl = random(MAXIMUM * 80);
  }
  if (zufallsZahl < schieberegler) {
    if (schieberegler > GRENZWERT_BEAMER) {
      blitzBeamer();
    } else {
      blitzDisplay();
    }
    donner();
  } else {
    background(0);
  }
}

void blitzDisplay() {
  fill(255);
  rect(BEAMER_X, 0, DISPLAY_X, DISPLAY_Y);
}

void blitzBeamer() {
  fill(255);
  rect(0, 0, BEAMER_X, BEAMER_Y);
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