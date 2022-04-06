#line 1 "D:/alex-/Escritorio/wrt/seguidor_PIC/CODIGOS/V3/Rayito.c"
#line 38 "D:/alex-/Escritorio/wrt/seguidor_PIC/CODIGOS/V3/Rayito.c"
int ll=1, con=0;

int sensores[16];
int sens_bin[16];
int num=0;
int den=0;
int vmax=0,vmin=0, vprom=0;

float error=0,error_integral=0,error_pasado=0;
float p1=0,i1=0,d1=0,v1=0;
int i = 0, ciclo = 0;
char txt[7];
char txtf[15];

unsigned short on = 0;

void InitTimer0(unsigned short estado){

 if(estado == 0){
 T0CON = 0x88;
 TMR0H = 0xEC;
 TMR0L = 0x78;
 GIE_bit = 1;
 TMR0IE_bit = 1;
 on = 0;
 }
 else if(estado == 1){
 T0CON = 0x88;
 TMR0H = 0xE2;
 TMR0L = 0xB4;
 GIE_bit = 1;
 TMR0IE_bit = 1;
 on = 1;
 }
 else if(estado == 2){
 T0CON = 0x88;
 TMR0H = 0xE5;
 TMR0L = 0xA2;
 GIE_bit = 1;
 TMR0IE_bit = 1;
 on = 2;
 }
 else if(estado == 3){
 T0CON = 0x88;
 TMR0H = 0xE3;
 TMR0L = 0xAE;
 GIE_bit = 1;
 TMR0IE_bit = 1;
 on = 3;
 }
}

void Interrupt(){
 if (TMR0IF_bit){
 if(ciclo == 1 && on == 1){
 TMR0IF_bit = 0;
 TMR0H = 0xE2;
 TMR0L = 0xB4;
  RB3_bit  = 1;
 T0CON = 0x88;
 ciclo = 0;
 }
 else if(ciclo == 1 && on == 2){
 TMR0IF_bit = 0;
 TMR0H = 0xE5;
 TMR0L = 0xA2;
  RB3_bit  = 1;
 T0CON = 0x88;
 ciclo = 0;
 }
 else if(ciclo == 1 && on == 3){
 TMR0IF_bit = 0;
 TMR0H = 0xE3;
 TMR0L = 0xAE;
  RB3_bit  = 1;
 T0CON = 0x88;
 ciclo = 0;
 }
 else if(ciclo == 1 && on == 0){
 TMR0IF_bit = 0;
 TMR0H = 0xEC;
 TMR0L = 0x78;
  RB3_bit  = 1;
 T0CON = 0x88;
 ciclo = 0;
 }
 else {
 TMR0IF_bit = 0;
 TMR0H = 0x4B;
 TMR0L = 0x56;
  RB3_bit  = 0;
 T0CON = 0x80;
 ciclo = 1;
 }
 }
}


void leer_sens(){

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
#line 195 "D:/alex-/Escritorio/wrt/seguidor_PIC/CODIGOS/V3/Rayito.c"
}

void calibrar_sens(int tiempo){

 int k=0;

 for(k=0;k<=tiempo;k++){
  RB0_bit  = 1;
  RB1_bit  = 1;
  RB2_bit  = 1;
 leer_sens();
 Delay_ms(50);


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
  RB0_bit  = 0;
  RB1_bit  = 0;
  RB2_bit  = 0;
 Delay_ms(50);
 }

 vprom=(vmax+vmin)/2;
}

void binarizar(){
 leer_sens();
 for(i=0;i<=15;i++){
 if(sensores[i]>vprom){
 sens_bin[i]=1;
 }
 if(sensores[i]<vprom){
 sens_bin[i]=0;
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
  RB0_bit  = sens_bin[0];
  RB1_bit  = sens_bin[1];
  RB2_bit  = sens_bin[2];
  RB3_bit  = sens_bin[3];
 }

 else if(rango == 1){
  RB0_bit = sens_bin[4];
  RB1_bit = sens_bin[5];
  RB2_bit = sens_bin[6];
  RB3_bit = sens_bin[7];
 }
 else if(rango == 2){
  RB0_bit = sens_bin[8];
  RB1_bit = sens_bin[9];
  RB2_bit = sens_bin[10];
  RB3_bit = sens_bin[11];
 }
 else if(rango == 3){
  RB0_bit = sens_bin[12];
  RB1_bit = sens_bin[13];
  RB2_bit = sens_bin[14];
  RB3_bit = sens_bin[15];
 }
}

void prueba_todo(){
  RD0_bit=0; RD1_bit=1; RD2_bit=0; RD3_bit=1; 
 pwm2_Set_Duty(100);
 pwm1_Set_Duty(100);
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
  RB3_bit  = 0;
 }

}

void limpiar(){
 error = 0;
 error_integral = 0;
 error_pasado = 0;
 PWM1_Set_Duty(0);
 PWM2_Set_Duty(0);
  RD0_bit=0; RD1_bit=0; RD2_bit=0; RD3_bit=0; 
 delay_ms(1000);
 usarTurbina(1,0);
  RB0_bit  = 0;
  RB1_bit  = 0;
  RB2_bit  = 0;
}

void uartSensors(){
 binarizar();
 for(i = 0; i<=15; i++){
 UART1_Write(sens_bin[i] + 48);
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

 switch (valor)
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

 binarizar();

 if(error_integral>800)
 error_integral=800;
 if(error_integral<-800)
 error_integral=-800;

 error_integral = error + error_integral;
 ganancia = kp*error + kd*(error-error_pasado) + ki*(error_integral);
 error_pasado = error;

 if(error < - 70){
  RD0_bit=1; RD1_bit=0; RD2_bit=0; RD3_bit=1; 
 pwmA = vel_max;
 pwmB = vel_max;
  RB2_bit =1;
 }
 else if(error >= 70){
  RD0_bit=0; RD1_bit=1; RD2_bit=1; RD3_bit=0; 
 pwmA = vel_max;
 pwmB = vel_max;
  RB2_bit =0;
 }
 else
 {
 if(abs(ganancia)>vel){
 if(ganancia>0){
  RD0_bit=0; RD1_bit=1; RD2_bit=1; RD3_bit=0; 
 pwmA = vel+ganancia;
 pwmB = (-vel+ganancia);
 }
 else if(ganancia<0){
  RD0_bit=1; RD1_bit=0; RD2_bit=0; RD3_bit=1; 
 pwmA = (-vel-ganancia);
 pwmB = vel-ganancia;
 }
 }
 else{
  RD0_bit=0; RD1_bit=1; RD2_bit=0; RD3_bit=1; 
 pwmA=vel+ganancia;
 pwmB=vel-ganancia;
#line 455 "D:/alex-/Escritorio/wrt/seguidor_PIC/CODIGOS/V3/Rayito.c"
 }
 }

 if(pwmA>vel_max)
 pwmA=vel_max;
 if(pwmB>vel_max)
 pwmB=vel_max;
 if(pwmA<0)
 pwmA=0;
 if(pwmB<0)
 pwmB=0;

 pwm2_Set_Duty(pwmA);
 pwm1_Set_Duty(pwmB);
}



void main() {

 char uart;
 unsigned short frenos_on = 1, t = 0;
 CMCON=0X07;
 ADC_Init();

 TRISA=0b00000001;
 TRISB=0b00110000;
 TRISC=0b10000000;
 TRISD=0b11010000;


 ADCON0.ADON=1;
 ADCON1=0b00001110;
 ADCON2=0b10101110;

 PORTA=0X00;
 PORTB=0X00;
 PORTC=0X00;
 PORTD=0X00;

 PWM1_Init(25000);
 PWM2_Init(25000);
 PWM1_Start();
 PWM2_Start();
 PWM1_Set_Duty(0);
 PWM2_Set_Duty(0);
 Delay_ms(200);

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Rayito");
 UART1_Write(10);
 UART1_Write(13);

 pwm2_Set_Duty(0);
 pwm1_Set_Duty(0);

 calibrar_sens(50);
 Delay_ms(1000);


 if (( RD6_bit  == 0) && ( RD7_bit  == 0)){
 v1 = 100;
 p1 = 4;
 i1 = 0.001;
 d1 = 100;
 frenos_on = 0;
 t = 1;
 }
 if (( RD6_bit  == 0) && ( RD7_bit  == 1)){
 v1 = 120;
 p1 = 8.5;
 i1 = 0.002;
 d1 = 140;
 frenos_on = 0;
 t = 1;
 }
 if (( RD6_bit  == 1) && ( RD7_bit  == 0)){
 v1 = 190;
 p1 = 6;
 i1 = 0.001;
 d1 = 55;
 frenos_on = 0;
 t = 1;
 }
 if (( RD6_bit  == 1) && ( RD7_bit  == 1)){
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
#line 589 "D:/alex-/Escritorio/wrt/seguidor_PIC/CODIGOS/V3/Rayito.c"
 }
}
