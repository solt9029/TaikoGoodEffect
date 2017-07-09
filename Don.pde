class Don {
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

  Don() {
    this.start_time=System.currentTimeMillis();
    
    //キャプチャ動画から以下のミリ秒ごとにdonの座標をとりました
    //ellipse(1430,90,87,87);→最終的にこの座標にたどり着けばいい
    movement_pos[0][0]=580;
    movement_pos[0][1]=308;
    movement_pos[29][0]=movement_pos[0][0]+int(850*(float)44/582);//44
    movement_pos[29][1]=movement_pos[0][1]-int(218*(float)36/173);//-36
    movement_pos[59][0]=movement_pos[29][0]+int(850*(float)90/582);//90
    movement_pos[59][1]=movement_pos[29][1]-int(218*(float)62/173);//-62
    movement_pos[99][0]=movement_pos[59][0]+int(850*(float)89/582);//89
    movement_pos[99][1]=movement_pos[59][1]-int(218*(float)55/173);//-55
    movement_pos[129][0]=movement_pos[99][0]+int(850*(float)81/582);//81
    movement_pos[129][1]=movement_pos[99][1]-int(218*(float)32/173);//-32
    movement_pos[159][0]=movement_pos[129][0]+int(850*(float)74/582);//74
    movement_pos[159][1]=movement_pos[129][1]-int(218*(float)18/173);//-18
    movement_pos[199][0]=movement_pos[159][0]+int(850*(float)64/582);//64
    movement_pos[199][1]=movement_pos[159][1]-int(218*(float)3/173);//-3
    movement_pos[229][0]=movement_pos[199][0]+int(850*(float)56/582);//56
    movement_pos[229][1]=movement_pos[199][1]+int(218*(float)9/173);//+9
    movement_pos[269][0]=movement_pos[229][0]+int(850*(float)40/582);//40
    movement_pos[269][1]=movement_pos[229][1]+int(218*(float)11/173);//+11
    movement_pos[299][0]=movement_pos[269][0]+int(850*(float)44/582);//44
    movement_pos[299][1]=movement_pos[269][1]+int(218*(float)14/173);;//+14
    
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

  void hit() {
    this.is_hit=true;
    this.movement_start_time=System.currentTimeMillis();
  }

  void display() {
    long current_time=System.currentTimeMillis();

    if (!this.is_hit) {
      this.current_x=int(this.start_x-(current_time-this.start_time)/2);
    } else {
      if (current_time<movement_start_time+movement_time) {
        //動くcurrent_time-movement_start_timeで経過ミリ秒数が取れるよ
        this.current_x=int(this.movement_pos[int(current_time-movement_start_time)][0]);
        this.current_y=int(this.movement_pos[int(current_time-movement_start_time)][1]);
      }else if(this.current_x<this.movement_pos[299][0]){
        this.current_x=this.movement_pos[299][0];
        this.current_y=this.movement_pos[299][1];
      }
    }

    stroke(0);
    strokeWeight(5);
    fill(246);
    ellipse(this.current_x, this.current_y, 87, 87);

    noStroke();
    fill(234, 61, 22);
    ellipse(this.current_x, this.current_y, 66, 66);

    fill(10, 0, 0);
    ellipse(this.current_x-18, this.current_y-5, 16, 16);

    fill(10, 0, 0);
    ellipse(this.current_x+18, this.current_y-5, 16, 16);

    stroke(0);
    strokeWeight(3);
    noFill();
    bezier(this.current_x, this.current_y+10, this.current_x+5, this.current_y+15, this.current_x+10, this.current_y+15, this.current_x+15, this.current_y+10);
    bezier(this.current_x, this.current_y+10, this.current_x-5, this.current_y+15, this.current_x-10, this.current_y+15, this.current_x-15, this.current_y+10);
  }
}