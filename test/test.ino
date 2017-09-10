void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode (A0, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int value = map(analogRead(A0), 0, 1023, 0, 100);
  Serial.println(value);
  delay(100);
}

