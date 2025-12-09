
_hx711_init:

;HX711.c,7 :: 		void hx711_init()
;HX711.c,8 :: 		{  hx711_ck_dir=0;   // salida pin reloj
	BCF        hx711_ck_dir+0, BitPos(hx711_ck_dir+0)
;HX711.c,9 :: 		hx711_dat_dir=1;    // entrada pin dato
	BSF        hx711_dat_dir+0, BitPos(hx711_dat_dir+0)
;HX711.c,10 :: 		hx711_ck=0; //saca cero por el reloj
	BCF        hx711_ck+0, BitPos(hx711_ck+0)
;HX711.c,11 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_hx711_init0:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_init0
	DECFSZ     R12+0, 1
	GOTO       L_hx711_init0
	DECFSZ     R11+0, 1
	GOTO       L_hx711_init0
	NOP
	NOP
;HX711.c,12 :: 		}
L_end_hx711_init:
	RETURN
; end of _hx711_init

_hx711_pulso:

;HX711.c,14 :: 		char hx711_pulso()
;HX711.c,18 :: 		hx711_ck=1; //saca uno por el reloj
	BSF        hx711_ck+0, BitPos(hx711_ck+0)
;HX711.c,19 :: 		Delay_us(1);
	NOP
;HX711.c,20 :: 		lei=hx711_dat;
	MOVLW      0
	BTFSC      hx711_dat+0, BitPos(hx711_dat+0)
	MOVLW      1
	MOVWF      R1+0
;HX711.c,21 :: 		hx711_ck=0; //saca cero por el reloj
	BCF        hx711_ck+0, BitPos(hx711_ck+0)
;HX711.c,22 :: 		Delay_us(1);
	NOP
;HX711.c,23 :: 		return lei;
	MOVF       R1+0, 0
	MOVWF      R0+0
;HX711.c,24 :: 		}
L_end_hx711_pulso:
	RETURN
; end of _hx711_pulso

_hx711_lectura:

;HX711.c,26 :: 		signed long hx711_lectura(unsigned char ganancia)
;HX711.c,29 :: 		signed long hx711_dato=0;
	CLRF       hx711_lectura_hx711_dato_L0+0
	CLRF       hx711_lectura_hx711_dato_L0+1
	CLRF       hx711_lectura_hx711_dato_L0+2
	CLRF       hx711_lectura_hx711_dato_L0+3
;HX711.c,32 :: 		while (hx711_dat==1);//   que no este ocuapdo el modulo
L_hx711_lectura1:
	BTFSS      hx711_dat+0, BitPos(hx711_dat+0)
	GOTO       L_hx711_lectura2
	GOTO       L_hx711_lectura1
L_hx711_lectura2:
;HX711.c,35 :: 		for (hx711_cont=23;hx711_cont>=0;hx711_cont--)
	MOVLW      23
	MOVWF      hx711_lectura_hx711_cont_L0+0
	MOVLW      0
	MOVWF      hx711_lectura_hx711_cont_L0+1
L_hx711_lectura3:
	MOVLW      128
	XORWF      hx711_lectura_hx711_cont_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__hx711_lectura25
	MOVLW      0
	SUBWF      hx711_lectura_hx711_cont_L0+0, 0
L__hx711_lectura25:
	BTFSS      STATUS+0, 0
	GOTO       L_hx711_lectura4
;HX711.c,37 :: 		if (hx711_pulso()==1)
	CALL       _hx711_pulso+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_hx711_lectura6
;HX711.c,39 :: 		hx711_dato=hx711_dato +( 1L<<hx711_cont);
	MOVF       hx711_lectura_hx711_cont_L0+0, 0
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      0
	MOVWF      R0+2
	MOVLW      0
	MOVWF      R0+3
	MOVF       R4+0, 0
L__hx711_lectura26:
	BTFSC      STATUS+0, 2
	GOTO       L__hx711_lectura27
	RLF        R0+0, 1
	RLF        R0+1, 1
	RLF        R0+2, 1
	RLF        R0+3, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__hx711_lectura26
L__hx711_lectura27:
	MOVF       R0+0, 0
	ADDWF      hx711_lectura_hx711_dato_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      hx711_lectura_hx711_dato_L0+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      hx711_lectura_hx711_dato_L0+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      hx711_lectura_hx711_dato_L0+3, 1
;HX711.c,40 :: 		}
L_hx711_lectura6:
;HX711.c,35 :: 		for (hx711_cont=23;hx711_cont>=0;hx711_cont--)
	MOVLW      1
	SUBWF      hx711_lectura_hx711_cont_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       hx711_lectura_hx711_cont_L0+1, 1
;HX711.c,41 :: 		}     //end for
	GOTO       L_hx711_lectura3
L_hx711_lectura4:
;HX711.c,42 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L_hx711_lectura7:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_lectura7
;HX711.c,44 :: 		if (ganancia==128)  hx711_pulso();
	MOVF       FARG_hx711_lectura_ganancia+0, 0
	XORLW      128
	BTFSS      STATUS+0, 2
	GOTO       L_hx711_lectura8
	CALL       _hx711_pulso+0
	GOTO       L_hx711_lectura9
L_hx711_lectura8:
;HX711.c,45 :: 		else if (ganancia==32)
	MOVF       FARG_hx711_lectura_ganancia+0, 0
	XORLW      32
	BTFSS      STATUS+0, 2
	GOTO       L_hx711_lectura10
;HX711.c,47 :: 		hx711_pulso();
	CALL       _hx711_pulso+0
;HX711.c,48 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L_hx711_lectura11:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_lectura11
;HX711.c,49 :: 		hx711_pulso();
	CALL       _hx711_pulso+0
;HX711.c,51 :: 		}
	GOTO       L_hx711_lectura12
L_hx711_lectura10:
;HX711.c,52 :: 		else if (ganancia==64)
	MOVF       FARG_hx711_lectura_ganancia+0, 0
	XORLW      64
	BTFSS      STATUS+0, 2
	GOTO       L_hx711_lectura13
;HX711.c,54 :: 		hx711_pulso();
	CALL       _hx711_pulso+0
;HX711.c,55 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L_hx711_lectura14:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_lectura14
;HX711.c,56 :: 		hx711_pulso();
	CALL       _hx711_pulso+0
;HX711.c,57 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L_hx711_lectura15:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_lectura15
;HX711.c,58 :: 		hx711_pulso();
	CALL       _hx711_pulso+0
;HX711.c,59 :: 		}
L_hx711_lectura13:
L_hx711_lectura12:
L_hx711_lectura9:
;HX711.c,63 :: 		if ((hx711_dato & 0x800000)!=0)
	MOVLW      0
	ANDWF      hx711_lectura_hx711_dato_L0+0, 0
	MOVWF      R1+0
	MOVLW      0
	ANDWF      hx711_lectura_hx711_dato_L0+1, 0
	MOVWF      R1+1
	MOVLW      128
	ANDWF      hx711_lectura_hx711_dato_L0+2, 0
	MOVWF      R1+2
	MOVLW      0
	ANDWF      hx711_lectura_hx711_dato_L0+3, 0
	MOVWF      R1+3
	MOVLW      0
	MOVWF      R0+0
	XORWF      R1+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__hx711_lectura28
	MOVF       R0+0, 0
	XORWF      R1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__hx711_lectura28
	MOVF       R0+0, 0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__hx711_lectura28
	MOVF       R1+0, 0
	XORLW      0
L__hx711_lectura28:
	BTFSC      STATUS+0, 2
	GOTO       L_hx711_lectura16
;HX711.c,65 :: 		hx711_dato=hx711_dato | 0xff000000;  //lo convierte a 32 bit con signo
	MOVLW      0
	IORWF      hx711_lectura_hx711_dato_L0+0, 0
	MOVWF      R8+0
	MOVLW      0
	IORWF      hx711_lectura_hx711_dato_L0+1, 0
	MOVWF      R8+1
	MOVLW      0
	IORWF      hx711_lectura_hx711_dato_L0+2, 0
	MOVWF      R8+2
	MOVLW      255
	IORWF      hx711_lectura_hx711_dato_L0+3, 0
	MOVWF      R8+3
	MOVF       R8+0, 0
	MOVWF      hx711_lectura_hx711_dato_L0+0
	MOVF       R8+1, 0
	MOVWF      hx711_lectura_hx711_dato_L0+1
	MOVF       R8+2, 0
	MOVWF      hx711_lectura_hx711_dato_L0+2
	MOVF       R8+3, 0
	MOVWF      hx711_lectura_hx711_dato_L0+3
;HX711.c,66 :: 		return  (-hx711_dato);// Se coloca - si no se quiere regersar valor negado
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	MOVF       R4+2, 0
	MOVWF      R0+2
	MOVF       R4+3, 0
	MOVWF      R0+3
	MOVF       R8+0, 0
	SUBWF      R0+0, 1
	MOVF       R8+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R8+1, 0
	SUBWF      R0+1, 1
	MOVF       R8+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R8+2, 0
	SUBWF      R0+2, 1
	MOVF       R8+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R8+3, 0
	SUBWF      R0+3, 1
	GOTO       L_end_hx711_lectura
;HX711.c,67 :: 		}
L_hx711_lectura16:
;HX711.c,68 :: 		else     return  (hx711_dato);
	MOVF       hx711_lectura_hx711_dato_L0+0, 0
	MOVWF      R0+0
	MOVF       hx711_lectura_hx711_dato_L0+1, 0
	MOVWF      R0+1
	MOVF       hx711_lectura_hx711_dato_L0+2, 0
	MOVWF      R0+2
	MOVF       hx711_lectura_hx711_dato_L0+3, 0
	MOVWF      R0+3
;HX711.c,70 :: 		}
L_end_hx711_lectura:
	RETURN
; end of _hx711_lectura

_hx711_promedio:

;HX711.c,72 :: 		signed long hx711_promedio(unsigned char veces,unsigned char ganancia)   //numero de datos, a que ganancia
;HX711.c,74 :: 		signed long prom = 0;
	CLRF       hx711_promedio_prom_L0+0
	CLRF       hx711_promedio_prom_L0+1
	CLRF       hx711_promedio_prom_L0+2
	CLRF       hx711_promedio_prom_L0+3
;HX711.c,77 :: 		for (cont = 0; cont < veces; cont++)
	CLRF       hx711_promedio_cont_L0+0
L_hx711_promedio18:
	MOVF       FARG_hx711_promedio_veces+0, 0
	SUBWF      hx711_promedio_cont_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_hx711_promedio19
;HX711.c,79 :: 		prom =prom+  hx711_lectura(ganancia);
	MOVF       FARG_hx711_promedio_ganancia+0, 0
	MOVWF      FARG_hx711_lectura_ganancia+0
	CALL       _hx711_lectura+0
	MOVF       R0+0, 0
	ADDWF      hx711_promedio_prom_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      hx711_promedio_prom_L0+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      hx711_promedio_prom_L0+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      hx711_promedio_prom_L0+3, 1
;HX711.c,80 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_hx711_promedio21:
	DECFSZ     R13+0, 1
	GOTO       L_hx711_promedio21
	DECFSZ     R12+0, 1
	GOTO       L_hx711_promedio21
	NOP
	NOP
;HX711.c,77 :: 		for (cont = 0; cont < veces; cont++)
	INCF       hx711_promedio_cont_L0+0, 1
;HX711.c,81 :: 		}
	GOTO       L_hx711_promedio18
L_hx711_promedio19:
;HX711.c,82 :: 		return (prom / cont);
	MOVF       hx711_promedio_cont_L0+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       hx711_promedio_prom_L0+0, 0
	MOVWF      R0+0
	MOVF       hx711_promedio_prom_L0+1, 0
	MOVWF      R0+1
	MOVF       hx711_promedio_prom_L0+2, 0
	MOVWF      R0+2
	MOVF       hx711_promedio_prom_L0+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
;HX711.c,83 :: 		}
L_end_hx711_promedio:
	RETURN
; end of _hx711_promedio

_tarar:

;HX711.c,85 :: 		void tarar(unsigned char veces,unsigned char ganancia)   //numero de datos, a que ganancia
;HX711.c,87 :: 		offset=hx711_promedio(veces,ganancia);
	MOVF       FARG_tarar_veces+0, 0
	MOVWF      FARG_hx711_promedio_veces+0
	MOVF       FARG_tarar_ganancia+0, 0
	MOVWF      FARG_hx711_promedio_ganancia+0
	CALL       _hx711_promedio+0
	MOVF       R0+0, 0
	MOVWF      _offset+0
	MOVF       R0+1, 0
	MOVWF      _offset+1
	MOVF       R0+2, 0
	MOVWF      _offset+2
	MOVF       R0+3, 0
	MOVWF      _offset+3
;HX711.c,89 :: 		}
L_end_tarar:
	RETURN
; end of _tarar
