class circleProperties{
  public float X = 0;
  public float Y = 0;
  public float yOffset = 0;
  public float xOffset = 0;
  public float speed = 0;
}
final public static int circleProx = 250;
final public static int backgroundShade = 61;
final public static float minSpeed = 0.05;
final public static float maxSpeed = 0.4;
public static float redMultiplier = 1;
public static float blueMultiplier = 1;
public static float greenMultiplier = 1;
public static float rainbowMult = 1; //Will only change starting hue
final public static float rainbowSpeed = 0.005;
final public static boolean isRainbow = true;
public static float lineStrokeC = (float)255/circleProx;
public circleProperties[] circleLocations = new circleProperties[180]; //change this value to change the amount of circles
void setup(){
  background(backgroundShade);
  stroke(255);
  fullScreen();
  frameRate(120);
  randomSeed(System.nanoTime());
   for(int x = 0; x < circleLocations.length; x++){
      circleLocations[x] = generateNew();
      circleLocations[x].X = random(0, displayWidth);
      circleLocations[x].Y = random(0, displayHeight);
    }
}
void draw(){
  //Redraw the entire frame cus I don't know better
  background(backgroundShade);
  for(int x = 0; x < circleLocations.length; x++){
    if(circleLocations[x] == null || circleLocations[x].X > displayWidth + 3 || circleLocations[x].Y > displayHeight + 3 || circleLocations[x].X < -3 || circleLocations[x].Y < -3){
      circleLocations[x] = generateNew();
    }
    circleLocations[x].X += circleLocations[x].xOffset;
    circleLocations[x].Y += circleLocations[x].yOffset;
  }
  if(isRainbow){
    rainbowMult += rainbowSpeed;
    if(rainbowMult >= 5){
      rainbowMult = 0;
    }
    if(rainbowMult < 1) {
      redMultiplier -= rainbowSpeed;
    }
    else if(rainbowMult < 2){
      redMultiplier = rainbowMult;
    }
     else if(rainbowMult < 3) {
       blueMultiplier = rainbowMult - 1;
       redMultiplier -= rainbowSpeed;
     } else if(rainbowMult < 4) {
       greenMultiplier = rainbowMult - 2;
       blueMultiplier -= rainbowSpeed;
     } else if (rainbowMult < 5) {
       redMultiplier = rainbowMult - 3;
       greenMultiplier -= rainbowSpeed;
     }
  }
  //Now that all the circles have their new location, we can draw the connecting lines
  for(int x = 0; x < circleLocations.length - 1; x++){
    for(int y = x + 1; y < circleLocations.length; y++){
      if(makePositive((circleLocations[x].X - circleLocations[y].X)) + makePositive((circleLocations[x].Y - circleLocations[y].Y)) < circleProx){
        float lineColour = (
        (
        (255 - ((float)((makePositive((int)(circleLocations[x].X - circleLocations[y].X)) + makePositive((int)(circleLocations[x].Y - circleLocations[y].Y)))) * lineStrokeC))
        )
        );
        stroke(lineColour * redMultiplier + backgroundShade, lineColour * blueMultiplier + backgroundShade, lineColour * greenMultiplier + backgroundShade);
        line(circleLocations[x].X, circleLocations[x].Y, circleLocations[y].X, circleLocations[y].Y);
      }
    }
  }
  stroke(255);
  for(int x = 0; x < circleLocations.length; x++){
    ellipse(circleLocations[x].X, circleLocations[x].Y, 5, 5);
  }
  
}
circleProperties generateNew(){
  randomSeed(System.nanoTime());
  circleProperties returnVal = new circleProperties();
  float ranVal = random(0,4);
  randomSeed(System.nanoTime());
  float angle = 0;
  switch(int(ranVal)) {
  case 0:
    returnVal.X = 0;
    returnVal.Y = random(0, displayHeight);
    angle = (270 + random(25, 155));
    break;
  case 1:
    returnVal.X = random(0, displayWidth);
    returnVal.Y = 0;
    angle = random(25, 155);
    break;
  case 2:
    returnVal.X = displayWidth;
    returnVal.Y = random(0, displayHeight);
    angle = (90 + random(25, 155));
    break;
  default:
    returnVal.X = random(0, displayWidth);
    returnVal.Y = displayHeight;
    angle = (180 + random(25, 155));
    break;
  }

  randomSeed(System.nanoTime());
  returnVal.speed = random(minSpeed,maxSpeed);
      //Now for some maths :)))
    float theta = (float)(angle * Math.PI / 180);
    //Getting the theta of the value from the angle in the array
    returnVal.xOffset = returnVal.speed * cos(theta);
    returnVal.yOffset = returnVal.speed * sin(theta);
    //Using said theta to translate the angle into an offset coordinate
  return returnVal;
}
int makePositive(int value){
  int returnVal = value;
  if(returnVal > 0){
    return returnVal; 
  }
  else {
    return returnVal - returnVal * 2;
  }
}
float makePositive(float value){
  float returnVal = value;
  if(returnVal > 0){
    return returnVal; 
  }
  else {
    return returnVal - returnVal * 2;
  }
}
