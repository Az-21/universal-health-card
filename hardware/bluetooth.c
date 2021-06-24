//program for sharing data through bluetooth

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
    text = "";
  }
}