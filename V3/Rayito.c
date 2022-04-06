//rayito V2.0
#define GO RB4_bit
#define READY RB5_bit

#define motorA1 RD0_bit
#define motorA2 RD1_bit
#define motorB1 RD2_bit
#define motorB2 RD3_bit


#define atras RD0_bit=1; RD1_bit=0; RD2_bit=1; RD3_bit=0;
#define frente RD0_bit=0; RD1_bit=1; RD2_bit=0; RD3_bit=1;
#define izquierda RD0_bit=1; RD1_bit=0; RD2_bit=0; RD3_bit=1;
#define derecha RD0_bit=0; RD1_bit=1; RD2_bit=1; RD3_bit=0;


/*#define frente RD0_bit=1; RD1_bit=0; RD2_bit=1; RD3_bit=0;
#define atras RD0_bit=0; RD1_bit=1; RD2_bit=0; RD3_bit=1;
#define derecha RD0_bit=0; RD1_bit=1; RD2_bit=1; RD3_bit=0;
#define izquierda RD0_bit=1; RD1_bit=0; RD2_bit=0; RD3_bit=1;*/


#define parar RD0_bit=0; RD1_bit=0; RD2_bit=0; RD3_bit=0;

#define SW1 RD6_bit
#define SW2 RD7_bit

#define boton RD4_bit

#define LED1 RB0_bit
#define LED2 RB1_bit
#define LED3 RB2_bit
#define TURBINA RB3_bit

#define LED_D RC5_bit
#define LED_I RC4_bit

int ll=1, con=0;
//-----------------ADC---------------
int sensores[16];
int sens_bin[16];
int num=0;
int den=0;
int vmax=0,vmin=0, vprom=0;
//-----------------PID---------------
float error=0,error_integral=0,error_pasado=0;
float p1=0,i1=0,d1=0,v1=0;
int i = 0, ciclo = 0;
char txt[7];
char txtf[15];

unsigned short on = 0;

void InitTimer0(unsigned short estado){

    if(estado == 0){ //1 ms alto
        T0CON         = 0x88;
        TMR0H         = 0xEC;
        TMR0L         = 0x78;
        GIE_bit         = 1;
        TMR0IE_bit         = 1;
        on = 0;
     }
     else if(estado == 1){ //1.5 ms alto
        T0CON         = 0x88;
        TMR0H         = 0xE2;
        TMR0L         = 0xB4; //valores inicilaes para desbordar en 1.5ms
        GIE_bit         = 1;
        TMR0IE_bit         = 1; //set 1
        on = 1;
     }
     else if(estado == 2){ //1.35 ms alto
        T0CON         = 0x88;
        TMR0H         = 0xE5;
        TMR0L         = 0xA2;
        GIE_bit         = 1;
        TMR0IE_bit         = 1;
        on = 2;
     }
     else if(estado == 3){ //1.35 ms alto
        T0CON         = 0x88;
        TMR0H         = 0xE3;
        TMR0L         = 0xAE;
        GIE_bit         = 1;
        TMR0IE_bit         = 1;
        on = 3;
     }
}

void Interrupt(){
     if (TMR0IF_bit){
        if(ciclo == 1 && on == 1){
            TMR0IF_bit = 0;
            TMR0H         = 0xE2;    //permanece en alto por 1.5ms
            TMR0L         = 0xB4;
            TURBINA = 1;
            T0CON         = 0x88;
            ciclo = 0;
            }
        else if(ciclo == 1 && on == 2){
            TMR0IF_bit = 0;
            TMR0H         = 0xE5;    //permanece en alto por 1.35ms
            TMR0L         = 0xA2;
            TURBINA = 1;
            T0CON         = 0x88;
            ciclo = 0;
            }
        else if(ciclo == 1 && on == 3){
            TMR0IF_bit = 0;
            TMR0H         = 0xE3;    //permanece en alto por 1.5ms
            TMR0L         = 0xAE;
            TURBINA = 1;
            T0CON         = 0x88;
            ciclo = 0;
            }
        else if(ciclo == 1 && on == 0){
            TMR0IF_bit = 0;
            TMR0H         = 0xEC;    //permanece en alto por 1.5ms
            TMR0L         = 0x78;
            TURBINA = 1;
            T0CON         = 0x88;
            ciclo = 0;
            }
        else {
            TMR0IF_bit = 0;
            TMR0H         = 0x4B;   //permanece en 0 18.5ms
            TMR0L         = 0x56;
            TURBINA = 0;
            T0CON         = 0x80;
            ciclo = 1;
        }
  }
}


void leer_sens(){  //lee

    RA4_bit=0; RA3_bit=0; RA2_bit=0; RA1_bit=0;
    sensores[15]=ADC_Read(0);

    RA4_bit=0; RA3_bit=0; RA2_bit=0; RA1_bit=1;
    sensores[14]=ADC_Read(0);

    RA4_bit=0; RA3_bit=0; RA2_bit=1; RA1_bit=0;
    sensores[13]=ADC_Read(0);

    RA4_bit=0; RA3_bit=0; RA2_bit=1; RA1_bit=1;
    sensores[12]=ADC_Read(0);

    RA4_bit=0; RA3_bit=1; RA2_bit=0; RA1_bit=0;
    sensores[11]=ADC_Read(0);

    RA4_bit=0; RA3_bit=1; RA2_bit=0; RA1_bit=1;
    sensores[10]=ADC_Read(0);

    RA4_bit=0; RA3_bit=1; RA2_bit=1; RA1_bit=0;
    sensores[9]=ADC_Read(0);

    RA4_bit=0; RA3_bit=1; RA2_bit=1; RA1_bit=1;
    sensores[8]=ADC_Read(0);

    RA4_bit=1; RA3_bit=0; RA2_bit=0; RA1_bit=0;
    sensores[7]=ADC_Read(0);

    RA4_bit=1; RA3_bit=0; RA2_bit=0; RA1_bit=1;
    sensores[6]=ADC_Read(0);

    RA4_bit=1; RA3_bit=0; RA2_bit=1; RA1_bit=0;
    sensores[5]=ADC_Read(0);

    RA4_bit=1; RA3_bit=0; RA2_bit=1; RA1_bit=1;
    sensores[4]=ADC_Read(0);

    RA4_bit=1; RA3_bit=1; RA2_bit=0; RA1_bit=0;
    sensores[3]=ADC_Read(0);

    RA4_bit=1; RA3_bit=1; RA2_bit=0; RA1_bit=1;
    sensores[2]=ADC_Read(0);

    RA4_bit=1; RA3_bit=1; RA2_bit=1; RA1_bit=0;
    sensores[1]=ADC_Read(0);

    RA4_bit=1; RA3_bit=1; RA2_bit=1; RA1_bit=1;
    sensores[0]=ADC_Read(0);

/*for(i = 0; i<=15; i++){
        RA4_bit = (((i & 0b1000) >> 3)); //#bin ((i and 0b1000) >> 3)
        RA3_bit = (((i & 0b0100) >> 2));
        RA2_bit = (((i & 0b0010) >> 1));
        RA1_bit = (((i & 0b0001)));
        sensores[15-1] = ADC_Read(0);
    }*/


}  // combertimos los analogicos a digitales y los almacenamos en en el arreglo de sensores

void calibrar_sens(int tiempo){

    int k=0;

    for(k=0;k<=tiempo;k++){
        LED1 = 1;
        LED2 = 1;
        LED3 = 1;
        leer_sens();
        Delay_ms(50);

        //deteccion de valores maximos y minimos de cada sensor
        vmax = sensores[0];
        vmin = sensores[0];
        for (i=0; i<=15; i++){
            if (sensores[i]> vmax){
                vmax=sensores[i];
            }
            if (sensores[i]< vmin){
                vmin=sensores[i];
            }
        }
        LED1 = 0;
        LED2 = 0;
        LED3 = 0;
        Delay_ms(50);
    }
    //obtencion del promedio del maximo y minimo
    vprom=(vmax+vmin)/2;
}

void binarizar(){
   leer_sens();// (muestreo de sensores)
   for(i=0;i<=15;i++){
     if(sensores[i]>vprom){  // 1=linea negra
       sens_bin[i]=1;     //linea                                               //0= linea blanca
      }
     if(sensores[i]<vprom){
       sens_bin[i]=0;   // contorno
     }
   }

   num=sens_bin[0]*0+sens_bin[1]*1+sens_bin[2]*2+sens_bin[3]*3+sens_bin[4]*4+sens_bin[5]*5+sens_bin[6]*6+sens_bin[7]*7+sens_bin[8]*8+sens_bin[9]*9+sens_bin[10]*10+sens_bin[11]*11+sens_bin[12]*12+sens_bin[13]*13+sens_bin[14]*14+sens_bin[15]*15;
   num=num*10;
   den=sens_bin[0]+sens_bin[1]+sens_bin[2]+sens_bin[3]+sens_bin[4]+sens_bin[5]+sens_bin[6]+sens_bin[7]+sens_bin[8]+sens_bin[9]+sens_bin[10]+sens_bin[11]+sens_bin[12]+sens_bin[13]+sens_bin[14]+sens_bin[15];
   if(den == 0)
      error = error;
   else
      error=(num/den)-75;
}

void prueba_sensores(int rango){
  binarizar();
  if(rango == 0){
    LED1 = sens_bin[0];
    LED2 = sens_bin[1];
    LED3 = sens_bin[2];
    TURBINA = sens_bin[3];
  }

    else if(rango == 1){
    LED1= sens_bin[4];
    LED2= sens_bin[5];
    LED3= sens_bin[6];
    TURBINA= sens_bin[7];
  }
      else if(rango == 2){
    LED1= sens_bin[8];
    LED2= sens_bin[9];
    LED3= sens_bin[10];
    TURBINA= sens_bin[11];
  }
      else if(rango == 3){
    LED1= sens_bin[12];
    LED2= sens_bin[13];
    LED3= sens_bin[14];
    TURBINA= sens_bin[15];
  }
}

void prueba_todo(){
     frente
     pwm2_Set_Duty(100);     //m izq
     pwm1_Set_Duty(100);     //m der
     prueba_sensores(0);
}

void initTurbina(unsigned short modo){
    InitTimer0(0);
    delay_ms(1500);
    InitTimer0(modo);
}


void usarTurbina(unsigned short enable, unsigned short modo){

    if(enable == 1){
        initTurbina(modo);
        delay_ms(1000);
    }
    else if (enable == 0){
        T0CON = 0x00;
        TMR0H = 0x00;
        TMR0L = 0x00;
        GIE_bit = 0;
        TMR0IE_bit = 0;
        TURBINA = 0;
    }

}

void limpiar(){
    error = 0;
    error_integral = 0;
    error_pasado = 0;
    PWM1_Set_Duty(0);//regulas cuantos V q se manda
    PWM2_Set_Duty(0);
    parar
    delay_ms(1000);
    usarTurbina(1,0);
    LED1 = 0;
    LED2 = 0;
    LED3 = 0;
}

void uartSensors(){
      binarizar();
      for(i = 0; i<=15; i++){
            UART1_Write(sens_bin[i] + 48);       // and send data via UART
            UART1_Write(13);
      }
      UART1_Write(13);
      UART1_Write(13);
      UART1_Write(13);
      IntToStr(error, txt);
      UART1_Write_text(txt);
      UART1_Write(10);

}

void pid_bth(){
    char valor = 0;

    if (UART1_Data_Ready()) {
        valor = UART1_Read();

      switch (valor) // Selector es de tipo char o int
       {
        case 0:
              v1 = v1 + 10;
              break;
        case 1:
              v1 = v1 - 10;
              break;
        case 2:
              p1 = p1 + 0.5;
              break;
        case 3:
              p1 = p1 - 0.5;
              break;
        case 4:
              d1 = d1 + 5;
              break;
        case 5:
              d1 = d1 - 5;
              break;
        case 6:
              i1 = i1 + 0.001;
              break;
        case 7:
              i1 = i1 - 0.001;
              break;
        default:

        break;
      }

        if(v1<0)
            v1=0;
        if(v1>255)
            v1 = 255;
        if(p1<0)
            p1=0;
        if(i1<0)
            i1=0;
        if(d1<0)
            d1=0;

        IntToStr(v1, txt);
        UART1_Write_text(txt);
        UART1_Write(13);
        IntToStr(p1, txt);
        UART1_Write_text(txt);
        UART1_Write(13);
        floatToStr(i1, txtf);
        UART1_Write_text(txtf);
        UART1_Write(13);
        IntToStr(d1, txt);
        UART1_Write_text(txt);
        UART1_Write(10);
      }
}


unsigned int C1=0, C2=0;
void seguidor(int Vel, int Vel_max, float kp, float kd, float ki, unsigned short frenos){
    float ganancia=0;
    int pwmA,pwmB;

    binarizar();             //linea, contorno  //1=linea negra

    if(error_integral>800)
       error_integral=800;
    if(error_integral<-800)
       error_integral=-800;

    error_integral = error + error_integral;
    ganancia = kp*error + kd*(error-error_pasado) + ki*(error_integral);
    error_pasado = error;

    if(error < - 70){
              izquierda
              pwmA = vel_max;  //MI
              pwmB = vel_max;  //MD
              LED3=1;
              }
    else if(error >= 70){
              derecha
              pwmA = vel_max;  //MI
              pwmB = vel_max;  //MD
              LED3=0;
              }
    else
    {
        if(abs(ganancia)>vel){
                if(ganancia>0){
                   derecha
                   pwmA = vel+ganancia;  //MI
                   pwmB = (-vel+ganancia);  //MD
                }
                else if(ganancia<0){
                  izquierda
                  pwmA = (-vel-ganancia);  //izq
                  pwmB = vel-ganancia;  //der
                 }
        }
        else{
            frente
            pwmA=vel+ganancia;  //izq
            pwmB=vel-ganancia;  //der
            /*if(error >= 0){
                      pwmA = vel;
                      pwmB = vel - ganancia;
                 }
                 else if (error < 0){
                      pwmA = vel + ganancia;
                      pwmB = vel;
                 } */
         }
    }
   //limites
   if(pwmA>vel_max)
     pwmA=vel_max;
   if(pwmB>vel_max)
     pwmB=vel_max;
   if(pwmA<0)
     pwmA=0;
   if(pwmB<0)
     pwmB=0;
   //asignacion
   pwm2_Set_Duty(pwmA);     //m izq
   pwm1_Set_Duty(pwmB);     //m der
}



void main() {
    //OSCCON = 0b01110111;      //config para 8MHz
    char uart;
    unsigned short frenos_on = 1, t = 0;
    CMCON=0X07;
    ADC_Init();//inicialisa el combertidor analogico digital

    TRISA=0b00000001;
    TRISB=0b00110000;
    TRISC=0b10000000;
    TRISD=0b11010000;


    ADCON0.ADON=1;
    ADCON1=0b00001110;  //ANALOG-->Delay_us AN0-AN3
    ADCON2=0b10101110;

    PORTA=0X00;
    PORTB=0X00;
    PORTC=0X00;
    PORTD=0X00;

    PWM1_Init(25000); //inicia el pwm
    PWM2_Init(25000);
    PWM1_Start();  //arranca el pwm
    PWM2_Start();
    PWM1_Set_Duty(0);//regulas cuantos V q se manda
    PWM2_Set_Duty(0);
    Delay_ms(200);

    UART1_Init(9600);               // Initialize UART module at 9600 bps
    Delay_ms(100);                  // Wait for UART module to stabilize

    UART1_Write_Text("Rayito");
    UART1_Write(10);
    UART1_Write(13);

    pwm2_Set_Duty(0);     //m izq
    pwm1_Set_Duty(0);     //m der

    calibrar_sens(50);
    Delay_ms(1000);

    //InitTimer0();
    if ((SW1 == 0) && (SW2 == 0)){ //CON TURBINA SOMBRA BEST
      v1 = 100; //150
      p1 = 4;   //10.5
      i1 = 0.001;  //0.001
      d1 = 100;    //200
      frenos_on = 0;
      t = 1;
    }
    if ((SW1 == 0) && (SW2 == 1)){
      v1 = 120;
      p1 = 8.5;
      i1 = 0.002;
      d1 = 140;
      frenos_on = 0;
      t = 1;
    }
    if ((SW1 == 1) && (SW2 == 0)){
      v1 = 190;
      p1 = 6;
      i1 = 0.001;
      d1 = 55;
      frenos_on = 0;
      t = 1;
    }
    if ((SW1 == 1) && (SW2 == 1)){//SIN TURBINA SOMBRA
      v1 = 215;
      p1 = 5;
      i1 = 0.001;
      d1 = 100;
      frenos_on = 0;
      t = 1;
    }
    limpiar();
    while(1){

    pwm2_set_duty(200);
    pwm1_set_duty(200);
    RD1_bit = 1;
    RD2_bit = 1;
    delay_ms(2000);
    RD1_bit = 0;
    RD2_bit = 0;
    delay_ms(2000);
/*if (READY == 1) {
            usarTurbina(t,1);
            LED2 = 1;

            while (GO == 0){
                //uartSensors();
                pid_bth();
            }

            if (GO == 1) {

                while(GO == 1){
                    pid_bth();
                    seguidor(v1, 255, p1,d1,i1, frenos_on); //ajustar PID 30000 500 750 27
                    //binarizar();
                    //floatToStr(error, txtf);
                    //UART1_Write_text(txtf);
                    //UART1_Write(10);
                }
                limpiar();
            }


        }

        else{
            //limpiar();
            LED1 = 1;
        }*/
    }
}