//program for bluetooth controlled led

String text;

void setup()
{
  // put your setup code here, to run once:
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

    if (text == "on")
    {
      digitalWrite(13, HIGH);
      Serial.println("PORT is on");
    }
    if (text == "off")
    {
      digitalWrite(13, LOW);
      Serial.println("PORT is off");
    }
    text = "";
  }
}