import processing.net.*;
int startTime=0;
boolean blinkLatch;
int port = 8080;       
Server myServer;        
PrintWriter output;
//String[] timeStamp;
void setup()
{
  size(1200, 800);
  output = createWriter("data.txt"); 
  myServer = new Server(this, port);
}

void draw()
{
  background(0);

  // Get the next available client
  Client thisClient = myServer.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    String[] writeString = split(whatClientSaid, ' ');
    if (whatClientSaid != null) {
      background(0);
      println("data from: " + thisClient.ip());
      println("input= " + whatClientSaid);
      fill(#FC3908);
      textSize(70);
      text(whatClientSaid, 60, 400);
      // saveStrings("data.txt",writeString);
      String timeStamp = (month()+"/"+ day()+"/"+year()+","+hour()+":"+minute()+":"+second()+",");
      output.print(timeStamp);
      output.println(whatClientSaid);
      output.flush(); // Writes the remaining data to the file
      // output.close(); // Finishes the file
    }
  }
  pressButton();
  statusBox();
  upperTemp();
  lowerTemp();
  startCycle();
}
void pressButton()
{
  fill(#BED5E8);
  rect(445, 25, 250, 100, 30);
  fill(#FC3908);

  textSize(70);
  text("Press 1", 445, 100);
}
void statusBox()
{
  textSize(35);

  fill(#F7640F);
  text("Status Codes", 455, 690);
  rect(0, 700, 1200, 100);
  text("Status Codes", 455, 690);
  textSize(35);
  fill(#BED5E8);
  text("UpperHeat=off, LowerHeat=off, UpperTemp=78, lowerTemp=78", 10, 750);
}
void upperTemp()
{
  fill(#F2620F);
  rect(25, 145, 250, 100, 30);
  fill(#BED5E8);

  textSize(35);
  text("UpperTemp", 50, 190);
}
void lowerTemp()
{
  fill(#F2620F);
  rect(425, 145, 250, 100, 30);
  fill(#BED5E8);

  textSize(35);
  text("LowerTemp", 450, 190);
}

void startCycle()
{
  if (millis()-startTime>1000)
  {
    blinkLatch=!blinkLatch;
    startTime=millis();
  }
  if (blinkLatch==true)
  {
    fill(#F00C1F);
    rect(750, 145, 350, 200, 30);
    fill(#BED5E8);
    textSize(35);
    text("Start Cycle", 825, 190);
  }
  if (blinkLatch==false)
  {
    fill(#F2620F);
    rect(750, 145, 350, 200, 30);
 
  }
  textSize(35);
    text("Start Cycle", 825, 190);
}
