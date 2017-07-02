int don_x=1680;
int don_y=308;

boolean is_hit=false;


void setup(){
  size(1680,450);//6.7cmが450くらい67pixel
}

void draw(){
  background(255);
  
  don_x-=3;
  
  drawBar();
  drawJudgeMark();
  
  drawDon(don_x,don_y);
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

void drawDon(int x, int y){
  stroke(0);
  strokeWeight(5);
  fill(246);
  ellipse(x,y,87,87);
  
  noStroke();
  fill(234,61,22);
  ellipse(x,y,66,66);
  
  fill(10,0,0);
  ellipse(x-18,y-5,16,16);
  
  fill(10,0,0);
  ellipse(x+18,y-5,16,16);
  
  stroke(0);
  strokeWeight(3);
  noFill();
  bezier(x,y+10,x+5,y+15,x+10,y+15,x+15,y+10);
  bezier(x,y+10,x-5,y+15,x-10,y+15,x-15,y+10);
}