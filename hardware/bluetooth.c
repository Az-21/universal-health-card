//program to send data via bluetooth

String text;

void setup()
{
  // initial setup code to initialize the pinMode and begin serial 
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  // put your main code here, to run repeatedly:
  while (Serial.available())
  {
    delay(10);
    char c = Serial.read();
    text += c;
  }
  if (text.length() > 0)
  {
    Serial.println(text);
    text = "";
  }
}