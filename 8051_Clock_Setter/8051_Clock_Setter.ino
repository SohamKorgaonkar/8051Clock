#include <NTPClient.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

int hf;
int mf;
int i;
int j;
char k;

const char *ssid     = "SK WIFI";
const char *password = "soham@2000";

const long utcOffsetInSeconds = 19800;

char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", utcOffsetInSeconds);

void setup(){
  Serial.begin(9600);

  WiFi.begin(ssid, password);

  while ( WiFi.status() != WL_CONNECTED ) {
    delay ( 500 );
    Serial.print ( "." );
    pinMode(D1,OUTPUT);
    pinMode(D2,OUTPUT);
    pinMode(D3,OUTPUT);
    digitalWrite(D1,1);
    digitalWrite(D2,1);
    digitalWrite(D3,0);
  }

  timeClient.begin();
}

void loop() {
  if(Serial.available()>0){
    k=Serial.read();
    Serial.println(k);
    if(k=='A'){
    timeClient.update();
    hf=timeClient.getHours();
    mf=timeClient.getMinutes();
    digitalWrite(D3,1);
    delay(100);
    digitalWrite(D3,0);
    delay(1000);
    for(i=0;i<mf;i++){
    digitalWrite(D1,LOW);
    delay(100);
    digitalWrite(D1,HIGH);
    delay(100);
    }
    Serial.println(hf);
    for(i=0;i<hf;i++){
    digitalWrite(D2,LOW);
    delay(500);
    digitalWrite(D2,HIGH);
    delay(500);
    }
    Serial.println("Done Setting");
    Serial.println(hf);
  }
  }
  

}
