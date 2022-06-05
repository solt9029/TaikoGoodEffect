class Good{
  int start_x=318;
  int start_y=300;
  int current_x=318;
  int current_y=300;
  int end_x=318;
  int end_y=270;
  int speed=10;
  PImage image;
  
  long start_time;
  
  float alpha=255;//transparency rate
  
  Good(){
    this.image=loadImage("good.png");
    this.start_time=System.currentTimeMillis();
  }
  
  void display(){
    long current_time=System.currentTimeMillis();
    
    if(current_time<this.start_time+140){
      this.current_y=int(this.start_y+(this.end_y-this.start_y)*(current_time-this.start_time)/(float)140);
    }else if(current_time<this.start_time+280){
      this.current_y=this.end_y;
    }else if(current_time<this.start_time+510){
      this.alpha=255-(current_time-this.start_time-280)*(float)255/230;
    }else{
      this.alpha=0;
    }
    
    tint(255,255,255,this.alpha);
    image(this.image,this.current_x,this.current_y, 200, 200);
  }
  
}
