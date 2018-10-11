void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(8, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
if(Serial.available())
{
  int i =Serial.read();
  if(i==1)
  {
    digitalWrite(8, HIGH);
    delay(1000);
    digitalWrite(8, LOW);
    delay(1000);
    digitalWrite(8, HIGH);
    delay(1000);
    digitalWrite(8, LOW); 
    
  }
}
}
