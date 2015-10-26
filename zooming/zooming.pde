import processing.video.*;
import java.awt.*;

Capture video;
int screenWidth = 640;
int screenHeight = 480;
float numOfSteps = 10;
float counter = numOfSteps;

void setup () {
  size(screenWidth, screenHeight);
  video = new Capture(this, screenWidth, screenHeight);
  video.start();
}

void draw () {
  if (video.available() == true) {
    video.read();
  
    if (counter > 0) {
      counter -= 0.05;
    } else {
      counter = numOfSteps;
    }

    float scale = counter / numOfSteps;

    int scaledFrameWidth = (int)(scale * screenWidth);
    int scaledFrameHeight = (int)(scale * screenHeight);
    int newX = (screenWidth - scaledFrameWidth) / 2;
    int newY = (screenHeight - scaledFrameHeight) / 2;

    tint(255, 20);
    image(video, newX, newY, scaledFrameWidth, scaledFrameHeight);
    
  }
}
