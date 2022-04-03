#include <DynamixelSerial1.h>

int r=0, b=0, m=0, s=19;
int pulsador = 5, val=0, nop=0, new_val=0;
const int VELmin = 100, VELmed = 200, VELmax=300;


void setup(){
  Serial.begin(9600);
  Dynamixel.begin(1000000,3);  // Inicialize the servo at 1Mbps and Pin Control 3
  //Configuración del pulsador
  pinMode(pulsador, INPUT); // se declara como entrada
  digitalWrite(pulsador, HIGH); // Escribimos un High en el Pin para activar la resistencia de PullUp
  

}

void inicio() {  // Movimiento 10

// PARAMOS TODAS LAS RUEDAS
  for (r=3; r<19; r=r+3){
    Dynamixel.turn(r,LEFT,0);
  }
  

// PONEMOS RECTO LOS MOTORES SUPERIORES
  for (m=1; m<17; m=m+3){
    Dynamixel.moveSpeed(m,512,300);
  }

  delay(500);

// PONEMOS RECTO LOS MOTORES MEDIOS
  for (b=2; b<18; b=b+3){
    Dynamixel.moveSpeed(b,512,300);
  }

  delay(500);

  // PONEMOS TODAS LAS RUEDAS EN LA MISMA DIRECCIÓN
  for (b=2;b<18;b=b+3){
    Dynamixel.move(b,400);
    delay(1000);

    if (s==20 || s==23){
      Dynamixel.move(s,616);
      delay(200);
    }

    else if (s==21 || s==24){
      Dynamixel.move(s,824);
      delay(200);
    }
      
    else {
      Dynamixel.move(s,408);
      delay(200);
    }

    Dynamixel.move(b,512);
    delay(200);
    s++;
    
  }


}

void agacha_atras() { //Movimiento 4
    for (b=2; b<18; b=b+3){
      if (b==5 || b==8 || b==11){
        Dynamixel.moveSpeed(b,712,30);
        Dynamixel.moveSpeed(b-1,312,30);
      } else {
        Dynamixel.moveSpeed(b,312,30);
        Dynamixel.moveSpeed(b-1,712,30);
        }
    }
}

void agacha_delante() { //Movimiento 5
    for (b=2; b<18; b=b+3){
      if (b==2 || b==14 || b==17){
        Dynamixel.moveSpeed(b,712,30);
        Dynamixel.moveSpeed(b-1,312,30);
      } else {
        Dynamixel.moveSpeed(b,312,30);
        Dynamixel.moveSpeed(b-1,712,30);
        }
    }
}

void verticalatras() { //Movimiento 8
  for (b=2; b<18; b=b+3){
      if (b==2 || b==14 || b==17){
        Dynamixel.moveSpeed(b,712,30);
        Dynamixel.moveSpeed(b-1,312,30);
      } else {
        Dynamixel.moveSpeed(b,312,30);
        Dynamixel.moveSpeed(b-1,712,30);
        }
    }
    delay(1000);
      
// PONEMOS RECTO LOS MOTORES
  for (b=2; b<18; b=b+3){
      Dynamixel.moveSpeed(b,512,30);
      Dynamixel.moveSpeed(b-1,512,30);
  }
}

void agacha_salto_atras() { //Movimiento 6
  
    for (b=2; b<18; b=b+3){
      if (b==2 || b==14 || b==17){
        Dynamixel.moveSpeed(b,712,30);
        Dynamixel.moveSpeed(b-1,312,30);
      } else {
        Dynamixel.moveSpeed(b,312,30);
        Dynamixel.moveSpeed(b-1,712,30);
        }
    }

  delay(2000);
  Dynamixel.moveSpeed(13,204,30);
  Dynamixel.moveSpeed(10,820,30);  
  delay(1000);
  Dynamixel.moveSpeed(11,512,30);
  Dynamixel.moveSpeed(14,512,30);
  
}

void agacha_salto_delante() { //Movimiento 7
    for (b=2; b<18; b=b+3){
      if (b==5 || b==8 || b==11){
        Dynamixel.moveSpeed(b,712,30);
        Dynamixel.moveSpeed(b-1,312,30);
      } else {
        Dynamixel.moveSpeed(b,312,30);
        Dynamixel.moveSpeed(b-1,712,30);
        }
    }

  delay(2000);
  Dynamixel.moveSpeed(1,820,30);
  Dynamixel.moveSpeed(4,204,30);
  delay(1000);
  Dynamixel.moveSpeed(2,512,30);
  Dynamixel.moveSpeed(5,512,30);
  
}


void saltapata(int pata) { 
    int i;
    i=pata-19;

    if (pata == 19 || pata == 23 || pata == 24)
      Dynamixel.move(pata-18+2*i,204);
    else
      Dynamixel.move(pata-18+2*i,820);
    
}

void levanta(int pata) { 
    int i;
    i=pata-19;

    if (pata == 19 || pata == 23 || pata == 24)
      Dynamixel.move(pata-18+2*i,204);
    else
      Dynamixel.move(pata-18+2*i,820);
    
}

void baja(int pata) {
    int u;
    u=pata-29;
    Dynamixel.moveSpeed(pata-28+2*u,512,200);
    //delay(2000);
    Dynamixel.moveSpeed(pata-27+2*u,512,200);
    //delay(2000);
}

void loop(){
  if (nop==0) {
    if(val==0){
      // PARAMOS TODAS LAS RUEDAS
      for (r=3; r<19; r=r+3){
        Dynamixel.turn(r,LEFT,0);
      }
      nop=1;
    }
   
  
    if(val==1){
      for (r=3; r<19; r=r+3){
        if (r>3 && r<13){
          Dynamixel.turn(r,LEFT,VELmin); 
        } else {
          Dynamixel.turn(r,RIGTH,VELmin);
        }
      }
      nop=1;
    }
  
  
    if(val==2){
      for (r=3; r<19; r=r+3){
        if (r>3 && r<13){
          Dynamixel.turn(r,LEFT,VELmed); 
        } else {
          Dynamixel.turn(r,RIGTH,VELmed);
        }
      }
      nop=1;
    }
  
     if(val==3){
        for (r=3; r<19; r=r+3){
          if (r>3 && r<13){
            Dynamixel.turn(r,LEFT,VELmax); 
          } else {
            Dynamixel.turn(r,RIGTH,VELmax);
          }
        }
        nop=1;
      }
  
  
    //LEVANTAR PATAS
    if(val==19){
      levanta(val);
      nop=1;
    }
    
    if(val==20){
      levanta(val);
      nop=1;
    }
    if(val==21){
      levanta(val);
      nop=1;
    }
    if(val==22){
      levanta(val);
      nop=1;
    }
    if(val==23){
      levanta(val);
      nop=1;
    }
    if(val==24){
      levanta(val);
      nop=1;
    }
  
  
    //BAJAR PATAS
    if(val==29){
      baja(val);
      nop=1;
    }
    if(val==30){
      baja(val);
      nop=1;
    }
    if(val==31){
      baja(val);
      nop=1;
    }
    if(val==32){
      baja(val);
      nop=1;
    }
    if(val==33){
      baja(val);
      nop=1;
    }
    if(val==34){
      baja(val);
      nop=1;
    }
  
    //MOVIMIENTOS
    if(val==4){
      agacha_atras();
      nop=1;
    }
    if(val==5){
      agacha_delante();
      nop=1;
    }
    if(val==6){
      agacha_salto_atras();
      nop=1;
    }
    if(val==7){
      agacha_salto_delante();
      nop=1;
    }   
    if(val==8){
      verticalatras();
      nop=1;
    }  
    if(val==10){
      inicio();
      nop=1;
    } 
  }  
}

void serialEvent(){
  //Recepción de datos Seriales
    while (Serial.available()) {              //Si existen datos seriales, leer a todos
    new_val=Serial.read();
    if (new_val == val)
      nop=1;   //Leer 1 byte serial recibido 
    else 
      val=new_val;
      nop=0; 
  }
}
