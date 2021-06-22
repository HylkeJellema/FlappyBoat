class MainEnviroment {

  int state; //shows current state of game 
  final int MENU_PAGE = 1; //stages
  final int GAME_PAGE = 2; 
  final int GAMEOVER_PAGE = 3; 
  MenuEnviroment menu; //all state enviroments
  GameEnviroment game;
  GameOverEnviroment gameOver;
  PApplet app; 

  MainEnviroment(PApplet app) {
    this.app=app;
    state = MENU_PAGE; // first state
    menu = new MenuEnviroment(this); //passing main screen as object so states can be changed.
    game = new GameEnviroment(this);
    gameOver = new GameOverEnviroment(this, game); //passing game for score
  }

  void update(PVector mouse) {

    switch (state) { //all states and there methods

    case MENU_PAGE:
      menu.update(mouse);
      menu.render();
      break;

    case GAME_PAGE:
      game.update();
      game.render();
      break;

    case GAMEOVER_PAGE:
      gameOver.update();
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
    switch (state) { //pass mouse event

    case MENU_PAGE:
      menu.mousePressedEvent();
      break;

    case GAME_PAGE:
      game.mousePressedEvent();
      break;
    }
  }
}
