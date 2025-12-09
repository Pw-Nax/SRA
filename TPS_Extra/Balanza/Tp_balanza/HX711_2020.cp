#line 1 "C:/Users/Alcides Ramos/Desktop/HX711 2020/HX711_2020.c"
#line 1 "c:/users/alcides ramos/desktop/hx711 2020/hx711.h"
extern sfr sbit hx711_dat;
extern sfr sbit hx711_ck ;


extern sfr sbit hx711_dat_dir;
extern sfr sbit hx711_ck_dir ;

extern signed long offset;


void hx711_init();
char hx711_pulso();
signed long hx711_lectura(unsigned char ganancia);
long hx711_promedio(unsigned char veces,unsigned char ganancia);
void tarar(unsigned char veces,unsigned char ganancia);
#line 3 "C:/Users/Alcides Ramos/Desktop/HX711 2020/HX711_2020.c"
sbit hx711_dat at portB.b6;
sbit hx711_ck at portB.b7;


sbit hx711_dat_dir at trisB.b6;
sbit hx711_ck_dir at trisB.b7;

const float offset_manual=83877.0;
const float calibra=419386.9 - offset_manual;
const float prueba=1000.0;


float factor=prueba/calibra;

signed long offset=offset_manual;


sbit sw_tarar at Rc6_bit;
sbit sw_cal at Rc7_bit;

sbit led at Rc0_bit;


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


signed long celda=0;
char texto[25];
float peso,cal;

 void floattostr_(float numero_, unsigned char *cadena_,char decimales_)
{

int largo_entera,largo_n,cont_for,tempo_int;
double tempo_float;

largo_n = decimales_+1;
largo_entera = 0;

if ( numero_ < 0)
 {
 *cadena_++ = '-';
 numero_ = -numero_;
 }

if (numero_ > 0.0) while (numero_ < 1.0)
 {
 numero_ =numero_* 10.0;
 largo_entera--;
 }


while (numero_ >= 10.0)
 {
 numero_ = numero_/10.0;
 largo_entera++;
 }
 largo_n = largo_n+largo_entera;



for (tempo_float = cont_for = 1; cont_for < largo_n; cont_for++)
 tempo_float = tempo_float/10.0;
numero_ += tempo_float/2.0;
if (numero_ >= 10.0) {numero_ = 1.0; largo_entera++;}

if (largo_entera<0)
 {
 *cadena_++ = '0'; *cadena_++ = '.';
 if (largo_n < 0) largo_entera = largo_entera-largo_n;
 for (cont_for = -1; cont_for > largo_entera; cont_for--) *cadena_++ = '0';
 }
for (cont_for=0; cont_for < largo_n; cont_for++)
 {
 tempo_int = numero_;
 *cadena_++ = tempo_int + 48;
 if (cont_for == largo_entera ) *cadena_++ = '.';
 numero_ -= (tempo_float=tempo_int);
 numero_ = numero_*10.0;
 }
*cadena_ =0;
}


void main()
{

 TRISC6_bit=1;
 TRISC7_bit=1;
 TRISC0_bit=0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(2,1,"PESO=");
 Delay_ms(500);
 hx711_init();
 Lcd_Out(1,1,"Offset=");
 floattostr_(offset,texto,1);
 Lcd_Out(1,8,texto);

 while (1)
 {


 peso=hx711_promedio(10,128)-(float)offset;
 peso=peso*factor;
 if (peso<=0) peso=0;
 floattostr_(peso,texto,1);
 Lcd_Out(2,10,"          ");
 Lcd_Out(2,10,texto);

 led=!led;
 Delay_ms(100);

 if(sw_tarar==0)
 {
 led=0;
 tarar(10,128);
 floattostr_(offset,texto,1);
 Lcd_Out(1,8,texto);

 }

 if (sw_cal==0)
 {
 led=0;
 cal=hx711_promedio(50,128)-(float)offset;
 factor= prueba/cal;

 }


 }



}
