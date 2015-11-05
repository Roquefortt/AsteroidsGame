//your variable declarations here
Star[] nightsky = new Star[200];
SpaceShip ship;

public void setup() 
{
  size(500,500);
  ship = new SpaceShip();

  for (int i = 0; i < nightsky.length; i++)
  {
    nightsky[i] = new Star();
  }

}

public void draw() 
{
  background(0);

  ship.show();
  ship.keyPressed();
  ship.move();
  //ship.accelerate();

  for (int i = 0; i < nightsky.length; i++)
  {
    nightsky[i].show();
  }

}

class SpaceShip extends Floater  
{   
  //your code here
  public SpaceShip()
  {
    corners = 4;
    int[] xS = {-8,16,-8,-2};
    int[] yS = {-8,0,8,0}; 
    myColor = color(255);
    xCorners = xS;
    yCorners = yS;

    myCenterX = 250;
    myCenterY = 250;

    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }


//set everything later
  public void keyPressed()
  {
    //move up
    if (key == 'w' || key == 'W')
    {
      myCenterY -= 2;    
      myPointDirection = 270;   
      myDirectionY = myDirectionY + (.1)*sin(50);   
      //rotate(myPointDirection);
    }

    //move down
    else if (key == 's' || key == 'S')
    {
      myCenterY += 2;   
      myPointDirection = 90; 
      myDirectionY = myDirectionY + (.1)*sin(-50); 
    }

    //move left
    else if (key == 'a' || key == 'A')
    {
      myCenterX -= 2; 
      myPointDirection = 180;  
      myDirectionX = myDirectionX - (.1)*cos(50);
    }    

    //move right
    else if (key == 'd' || key == 'D')
    {
      myCenterX += 2; 
      myPointDirection = 0;   
      myDirectionX = myDirectionX + 0.1*cos(-50);
    }

    //hyperspace
    if (key == 'f' || key == 'F')                 //FIX
    {
      ship.setX((int)(Math.random()*500));
      ship.setY((int)(Math.random()*500));
      ship.setDirectionX(0);
      ship.setDirectionY(0);
    }

//Display
    text("myPointDirection: "+ myPointDirection, 20, 25);
    text("myCenterX: "+ myCenterX, 20, 35);
    text("myCenterY: "+ myCenterY, 20, 45);
    text("myDirectionX: "+ myDirectionX, 20, 55);
    text("myDirectionY: "+ myDirectionY, 20, 65);
  }

  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}   
  public void setY(int y){myCenterY = y;}  
  public int getY(){return (int)myCenterY;} 
  public void setDirectionX(double x){myDirectionX = x;}  
  public double getDirectionX(){return myDirectionX;}    
  public void setDirectionY(double y){myDirectionY = y;} 
  public double getDirectionY(){return myDirectionY;} 
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}

class Star
{
  private int myX, myY;
  public Star()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }

  public void show()
  {
    noStroke();
    fill(255, 249, 170);
    text("*", myX, myY);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
