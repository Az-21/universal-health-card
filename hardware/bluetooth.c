/*This is arduino sample code
 * for ON - OFF example.
 */

//Ports to be used
int PORT_5 = 5;
int PORT_6 = 6;
int PORT_7 = 7;
int PORT_8 = 8;

// put your setup code here, to run once:
void setup()
{
    Serial.begin(9600); //set baud rate for port

    //initialize pins as outpouts
    pinMode(PORT_5, OUTPUT);
    pinMode(PORT_6, OUTPUT);
    pinMode(PORT_7, OUTPUT);
    pinMode(PORT_8, OUTPUT);

    //set all ports to LOW state
    digitalWrite(PORT_5, LOW);
    digitalWrite(PORT_6, LOW);
    digitalWrite(PORT_7, LOW);
    digitalWrite(PORT_8, LOW);

} //end of function setup

char terminalRead; //variable to store the data which is being read

// put your main code here, to run repeatedly:
void loop()
{

    if (Serial.available() > 0)
    { //check if Arduino board receives data from terminal

        terminalRead = Serial.read(); //store received data to variable
        delay(2);                     //give some time gape, 2ms

        if (terminalRead == '1')
        {                                //when we read character '1', do the following
            digitalWrite(PORT_5, HIGH);  //turn on PORT_5
            Serial.println("PORT_5 on"); //print the message 'PORT_5 on' at console
        }

        else if (terminalRead == 'a')
        {                                 //when we read character 'a', do the following
            digitalWrite(PORT_5, LOW);    //turn off PORT_5
            Serial.println("PORT_5 off"); //print the message 'PORT_5 off' at console
        }

        else if (terminalRead == '2')
        {                                //when we read character '2', do the following
            digitalWrite(PORT_6, HIGH);  //turn on PORT_6
            Serial.println("PORT_6 on"); //print the message 'PORT_6 on' at console
        }

        else if (terminalRead == 'b')
        {                                 //when we read character 'b', do the following
            digitalWrite(PORT_6, LOW);    //turn off PORT_6
            Serial.println("PORT_6 off"); //print the message 'PORT_6 off' at console
        }

        else if (terminalRead == '3')
        {                                //when we read character '3', do the following
            digitalWrite(PORT_7, HIGH);  //turn on PORT_7
            Serial.println("PORT_7 on"); //print the message 'PORT_7 on' at console
        }

        else if (terminalRead == 'c')
        {                                 //when we read character 'c', do the following
            digitalWrite(PORT_7, LOW);    //turn off PORT_7
            Serial.println("PORT_7 off"); //print the message 'PORT_7 off' at console
        }

        else if (terminalRead == '4')
        {                                //when we read character '4', do the following
            digitalWrite(PORT_8, HIGH);  //turn on PORT_8
            Serial.println("PORT_8 on"); //print the message 'PORT_8 on' at console
        }

        else if (terminalRead == 'd')
        {                                 //when we read character 'd', do the following
            digitalWrite(PORT_8, LOW);    //turn off PORT_8
            Serial.println("PORT_8 off"); //print the message 'PORT_8 off' at console
        }

    } //end of if

} //end of function loop