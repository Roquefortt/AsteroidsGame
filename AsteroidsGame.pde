//your variable declarations here
public int rectX;
public int count;
Star[] nightsky = new Star[200];
ArrayList <Asteroids> asteroid = new ArrayList <Asteroids>();
ArrayList <Bullet> bullets = new ArrayList <Bullet>();
SpaceShip ship;

public void setup() 
{
  size(500,500);
  ship = new SpaceShip();

  for (int i = 0; i < nightsky.length; i++)
  {
    nightsky[i] = new Star();
  }

  for(int i = 0; i < 30; i++)
  {
    asteroid.add(new Asteroids());
  }

  for(int i = 0; i < 3; i++)
  {
    bullets.add(new Bullet(ship));
  }

}

public void draw() 
{
  background(0);
  count = 0;

  for (int i = 0; i < nightsky.length; i++)
  {
    nightsky[i].show();
  }

  for(int i = 0; i < asteroid.size(); i++)
  {
      asteroid.get(i).show();
      asteroid.get(i).move();

      float d = dist(ship.getX(), ship.getY(), asteroid.get(i).getX(), asteroid.get(i).getY());

      if(d < 20)
      {
        asteroid.remove(i);
        rectX -= 5;
        //count++;
      }
}


 /* for(int i = 0; i < bullets.size(); i++)
    {
      //bullets.get(i).show();
      if(get( ??????????????????? ))
      {
        asteroid.get(i).remove();
        bullets.get(i).remove();
      }
    }
*/

  ship.show();
  ship.move();
  ship.display();

  if(rectX < -95)
  {
      fill(255);
      textSize(20);
      textAlign(CENTER);
      text("Game Over", 250, 250);
      noLoop();
  }  

  if (count == asteroid.size())
  {
      text("You win!", 250, 250);
  }
}

  public void mouseClicked()
  {
      for(int i = 0; i < bullets.size(); i++)
      {
          //shoot bullets
          bullets.get(i).show();
          bullets.get(i).move();
      }
  }

  public void keyPressed()
  {
    //move. accelerate in direction it's pointing
    if (key == 'w' || key == 'W')
    {
      double dRadians = ship.getPointDirection()*(Math.PI/180);
      ship.myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
      ship.myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();

      ship.move();
      ship.accelerate(dRadians*(Math.PI/180));
    }

    //rotate left
    else if (key == 'a' || key == 'A')
    {
      ship.rotate(-5);
    }    

    //rotate right
    else if (key == 'd' || key == 'D')
    {
      ship.rotate(5);
    }

    //hyperspace
    if (key == 'f' || key == 'F')               
    {
      ship.setX((int)(Math.random()*501));
      ship.setY((int)(Math.random()*501));
      ship.setPointDirection((int)(Math.random()*361));
      ship.setDirectionX(0);
      ship.setDirectionY(0);
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
    myColor = color(194, 202, 205);
    xCorners = xS;
    yCorners = yS;

    myCenterX = 250;
    myCenterY = 250;

    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

  //Display + Health Bar
  public void display()
  {
    //Display
    text("myPointDirection: "+ myPointDirection, 20, 435);
    text("myCenterX: "+ myCenterX, 20, 445);
    text("myCenterY: "+ myCenterY, 20, 455);
    text("myDirectionX: "+ myDirectionX, 20, 465);
    text("myDirectionY: "+ myDirectionY, 20, 475);
    //text("Asteroids Destroyed: "+ count, 20, 485);

    //Health Bar
    fill(0,255,0);
    noStroke();
    text("HP", 10, 20);
    rect(rectX,25,110,7);
    fill(0);
    rect(0,25,10,7);

    //outline of the health bar
    stroke(255);
    noFill();
    rect(10,25,100,7);
  }

  //finished abstact methods
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
    myX = (int)(Math.random()*501);
    myY = (int)(Math.random()*501);
  }

  public void show()
  {
    noStroke();
    fill(255, 249, 170);
    text("*", myX, myY);
  }
}

class Asteroids extends Floater
{
  private int rotSpeed;
  public Asteroids()
  {
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -11;
    yCorners[0] = -8;
    xCorners[1] = 7;
    yCorners[1] = -8;
    xCorners[2] = 13;
    yCorners[2] = 0;
    xCorners[3] = 6;
    yCorners[3] = 10;
    xCorners[4] = -11;
    yCorners[4] = 8;
    xCorners[5] = -5;
    yCorners[5] = 0;

    myColor = color(120);
    rotSpeed = (int)(Math.random()*5)-1;
    myCenterX = (int)(Math.random()*501);
    myCenterY = (int)(Math.random()*501);
    myDirectionX = (int)(Math.random()*3)-.5;
    myDirectionY = (int)(Math.random()*3)-.5;
    myPointDirection = 1;
    }

    public void move()
    {
        rotate(rotSpeed);
        super.move();
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

class Bullet extends Floater
{
  Bullet(SpaceShip theShip)
  {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();
  }

  void show()
  {
    noStroke();
    fill(255, 0, 0);
    rect(ship.getX(), ship.getY(), 10, 5);
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
