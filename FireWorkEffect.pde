class FireWorkEffect {
  long start_time=0;
  int start_size=32;
  int current_size=32;//円の部分は除いて、台形っぽい部分だけ
  int end_size=60;
  int x=580;
  int y=308;

  //寿命140ミリ秒

  FireWorkEffect() {
    this.start_time=System.currentTimeMillis();
  }

  void display() {
    long current_time=System.currentTimeMillis();
    
    if(current_time>this.start_time+140)return;
    
    this.current_size=this.start_size+(this.end_size-this.start_size)*int(current_time-this.start_time)/140;
    
    pushMatrix();
    translate(this.x, this.y);
    for (int d=0; d<360; d+=12) {
      pushMatrix();
      rotate(radians(d));

      translate(0, 42);//判定部分に被らないようにする

      color c1=color(255, 255, 0, 150+(this.end_size-this.current_size)*3);
      color c2=color(255, 70, 0, 50+(this.end_size-this.current_size)*3);
      int start_len=2;
      float end_len= this.current_size/9.0;
      for (float w=0; w<this.current_size; w++) {
        color c=lerpColor(c1, c2, w/this.current_size);
        fill(c);
        beginShape();
        vertex(-start_len-(end_len-start_len)*w/this.current_size, w);
        vertex(-start_len-(end_len-start_len)*(w+1)/this.current_size, w+1);
        vertex(start_len+(end_len-start_len)*(w+1)/this.current_size, w+1);
        vertex(start_len+(end_len-start_len)*w/this.current_size, w);
        endShape(CLOSE);
      }
      
      fill(255,60,0,40+(this.end_size-this.current_size)*3);
      ellipse(0,this.current_size+6,this.current_size/5,this.current_size/5);
      
      fill(255,50,0,35+(this.end_size-this.current_size)*3);
      ellipse(0,this.current_size+15,this.current_size*3/10,this.current_size*3/10);
      
      fill(255,40,0,30+(this.end_size-this.current_size)*3);
      ellipse(0, this.current_size+27, this.current_size*2/5, this.current_size*2/5);
      
      popMatrix();
    }
    popMatrix();
  }
}