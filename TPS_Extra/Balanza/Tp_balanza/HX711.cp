#line 1 "C:/Users/Alcides Ramos/Desktop/HX711 2020/HX711.c"
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
#line 3 "C:/Users/Alcides Ramos/Desktop/HX711 2020/HX711.c"
extern signed long offset;



void hx711_init()
{ hx711_ck_dir=0;
 hx711_dat_dir=1;
 hx711_ck=0;
 Delay_ms(500);
}

char hx711_pulso()
{
char lei;

 hx711_ck=1;
 Delay_us(1);
 lei=hx711_dat;
 hx711_ck=0;
 Delay_us(1);
 return lei;
}

signed long hx711_lectura(unsigned char ganancia)
{
signed int hx711_cont;
signed long hx711_dato=0;


 while (hx711_dat==1);


 for (hx711_cont=23;hx711_cont>=0;hx711_cont--)
 {
 if (hx711_pulso()==1)
 {
 hx711_dato=hx711_dato +( 1L<<hx711_cont);
 }
 }
 Delay_us(100);

 if (ganancia==128) hx711_pulso();
 else if (ganancia==32)
 {
 hx711_pulso();
 Delay_us(100);
 hx711_pulso();

 }
 else if (ganancia==64)
 {
 hx711_pulso();
 Delay_us(100);
 hx711_pulso();
 Delay_us(100);
 hx711_pulso();
 }



 if ((hx711_dato & 0x800000)!=0)
 {
 hx711_dato=hx711_dato | 0xff000000;
 return (-hx711_dato);
 }
 else return (hx711_dato);

}

signed long hx711_promedio(unsigned char veces,unsigned char ganancia)
 {
 signed long prom = 0;
 unsigned char cont;

 for (cont = 0; cont < veces; cont++)
 {
 prom =prom+ hx711_lectura(ganancia);
 Delay_ms(100);
 }
 return (prom / cont);
}

void tarar(unsigned char veces,unsigned char ganancia)
 {
 offset=hx711_promedio(veces,ganancia);

}
