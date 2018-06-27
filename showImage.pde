
import processing.serial.*;

Serial myPort;      
float step=8;
int[][] img=new int[30][40];
int success = 0;
byte[] inBuffer = new byte[1000];
final String flagx = "#";
void setup() 
{
  size(400, 400);
  background(12, 12, 12);
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 115200);
  frameRate(50);
}


void draw()
{
  //println("frameRate"+frameRate);
  if (success  == 1)
  {
    success = 0;
    for (int i=0; i<30; i++) {
      for (int j=0; j<30; j++) {
        fill(img[i][j]);
        rect(height/2-15*step+i*step, width/2-15*step+j*step, step, step);
      }
    }
  }// else println("err!");
  if (myPort.available() > 0) {

    myPort.readBytesUntil('#', inBuffer);

    int index = 0;
    for (int m=0; m<30; m++)
      for (int n=29; n>=0; n--, index++)
        img[n][m] = int(inBuffer[index]);
        
    success = 1;
  }
}
