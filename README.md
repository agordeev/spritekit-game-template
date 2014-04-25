This project contains an initial structure of Sprite Kit game.
Includes the following:

- GameSceneController, which operates SKView, SKScene, loading screen (SKScene), handles scaling for iPhone screen resolution
- iPhone/iPad storyboards with views and outlets to GameSceneViewController
- GameScene has predefined layers: background and ui. You should add more layers to keep the structure clean and easy to scale.
- GameScene has a very useful mechanism of asyncronous loading of game assets (taken from Apple's Adventure game)
