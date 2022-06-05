//3-4-24塩出研史 <http://solt9029.com>
//太鼓の達人のアニメーションのパラメータを測定し忠実に再現するプログラム

import ddf.minim.*;

import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;

ColorEffect color_effect;
Don don;
Good good;
FireWorkEffect fire_work_effect;

Minim minim;

void setup(){
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  JFrame jframe = (JFrame)smoothCanvas.getFrame();
  jframe.dispose();
  jframe.setUndecorated(true);
  jframe.setOpacity(.5f);
  jframe.setVisible(true);
  
  minim=new Minim(this);
  size(1680,450);

  don=new Don();
}

void draw(){
  background(255);
  
  drawBar();
  drawJudgeMark();
  
  //自動的にどんが飛んでいくようにする
  if(580>don.current_x && don.is_hit==false){
    don.hit();
    if(color_effect==null){
      color_effect=new ColorEffect();
      good=new Good();
      fire_work_effect=new FireWorkEffect();
    }
  }

  if(color_effect!=null){
    color_effect.display();
  }
  
  if(good!=null){
    good.display();
  }
  
  if(fire_work_effect!=null){
    fire_work_effect.display();
  }
  
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

void keyPressed(){
  if(don.current_x>560 && don.current_x<600 && don.is_hit==false){
    don.hit();
    if(color_effect==null){
      color_effect=new ColorEffect();
    }
    if(good==null){
      good=new Good();
    }
    if(fire_work_effect==null){
      fire_work_effect=new FireWorkEffect();
    }
  }
}
