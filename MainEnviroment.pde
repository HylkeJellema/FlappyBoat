class MainEnviroment {

  int state; //shows state of game 
  final int MENU_PAGE = 1; //stages
  final int GAME_PAGE = 2; 
  final int SCORE_PAGE = 3; 
  final int GAMEOVER_PAGE = 4;
  MenuEnviroment menu;
  GameEnviroment game;
  GameOverEnviroment gameOver;
  PApplet app;

  MainEnviroment(PApplet app) {
    this.app=app;
    state = MENU_PAGE;
    state = GAME_PAGE;
    state = GAMEOVER_PAGE;
    menu = new MenuEnviroment(this); //passing main screen as object to states can be changed.
    game = new GameEnviroment(this);
    gameOver = new GameOverEnviroment(this);
  }

  void update(PVector mouse) {

    switch (state) { //all states and there methods

    case MENU_PAGE:
      menu.update(mouse);
      menu.render(mouse);
      break;

    case GAME_PAGE:
      game.update(mouse);
      game.render();
      break;

    case GAMEOVER_PAGE:
      gameOver.update(mouse);
      gameOver.render();
      break;
      
      
    }
  }

  void setState(int i) { //to set a stage
    state = i;
  }

  PApplet getApp() { //receive main class as object method
    return app;
  }

  void mousePressedEvent() {
    switch (state) { //pass mosue event

    case MENU_PAGE:
      menu.mousePressedEvent();
      break;

    case GAME_PAGE:
      game.mousePressedEvent();
      break;
    }
  }
}
