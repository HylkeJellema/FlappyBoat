import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
    mainEnviroment.render();
}
class GameEnviroment{

    GameEnviroment(){
        
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
    int MENU_PAGE = 1; int GAME_PAGE = 2; int SCORE_PAGE = 3; int GAMEOVER_PAGE = 4; //stages
    MenuEnviroment menu;
    GameEnviroment game;
    

    MainEnviroment(){
        state = MENU_PAGE;
        menu = new MenuEnviroment();
        game = new GameEnviroment();
    }

    public void update(PVector mouse, PVector screenSize){
        switch (state) {

            case MENU_PAGE:
            menu.update(this, mouse, screenSize);
            menu.render();
            break;

            case GAME_PAGE:
            game.update(this, mouse, screenSize);
            game.render();
            break;

        }
    }
}
class MenuEnviroment{

    MenuEnviroment(){
        
    }

    public void update(PVector mouse, PVector screenSize){
 
    }

    public void render(){

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
