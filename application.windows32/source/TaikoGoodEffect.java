import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import processing.awt.PSurfaceAWT; 
import processing.awt.PSurfaceAWT.SmoothCanvas; 
import javax.swing.JFrame; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TaikoGoodEffect extends PApplet {

//3-4-24塩出研史 <http://solt9029.com>
//太鼓の達人のアニメーションのパラメータを測定し忠実に再現するプログラム







ColorEffect color_effect;
Don don;
Good good;
FireWorkEffect fire_work_effect;

Minim minim;

public void setup(){
  PSurfaceAWT awtSurface = (PSurfaceAWT) surface;
  SmoothCanvas smoothCanvas = (SmoothCanvas) awtSurface.getNative();
  JFrame jframe = (JFrame)smoothCanvas.getFrame();
  jframe.dispose();
  jframe.setUndecorated(true);
  jframe.setOpacity(.5f);
  jframe.setVisible(true);
  
  minim=new Minim(this);
  

  don=new Don();
}

public void draw(){
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

public void drawBar(){
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

public void drawJudgeMark(){
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

public void keyPressed(){
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
class ColorEffect {
  long start_time=0;

  ColorEffect() {
    this.start_time=System.currentTimeMillis();
  }

  public void display() {
    long current_time=System.currentTimeMillis();

    if (current_time>this.start_time+150){
      return;
    }

    noStroke();
    
    int c1 = color(255, 255, 0, 120);
    int c2 = color(255, 0, 0, 20);
    
    if (current_time>this.start_time+100) {
      c1 = color(255, 255, 0, 200-(current_time-start_time));
      c2 = color(255, 0, 0, 120-(current_time-start_time));
    }
    
    for (float w = 0; w < width-600; w += 1) {
      int c = lerpColor(c1, c2, w / (width-600));
      fill(c);
      rect(w+500, height/2, 1, height/2-60);
    }
  }
  
}
class Don {
  AudioSample audio;
  
  int start_x=1680;
  int start_y=308;

  int current_x=1680;
  int current_y=308;
  int speed=3;


  boolean is_hit=false;

  long start_time;//ミリ秒

  long movement_start_time=0;
  int movement_time=300;
  
  int [][] movement_pos=new int [300][2];
  
  //最終地点に到着してから200ミリ秒で消える
  
  float alpha=255;

  Don() {
    this.start_time=System.currentTimeMillis();
    
    this.audio=minim.loadSample("dong.wav");
    
    //キャプチャ動画から以下のミリ秒ごとにdonの座標をとりました
    //ellipse(1430,90,87,87);→最終的にこの座標にたどり着けばいい
    movement_pos[0][0]=580;
    movement_pos[0][1]=308;
    movement_pos[29][0]=movement_pos[0][0]+PApplet.parseInt(850*(float)44/582);//44
    movement_pos[29][1]=movement_pos[0][1]-PApplet.parseInt(218*(float)36/173);//-36
    movement_pos[59][0]=movement_pos[29][0]+PApplet.parseInt(850*(float)90/582);//90
    movement_pos[59][1]=movement_pos[29][1]-PApplet.parseInt(218*(float)62/173);//-62
    movement_pos[99][0]=movement_pos[59][0]+PApplet.parseInt(850*(float)89/582);//89
    movement_pos[99][1]=movement_pos[59][1]-PApplet.parseInt(218*(float)55/173);//-55
    movement_pos[129][0]=movement_pos[99][0]+PApplet.parseInt(850*(float)81/582);//81
    movement_pos[129][1]=movement_pos[99][1]-PApplet.parseInt(218*(float)32/173);//-32
    movement_pos[159][0]=movement_pos[129][0]+PApplet.parseInt(850*(float)74/582);//74
    movement_pos[159][1]=movement_pos[129][1]-PApplet.parseInt(218*(float)18/173);//-18
    movement_pos[199][0]=movement_pos[159][0]+PApplet.parseInt(850*(float)64/582);//64
    movement_pos[199][1]=movement_pos[159][1]-PApplet.parseInt(218*(float)3/173);//-3
    movement_pos[229][0]=movement_pos[199][0]+PApplet.parseInt(850*(float)56/582);//56
    movement_pos[229][1]=movement_pos[199][1]+PApplet.parseInt(218*(float)9/173);//+9
    movement_pos[269][0]=movement_pos[229][0]+PApplet.parseInt(850*(float)40/582);//40
    movement_pos[269][1]=movement_pos[229][1]+PApplet.parseInt(218*(float)11/173);//+11
    movement_pos[299][0]=movement_pos[269][0]+PApplet.parseInt(850*(float)44/582);//44
    movement_pos[299][1]=movement_pos[269][1]+PApplet.parseInt(218*(float)14/173);;//+14
    
    for(int i=1,s=0,e=29; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=29,e=59; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=59,e=99; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=99,e=129; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=129,e=159; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=159,e=199; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=199,e=229; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=229,e=269; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }
    
    for(int i=1,s=269,e=299; i<e-s; i++){
      int sx=movement_pos[s][0];
      int sy=movement_pos[s][1];
      int ex=movement_pos[e][0];
      int ey=movement_pos[e][1];
      movement_pos[i+s][0]=sx+(ex-sx)*i/e;
      movement_pos[i+s][1]=sy+(ey-sy)*i/e;
    }

  }

  public void hit() {
    this.is_hit=true;
    this.movement_start_time=System.currentTimeMillis();
    this.audio.trigger();
  }

  public void display() {
    long current_time=System.currentTimeMillis();

    if (!this.is_hit) {
      this.current_x=PApplet.parseInt(this.start_x-(current_time-this.start_time)/2);
    } else {
      if (current_time<movement_start_time+movement_time) {
        //動くcurrent_time-movement_start_timeで経過ミリ秒数が取れるよ
        this.current_x=PApplet.parseInt(this.movement_pos[PApplet.parseInt(current_time-movement_start_time)][0]);
        this.current_y=PApplet.parseInt(this.movement_pos[PApplet.parseInt(current_time-movement_start_time)][1]);
      }else if(this.current_x<this.movement_pos[299][0]){
        this.current_x=this.movement_pos[299][0];
        this.current_y=this.movement_pos[299][1];
      }
      
      //300ミリ秒経過後は動きが終わってるから、ここからフェードアウトに入る
      if(current_time>this.movement_start_time+300){
        this.alpha=255-(current_time-this.movement_start_time-300)*255.0f/200;
      }
      //フェードアウト開始から200ミリ秒たったら完全に消える
      if(current_time>this.movement_start_time+500){
        this.alpha=0;
      }
      
    }

    stroke(0,this.alpha);
    strokeWeight(5);
    fill(246,this.alpha);
    ellipse(this.current_x, this.current_y, 87, 87);

    noStroke();
    fill(234, 61, 22,this.alpha);
    ellipse(this.current_x, this.current_y, 66, 66);

    fill(10, 0, 0,this.alpha);
    ellipse(this.current_x-18, this.current_y-5, 16, 16);

    fill(10, 0, 0,this.alpha);
    ellipse(this.current_x+18, this.current_y-5, 16, 16);

    stroke(0,this.alpha);
    strokeWeight(3);
    noFill();
    bezier(this.current_x, this.current_y+10, this.current_x+5, this.current_y+15, this.current_x+10, this.current_y+15, this.current_x+15, this.current_y+10);
    bezier(this.current_x, this.current_y+10, this.current_x-5, this.current_y+15, this.current_x-10, this.current_y+15, this.current_x-15, this.current_y+10);
  }
}
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

  public void display() {
    long current_time=System.currentTimeMillis();
    
    if(current_time>this.start_time+14000)return;
    
    this.current_size=this.start_size+(this.end_size-this.start_size)*PApplet.parseInt(current_time-this.start_time)/14000;
    
    pushMatrix();
    translate(this.x, this.y);
    for (int d=0; d<360; d+=12) {
      pushMatrix();
      rotate(radians(d));

      translate(0, 42);//判定部分に被らないようにする

      int c1=color(255, 255, 0, 150+(this.end_size-this.current_size)*3);
      int c2=color(255, 70, 0, 50+(this.end_size-this.current_size)*3);
      int start_len=2;
      float end_len= this.current_size/9.0f;
      for (float w=0; w<this.current_size; w++) {
        int c=lerpColor(c1, c2, w/this.current_size);
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
class Good{
  int start_x=547;
  int start_y=215;
  int current_x=547;
  int current_y=215;
  int end_x=547;
  int end_y=145;
  int speed=10;
  PImage image;
  
  long start_time;
  
  float alpha=255;//transparency rate
  
  Good(){
    this.image=loadImage("good.png");
    this.start_time=System.currentTimeMillis();
  }
  
  public void display(){
    long current_time=System.currentTimeMillis();
    
    if(current_time<this.start_time+140){
      this.current_y=PApplet.parseInt(this.start_y+(this.end_y-this.start_y)*(current_time-this.start_time)/(float)140);
    }else if(current_time<this.start_time+280){
      this.current_y=this.end_y;
    }else if(current_time<this.start_time+510){
      this.alpha=255-(current_time-this.start_time-280)*(float)255/230;
    }else{
      this.alpha=0;
    }
    
    tint(255,255,255,this.alpha);
    image(this.image,this.current_x,this.current_y);
  }
  
}
class SoulEffect{
  
  SoulEffect(){
  }
}
  public void settings() {  size(1680,450); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TaikoGoodEffect" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
