 #include "hx711.h"

sbit hx711_dat at portB.b6;   //pin de datos del micro
sbit hx711_ck at portB.b7;     // pin de reloj


sbit hx711_dat_dir at trisB.b6;
sbit hx711_ck_dir  at trisB.b7;

const float offset_manual=83877.0;  //offset, valor leido a 0
const float calibra=419386.9 - offset_manual;  // valor a la calobtracion menos el offset
const float prueba=1000.0;  //  peso de prueba para calibración    gramos


float factor=prueba/calibra; //factor de multiplicativo a lectura base    debe colocarse aqui

signed long offset=offset_manual;// carga el offset manual al offset a usar


sbit sw_tarar at Rc6_bit;  // suiche tarar
sbit sw_cal at Rc7_bit;    // suiche calibracion

sbit led at Rc0_bit;   //led

// LCD module connections
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;
// End LCD module connections

signed long celda=0;
char texto[25];
float peso,cal;

  void floattostr_(float numero_, unsigned char *cadena_,char decimales_)
{
//variables temporales
int largo_entera,largo_n,cont_for,tempo_int;
double tempo_float;
//largo de la trama a armar en decimales
largo_n = decimales_+1;
largo_entera = 0;
// si es negativa coloca el -
if ( numero_ < 0)
  {
  *cadena_++ = '-';
  numero_ = -numero_;
  }
//si es menor que no multiplica por 10
if (numero_ > 0.0) while (numero_ < 1.0)
  {
  numero_ =numero_* 10.0;
  largo_entera--;
  }

  //realiza division varias veces hasta que sea menor que 10
while (numero_ >= 10.0)
  {
  numero_ = numero_/10.0;
  largo_entera++;   //sube el largo de la trama por ser deciaml
 }
 largo_n = largo_n+largo_entera;   //el largo es la decimal mas la parte entera

//round. numero_ is between 1 and 10 and largo_n will be printed to
// right of decimal point so rounding is ...
for (tempo_float = cont_for = 1; cont_for < largo_n; cont_for++)
  tempo_float = tempo_float/10.0;
numero_ += tempo_float/2.0;
if (numero_ >= 10.0) {numero_ = 1.0; largo_entera++;}
//si tiene decimales
if (largo_entera<0)
  {
   *cadena_++ = '0'; *cadena_++ = '.';
   if (largo_n < 0) largo_entera = largo_entera-largo_n;
   for (cont_for = -1; cont_for > largo_entera; cont_for--)  *cadena_++ = '0';
  }
for (cont_for=0; cont_for < largo_n; cont_for++)
  {
  tempo_int = numero_;
  *cadena_++ = tempo_int + 48;  //convierte a ascci
  if (cont_for ==  largo_entera ) *cadena_++ = '.';
  numero_ -= (tempo_float=tempo_int);
  numero_ = numero_*10.0;
  }
*cadena_ =0;    //anexa final de linea
}


void main() 
{

 TRISC6_bit=1;
 TRISC7_bit=1;
 TRISC0_bit=0; //salida led

  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(2,1,"PESO=");
  Delay_ms(500);
  hx711_init(); //inica el hx711
   Lcd_Out(1,1,"Offset=");
    floattostr_(offset,texto,1);
    Lcd_Out(1,8,texto);//muestra el offset
   
   while (1)
   {
   
// peso=hx711_lectura(128)-(float)offset;
    peso=hx711_promedio(10,128)-(float)offset;
   peso=peso*factor;
   if (peso<=0) peso=0;
   floattostr_(peso,texto,1);
   Lcd_Out(2,10,"          ");//Borra
   Lcd_Out(2,10,texto);//muestra el peso

   led=!led;
   Delay_ms(100);
   
   if(sw_tarar==0)
   {
    led=0;
    tarar(10,128);  //numero de datos, a que ganancia
    floattostr_(offset,texto,1);
    Lcd_Out(1,8,texto);//muestra el offset

   }
   
     if (sw_cal==0)
   {
    led=0;
   cal=hx711_promedio(50,128)-(float)offset;
   factor= prueba/cal;

   }
   
   
   }



}