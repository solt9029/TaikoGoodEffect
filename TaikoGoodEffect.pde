ColorEffect color_effect;
Don don;
Good good;
FireWorkEffect fire_work_effect;

void setup(){
  size(1680,450);//6.7cmが450くらい67pixel
  don=new Don();
  fire_work_effect=new FireWorkEffect();
}

void draw(){
  background(255);
  
  drawBar();
  drawJudgeMark();
  
  if(580>don.current_x){
    don.hit();
    if(color_effect==null){
      color_effect=new ColorEffect();
      good=new Good();
    }
  }

  if(color_effect!=null){
    color_effect.display();
  }
  
  if(good!=null){
    good.display();
  }
  
  fire_work_effect.display();
  
  don.display();
  
}

void drawBar(){
  stroke(0);
  strokeWeight(12);
  fill(50,47,50);
  rect(0,height/2,width*2,height/2);
  
  strokeWeight(6);
  fill(234,61,22);
  rect(0,height/2,500,height/2);
  
  strokeWeight(6);
  fill(246);
  rect(500,height-60,width,60);
}

void drawJudgeMark(){
  stroke(107,104,107);
  noFill();
  strokeWeight(3);
  ellipse(580,308,135,135);
  
  
  noStroke();
  fill(140,137,140);
  ellipse(580,308,92,92);
  
  fill(50,47,50);
  ellipse(580,308,85,85);
  
  noStroke();
  fill(96,93,96);
  ellipse(580,308,60,60);
}