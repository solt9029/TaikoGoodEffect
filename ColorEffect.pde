class ColorEffect {
  long start_time=0;

  ColorEffect() {
    this.start_time=System.currentTimeMillis();
  }

  void display() {
    long current_time=System.currentTimeMillis();

    if (current_time>this.start_time+150){
      return;
    }

    noStroke();
    
    color c1 = color(255, 255, 0, 120);
    color c2 = color(255, 0, 0, 20);
    
    if (current_time>this.start_time+100) {
      c1 = color(255, 255, 0, 200-(current_time-start_time));
      c2 = color(255, 0, 0, 120-(current_time-start_time));
    }
    
    for (float w = 0; w < width-600; w += 1) {
      color c = lerpColor(c1, c2, w / (width-600));
      fill(c);
      rect(w+500, height/2, 1, height/2-60);
    }
  }
  
}