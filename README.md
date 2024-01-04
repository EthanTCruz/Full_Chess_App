"# Full-Chess-App" 

## Description
My attempt at a full stack chess app using Sveltekit, Fast API and Redis. Application is capable of multiplayer and single player gameplay. 





## How to Start
1. Open a terminal and navigate to the `Sveltekit-Chess\frontend` directory and run:
```bash
npm install

npm run dev
```
2. Open another terminal and run:
```bash
pip install -r .\Chess_Model\requirements.txt
python -m uvicorn Chess_Model.src.api.main:app --host 127.0.0.1 --port 8001
```
3. Open one more terminal and run:
```bash
pip install -r .\Sveltekit_Chess\requirements.txt
python -m uvicorn Sveltekit_Chess.backend.api.src.main:app --host 127.0.0.1 --port 8000
```
## How to use

### Multiplayer Gameplay
To use the multiplayer gameplay, login or click new user to sign in with a user profile. Next hit play game and wait for another player to join. But since this is still in development, to check out multiplayer gameplay open a new browser window with a different profile (so local storages don't overlap), and follow the same previous steps to test out the gameplay.

## Single Player Gameplay
To play against a computer, navigate to the url where the app is hosted (typically with Sveltekit it will be `http://localhost:5173/`) and login or click new user to get into the application. Next hit the `Play Computer` button to navigate to a page where you can play against my chess ai.

