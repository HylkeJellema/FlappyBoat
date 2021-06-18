import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FlappyBoat extends PApplet {

// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md


MainEnviroment mainEnviroment;

public void setup() {
    
    mainEnviroment = new MainEnviroment();
}

public void draw() {
    mainEnviroment.update(
        new PVector(mouseX,mouseY), //passes mouse cords
        new PVector(width,height)   //passes screen size
    );
}
class GameEnviroment{

    MainEnviroment mainRef;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
    }

    public void update(PVector mouse, PVector screenSize){
 
    }

    public void render(){

    }
}
class GameOverEnviroment{

    GameOverEnviroment(){
        
    }

    public void update(PVector mouse, PVector screenSize){
 
    }

    public void render(){

    }
}
class HighScoreEnviroment{

    HighScoreEnviroment(){
        
    }

    public void update(PVector mouse, PVector screenSize){
 
    }

    public void render(){

    }
}
class MainEnviroment{

    int state; //shows state of game 
    final int MENU_PAGE = 1; //stages
    final int GAME_PAGE = 2; 
    final int SCORE_PAGE = 3; 
    final int GAMEOVER_PAGE = 4;
    MenuEnviroment menu;
    GameEnviroment game;
    

    MainEnviroment(){
        state = MENU_PAGE;
        menu = new MenuEnviroment(this); //passing main screen as object to states can be changed.
        game = new GameEnviroment(this);
    }

    public void update(PVector mouse, PVector screenSize){
        switch (state) { //all states and there methods

            case MENU_PAGE:
            menu.update(mouse, screenSize);
            menu.render();
            break;

            case GAME_PAGE:
            game.update(mouse, screenSize);
            game.render();
            break;

        }
    }

    public void setState(int state){
        this.state = state;
    }
}
class MenuEnviroment{

    MainEnviroment mainRef;
    Movie backgroundWater;

    MenuEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        backgroundWater = new Movie(this, "water.mp4");
        backgroundWater.loop();
    }

    public void update(PVector mouse, PVector screenSize){
        
    }

    public void render(){
        image(backgroundWater,0,0);
    }

    public void movieEvent(Movie m) {
        m.read();
    }
}
  public void settings() {  size(1400,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FlappyBoat" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
