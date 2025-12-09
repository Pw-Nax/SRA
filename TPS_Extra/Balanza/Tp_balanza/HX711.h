extern sfr  sbit hx711_dat;
extern sfr sbit hx711_ck ;


extern sfr sbit hx711_dat_dir;
extern sfr sbit hx711_ck_dir ;

extern signed long offset;


void hx711_init();   //inicia el hx711
char hx711_pulso();       //un pulso para leer un bit
signed long hx711_lectura(unsigned char ganancia);   //funcion de lectura general
long hx711_promedio(unsigned char veces,unsigned char ganancia); //lectura con promedio
void tarar(unsigned char veces,unsigned char ganancia);   //captura el offset tara la balanza: numero de datos, a que ganancia