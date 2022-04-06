
_InitTimer0:

;Rayito.c,54 :: 		void InitTimer0(unsigned short estado){
;Rayito.c,56 :: 		if(estado == 0){ //1 ms alto
	MOVF        FARG_InitTimer0_estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_InitTimer00
;Rayito.c,57 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,58 :: 		TMR0H         = 0xEC;
	MOVLW       236
	MOVWF       TMR0H+0 
;Rayito.c,59 :: 		TMR0L         = 0x78;
	MOVLW       120
	MOVWF       TMR0L+0 
;Rayito.c,60 :: 		GIE_bit         = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Rayito.c,61 :: 		TMR0IE_bit         = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Rayito.c,62 :: 		on = 0;
	CLRF        _on+0 
;Rayito.c,63 :: 		}
	GOTO        L_InitTimer01
L_InitTimer00:
;Rayito.c,64 :: 		else if(estado == 1){ //1.5 ms alto
	MOVF        FARG_InitTimer0_estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_InitTimer02
;Rayito.c,65 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,66 :: 		TMR0H         = 0xE2;
	MOVLW       226
	MOVWF       TMR0H+0 
;Rayito.c,67 :: 		TMR0L         = 0xB4; //valores inicilaes para desbordar en 1.5ms
	MOVLW       180
	MOVWF       TMR0L+0 
;Rayito.c,68 :: 		GIE_bit         = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Rayito.c,69 :: 		TMR0IE_bit         = 1; //set 1
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Rayito.c,70 :: 		on = 1;
	MOVLW       1
	MOVWF       _on+0 
;Rayito.c,71 :: 		}
	GOTO        L_InitTimer03
L_InitTimer02:
;Rayito.c,72 :: 		else if(estado == 2){ //1.35 ms alto
	MOVF        FARG_InitTimer0_estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_InitTimer04
;Rayito.c,73 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,74 :: 		TMR0H         = 0xE5;
	MOVLW       229
	MOVWF       TMR0H+0 
;Rayito.c,75 :: 		TMR0L         = 0xA2;
	MOVLW       162
	MOVWF       TMR0L+0 
;Rayito.c,76 :: 		GIE_bit         = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Rayito.c,77 :: 		TMR0IE_bit         = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Rayito.c,78 :: 		on = 2;
	MOVLW       2
	MOVWF       _on+0 
;Rayito.c,79 :: 		}
	GOTO        L_InitTimer05
L_InitTimer04:
;Rayito.c,80 :: 		else if(estado == 3){ //1.35 ms alto
	MOVF        FARG_InitTimer0_estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_InitTimer06
;Rayito.c,81 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,82 :: 		TMR0H         = 0xE3;
	MOVLW       227
	MOVWF       TMR0H+0 
;Rayito.c,83 :: 		TMR0L         = 0xAE;
	MOVLW       174
	MOVWF       TMR0L+0 
;Rayito.c,84 :: 		GIE_bit         = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Rayito.c,85 :: 		TMR0IE_bit         = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Rayito.c,86 :: 		on = 3;
	MOVLW       3
	MOVWF       _on+0 
;Rayito.c,87 :: 		}
L_InitTimer06:
L_InitTimer05:
L_InitTimer03:
L_InitTimer01:
;Rayito.c,88 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;Rayito.c,90 :: 		void Interrupt(){
;Rayito.c,91 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt7
;Rayito.c,92 :: 		if(ciclo == 1 && on == 1){
	MOVLW       0
	XORWF       _ciclo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt119
	MOVLW       1
	XORWF       _ciclo+0, 0 
L__Interrupt119:
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt10
	MOVF        _on+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt10
L__Interrupt111:
;Rayito.c,93 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Rayito.c,94 :: 		TMR0H         = 0xE2;    //permanece en alto por 1.5ms
	MOVLW       226
	MOVWF       TMR0H+0 
;Rayito.c,95 :: 		TMR0L         = 0xB4;
	MOVLW       180
	MOVWF       TMR0L+0 
;Rayito.c,96 :: 		TURBINA = 1;
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,97 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,98 :: 		ciclo = 0;
	CLRF        _ciclo+0 
	CLRF        _ciclo+1 
;Rayito.c,99 :: 		}
	GOTO        L_Interrupt11
L_Interrupt10:
;Rayito.c,100 :: 		else if(ciclo == 1 && on == 2){
	MOVLW       0
	XORWF       _ciclo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt120
	MOVLW       1
	XORWF       _ciclo+0, 0 
L__Interrupt120:
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt14
	MOVF        _on+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt14
L__Interrupt110:
;Rayito.c,101 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Rayito.c,102 :: 		TMR0H         = 0xE5;    //permanece en alto por 1.35ms
	MOVLW       229
	MOVWF       TMR0H+0 
;Rayito.c,103 :: 		TMR0L         = 0xA2;
	MOVLW       162
	MOVWF       TMR0L+0 
;Rayito.c,104 :: 		TURBINA = 1;
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,105 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,106 :: 		ciclo = 0;
	CLRF        _ciclo+0 
	CLRF        _ciclo+1 
;Rayito.c,107 :: 		}
	GOTO        L_Interrupt15
L_Interrupt14:
;Rayito.c,108 :: 		else if(ciclo == 1 && on == 3){
	MOVLW       0
	XORWF       _ciclo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt121
	MOVLW       1
	XORWF       _ciclo+0, 0 
L__Interrupt121:
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt18
	MOVF        _on+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt18
L__Interrupt109:
;Rayito.c,109 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Rayito.c,110 :: 		TMR0H         = 0xE3;    //permanece en alto por 1.5ms
	MOVLW       227
	MOVWF       TMR0H+0 
;Rayito.c,111 :: 		TMR0L         = 0xAE;
	MOVLW       174
	MOVWF       TMR0L+0 
;Rayito.c,112 :: 		TURBINA = 1;
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,113 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,114 :: 		ciclo = 0;
	CLRF        _ciclo+0 
	CLRF        _ciclo+1 
;Rayito.c,115 :: 		}
	GOTO        L_Interrupt19
L_Interrupt18:
;Rayito.c,116 :: 		else if(ciclo == 1 && on == 0){
	MOVLW       0
	XORWF       _ciclo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Interrupt122
	MOVLW       1
	XORWF       _ciclo+0, 0 
L__Interrupt122:
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt22
	MOVF        _on+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Interrupt22
L__Interrupt108:
;Rayito.c,117 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Rayito.c,118 :: 		TMR0H         = 0xEC;    //permanece en alto por 1.5ms
	MOVLW       236
	MOVWF       TMR0H+0 
;Rayito.c,119 :: 		TMR0L         = 0x78;
	MOVLW       120
	MOVWF       TMR0L+0 
;Rayito.c,120 :: 		TURBINA = 1;
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,121 :: 		T0CON         = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;Rayito.c,122 :: 		ciclo = 0;
	CLRF        _ciclo+0 
	CLRF        _ciclo+1 
;Rayito.c,123 :: 		}
	GOTO        L_Interrupt23
L_Interrupt22:
;Rayito.c,125 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Rayito.c,126 :: 		TMR0H         = 0x4B;   //permanece en 0 18.5ms
	MOVLW       75
	MOVWF       TMR0H+0 
;Rayito.c,127 :: 		TMR0L         = 0x56;
	MOVLW       86
	MOVWF       TMR0L+0 
;Rayito.c,128 :: 		TURBINA = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,129 :: 		T0CON         = 0x80;
	MOVLW       128
	MOVWF       T0CON+0 
;Rayito.c,130 :: 		ciclo = 1;
	MOVLW       1
	MOVWF       _ciclo+0 
	MOVLW       0
	MOVWF       _ciclo+1 
;Rayito.c,131 :: 		}
L_Interrupt23:
L_Interrupt19:
L_Interrupt15:
L_Interrupt11:
;Rayito.c,132 :: 		}
L_Interrupt7:
;Rayito.c,133 :: 		}
L_end_Interrupt:
L__Interrupt118:
	RETFIE      1
; end of _Interrupt

_leer_sens:

;Rayito.c,136 :: 		void leer_sens(){  //lee
;Rayito.c,138 :: 		RA4_bit=0; RA3_bit=0; RA2_bit=0; RA1_bit=0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,139 :: 		sensores[15]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+30 
	MOVF        R1, 0 
	MOVWF       _sensores+31 
;Rayito.c,141 :: 		RA4_bit=0; RA3_bit=0; RA2_bit=0; RA1_bit=1;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,142 :: 		sensores[14]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+28 
	MOVF        R1, 0 
	MOVWF       _sensores+29 
;Rayito.c,144 :: 		RA4_bit=0; RA3_bit=0; RA2_bit=1; RA1_bit=0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,145 :: 		sensores[13]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+26 
	MOVF        R1, 0 
	MOVWF       _sensores+27 
;Rayito.c,147 :: 		RA4_bit=0; RA3_bit=0; RA2_bit=1; RA1_bit=1;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,148 :: 		sensores[12]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+24 
	MOVF        R1, 0 
	MOVWF       _sensores+25 
;Rayito.c,150 :: 		RA4_bit=0; RA3_bit=1; RA2_bit=0; RA1_bit=0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,151 :: 		sensores[11]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+22 
	MOVF        R1, 0 
	MOVWF       _sensores+23 
;Rayito.c,153 :: 		RA4_bit=0; RA3_bit=1; RA2_bit=0; RA1_bit=1;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,154 :: 		sensores[10]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+20 
	MOVF        R1, 0 
	MOVWF       _sensores+21 
;Rayito.c,156 :: 		RA4_bit=0; RA3_bit=1; RA2_bit=1; RA1_bit=0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,157 :: 		sensores[9]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+18 
	MOVF        R1, 0 
	MOVWF       _sensores+19 
;Rayito.c,159 :: 		RA4_bit=0; RA3_bit=1; RA2_bit=1; RA1_bit=1;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,160 :: 		sensores[8]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+16 
	MOVF        R1, 0 
	MOVWF       _sensores+17 
;Rayito.c,162 :: 		RA4_bit=1; RA3_bit=0; RA2_bit=0; RA1_bit=0;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,163 :: 		sensores[7]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+14 
	MOVF        R1, 0 
	MOVWF       _sensores+15 
;Rayito.c,165 :: 		RA4_bit=1; RA3_bit=0; RA2_bit=0; RA1_bit=1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,166 :: 		sensores[6]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+12 
	MOVF        R1, 0 
	MOVWF       _sensores+13 
;Rayito.c,168 :: 		RA4_bit=1; RA3_bit=0; RA2_bit=1; RA1_bit=0;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,169 :: 		sensores[5]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+10 
	MOVF        R1, 0 
	MOVWF       _sensores+11 
;Rayito.c,171 :: 		RA4_bit=1; RA3_bit=0; RA2_bit=1; RA1_bit=1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,172 :: 		sensores[4]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+8 
	MOVF        R1, 0 
	MOVWF       _sensores+9 
;Rayito.c,174 :: 		RA4_bit=1; RA3_bit=1; RA2_bit=0; RA1_bit=0;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,175 :: 		sensores[3]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+6 
	MOVF        R1, 0 
	MOVWF       _sensores+7 
;Rayito.c,177 :: 		RA4_bit=1; RA3_bit=1; RA2_bit=0; RA1_bit=1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,178 :: 		sensores[2]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+4 
	MOVF        R1, 0 
	MOVWF       _sensores+5 
;Rayito.c,180 :: 		RA4_bit=1; RA3_bit=1; RA2_bit=1; RA1_bit=0;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,181 :: 		sensores[1]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+2 
	MOVF        R1, 0 
	MOVWF       _sensores+3 
;Rayito.c,183 :: 		RA4_bit=1; RA3_bit=1; RA2_bit=1; RA1_bit=1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;Rayito.c,184 :: 		sensores[0]=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sensores+0 
	MOVF        R1, 0 
	MOVWF       _sensores+1 
;Rayito.c,195 :: 		}  // combertimos los analogicos a digitales y los almacenamos en en el arreglo de sensores
L_end_leer_sens:
	RETURN      0
; end of _leer_sens

_calibrar_sens:

;Rayito.c,197 :: 		void calibrar_sens(int tiempo){
;Rayito.c,199 :: 		int k=0;
	CLRF        calibrar_sens_k_L0+0 
	CLRF        calibrar_sens_k_L0+1 
;Rayito.c,201 :: 		for(k=0;k<=tiempo;k++){
	CLRF        calibrar_sens_k_L0+0 
	CLRF        calibrar_sens_k_L0+1 
L_calibrar_sens24:
	MOVLW       128
	XORWF       FARG_calibrar_sens_tiempo+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       calibrar_sens_k_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__calibrar_sens125
	MOVF        calibrar_sens_k_L0+0, 0 
	SUBWF       FARG_calibrar_sens_tiempo+0, 0 
L__calibrar_sens125:
	BTFSS       STATUS+0, 0 
	GOTO        L_calibrar_sens25
;Rayito.c,202 :: 		LED1 = 1;
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
;Rayito.c,203 :: 		LED2 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;Rayito.c,204 :: 		LED3 = 1;
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
;Rayito.c,205 :: 		leer_sens();
	CALL        _leer_sens+0, 0
;Rayito.c,206 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_calibrar_sens27:
	DECFSZ      R13, 1, 1
	BRA         L_calibrar_sens27
	DECFSZ      R12, 1, 1
	BRA         L_calibrar_sens27
	DECFSZ      R11, 1, 1
	BRA         L_calibrar_sens27
	NOP
	NOP
;Rayito.c,209 :: 		vmax = sensores[0];
	MOVF        _sensores+0, 0 
	MOVWF       _vmax+0 
	MOVF        _sensores+1, 0 
	MOVWF       _vmax+1 
;Rayito.c,210 :: 		vmin = sensores[0];
	MOVF        _sensores+0, 0 
	MOVWF       _vmin+0 
	MOVF        _sensores+1, 0 
	MOVWF       _vmin+1 
;Rayito.c,211 :: 		for (i=0; i<=15; i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_calibrar_sens28:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__calibrar_sens126
	MOVF        _i+0, 0 
	SUBLW       15
L__calibrar_sens126:
	BTFSS       STATUS+0, 0 
	GOTO        L_calibrar_sens29
;Rayito.c,212 :: 		if (sensores[i]> vmax){
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       _vmax+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__calibrar_sens127
	MOVF        R1, 0 
	SUBWF       _vmax+0, 0 
L__calibrar_sens127:
	BTFSC       STATUS+0, 0 
	GOTO        L_calibrar_sens31
;Rayito.c,213 :: 		vmax=sensores[i];
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _vmax+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _vmax+1 
;Rayito.c,214 :: 		}
L_calibrar_sens31:
;Rayito.c,215 :: 		if (sensores[i]< vmin){
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _vmin+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__calibrar_sens128
	MOVF        _vmin+0, 0 
	SUBWF       R1, 0 
L__calibrar_sens128:
	BTFSC       STATUS+0, 0 
	GOTO        L_calibrar_sens32
;Rayito.c,216 :: 		vmin=sensores[i];
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _vmin+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _vmin+1 
;Rayito.c,217 :: 		}
L_calibrar_sens32:
;Rayito.c,211 :: 		for (i=0; i<=15; i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Rayito.c,218 :: 		}
	GOTO        L_calibrar_sens28
L_calibrar_sens29:
;Rayito.c,219 :: 		LED1 = 0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;Rayito.c,220 :: 		LED2 = 0;
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
;Rayito.c,221 :: 		LED3 = 0;
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;Rayito.c,222 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_calibrar_sens33:
	DECFSZ      R13, 1, 1
	BRA         L_calibrar_sens33
	DECFSZ      R12, 1, 1
	BRA         L_calibrar_sens33
	DECFSZ      R11, 1, 1
	BRA         L_calibrar_sens33
	NOP
	NOP
;Rayito.c,201 :: 		for(k=0;k<=tiempo;k++){
	INFSNZ      calibrar_sens_k_L0+0, 1 
	INCF        calibrar_sens_k_L0+1, 1 
;Rayito.c,223 :: 		}
	GOTO        L_calibrar_sens24
L_calibrar_sens25:
;Rayito.c,225 :: 		vprom=(vmax+vmin)/2;
	MOVF        _vmin+0, 0 
	ADDWF       _vmax+0, 0 
	MOVWF       _vprom+0 
	MOVF        _vmin+1, 0 
	ADDWFC      _vmax+1, 0 
	MOVWF       _vprom+1 
	RRCF        _vprom+1, 1 
	RRCF        _vprom+0, 1 
	BCF         _vprom+1, 7 
	BTFSC       _vprom+1, 6 
	BSF         _vprom+1, 7 
	BTFSS       _vprom+1, 7 
	GOTO        L__calibrar_sens129
	BTFSS       STATUS+0, 0 
	GOTO        L__calibrar_sens129
	INFSNZ      _vprom+0, 1 
	INCF        _vprom+1, 1 
L__calibrar_sens129:
;Rayito.c,226 :: 		}
L_end_calibrar_sens:
	RETURN      0
; end of _calibrar_sens

_binarizar:

;Rayito.c,228 :: 		void binarizar(){
;Rayito.c,229 :: 		leer_sens();// (muestreo de sensores)
	CALL        _leer_sens+0, 0
;Rayito.c,230 :: 		for(i=0;i<=15;i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_binarizar34:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binarizar131
	MOVF        _i+0, 0 
	SUBLW       15
L__binarizar131:
	BTFSS       STATUS+0, 0 
	GOTO        L_binarizar35
;Rayito.c,231 :: 		if(sensores[i]>vprom){  // 1=linea negra
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       _vprom+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binarizar132
	MOVF        R1, 0 
	SUBWF       _vprom+0, 0 
L__binarizar132:
	BTFSC       STATUS+0, 0 
	GOTO        L_binarizar37
;Rayito.c,232 :: 		sens_bin[i]=1;     //linea                                               //0= linea blanca
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sens_bin+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_sens_bin+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Rayito.c,233 :: 		}
L_binarizar37:
;Rayito.c,234 :: 		if(sensores[i]<vprom){
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sensores+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sensores+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _vprom+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binarizar133
	MOVF        _vprom+0, 0 
	SUBWF       R1, 0 
L__binarizar133:
	BTFSC       STATUS+0, 0 
	GOTO        L_binarizar38
;Rayito.c,235 :: 		sens_bin[i]=0;   // contorno
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sens_bin+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_sens_bin+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Rayito.c,236 :: 		}
L_binarizar38:
;Rayito.c,230 :: 		for(i=0;i<=15;i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Rayito.c,237 :: 		}
	GOTO        L_binarizar34
L_binarizar35:
;Rayito.c,239 :: 		num=sens_bin[0]*0+sens_bin[1]*1+sens_bin[2]*2+sens_bin[3]*3+sens_bin[4]*4+sens_bin[5]*5+sens_bin[6]*6+sens_bin[7]*7+sens_bin[8]*8+sens_bin[9]*9+sens_bin[10]*10+sens_bin[11]*11+sens_bin[12]*12+sens_bin[13]*13+sens_bin[14]*14+sens_bin[15]*15;
	MOVF        _sens_bin+4, 0 
	MOVWF       R0 
	MOVF        _sens_bin+5, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       _sens_bin+2, 0 
	MOVWF       FLOC__binarizar+0 
	MOVF        R1, 0 
	ADDWFC      _sens_bin+3, 0 
	MOVWF       FLOC__binarizar+1 
	MOVF        _sens_bin+6, 0 
	MOVWF       R0 
	MOVF        _sens_bin+7, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 0 
	MOVWF       R4 
	MOVF        _sens_bin+8, 0 
	MOVWF       R0 
	MOVF        _sens_bin+9, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FLOC__binarizar+0 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FLOC__binarizar+1 
	MOVF        _sens_bin+10, 0 
	MOVWF       R0 
	MOVF        _sens_bin+11, 0 
	MOVWF       R1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+12, 0 
	MOVWF       R0 
	MOVF        _sens_bin+13, 0 
	MOVWF       R1 
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+14, 0 
	MOVWF       R0 
	MOVF        _sens_bin+15, 0 
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        _sens_bin+16, 0 
	MOVWF       R0 
	MOVF        _sens_bin+17, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__binarizar134:
	BZ          L__binarizar135
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__binarizar134
L__binarizar135:
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FLOC__binarizar+0 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FLOC__binarizar+1 
	MOVF        _sens_bin+18, 0 
	MOVWF       R0 
	MOVF        _sens_bin+19, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+20, 0 
	MOVWF       R0 
	MOVF        _sens_bin+21, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+22, 0 
	MOVWF       R0 
	MOVF        _sens_bin+23, 0 
	MOVWF       R1 
	MOVLW       11
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+24, 0 
	MOVWF       R0 
	MOVF        _sens_bin+25, 0 
	MOVWF       R1 
	MOVLW       12
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+26, 0 
	MOVWF       R0 
	MOVF        _sens_bin+27, 0 
	MOVWF       R1 
	MOVLW       13
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+28, 0 
	MOVWF       R0 
	MOVF        _sens_bin+29, 0 
	MOVWF       R1 
	MOVLW       14
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__binarizar+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__binarizar+1, 1 
	MOVF        _sens_bin+30, 0 
	MOVWF       R0 
	MOVF        _sens_bin+31, 0 
	MOVWF       R1 
	MOVLW       15
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__binarizar+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__binarizar+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _num+0 
	MOVF        R1, 0 
	MOVWF       _num+1 
;Rayito.c,240 :: 		num=num*10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _num+0 
	MOVF        R1, 0 
	MOVWF       _num+1 
;Rayito.c,241 :: 		den=sens_bin[0]+sens_bin[1]+sens_bin[2]+sens_bin[3]+sens_bin[4]+sens_bin[5]+sens_bin[6]+sens_bin[7]+sens_bin[8]+sens_bin[9]+sens_bin[10]+sens_bin[11]+sens_bin[12]+sens_bin[13]+sens_bin[14]+sens_bin[15];
	MOVF        _sens_bin+2, 0 
	ADDWF       _sens_bin+0, 0 
	MOVWF       R0 
	MOVF        _sens_bin+3, 0 
	ADDWFC      _sens_bin+1, 0 
	MOVWF       R1 
	MOVF        _sens_bin+4, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+5, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+6, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+7, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+8, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+9, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+10, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+11, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+12, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+13, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+14, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+15, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+16, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+17, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+18, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+19, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+20, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+21, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+22, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+23, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+24, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+25, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+26, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+27, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+28, 0 
	ADDWF       R0, 1 
	MOVF        _sens_bin+29, 0 
	ADDWFC      R1, 1 
	MOVF        _sens_bin+30, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVF        _sens_bin+31, 0 
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       _den+0 
	MOVF        R3, 0 
	MOVWF       _den+1 
;Rayito.c,242 :: 		if(den == 0)
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binarizar136
	MOVLW       0
	XORWF       R2, 0 
L__binarizar136:
	BTFSS       STATUS+0, 2 
	GOTO        L_binarizar39
;Rayito.c,243 :: 		error = error;
	GOTO        L_binarizar40
L_binarizar39:
;Rayito.c,245 :: 		error=(num/den)-75;
	MOVF        _den+0, 0 
	MOVWF       R4 
	MOVF        _den+1, 0 
	MOVWF       R5 
	MOVF        _num+0, 0 
	MOVWF       R0 
	MOVF        _num+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       75
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       _error+0 
	MOVF        R1, 0 
	MOVWF       _error+1 
	MOVF        R2, 0 
	MOVWF       _error+2 
	MOVF        R3, 0 
	MOVWF       _error+3 
L_binarizar40:
;Rayito.c,246 :: 		}
L_end_binarizar:
	RETURN      0
; end of _binarizar

_prueba_sensores:

;Rayito.c,248 :: 		void prueba_sensores(int rango){
;Rayito.c,249 :: 		binarizar();
	CALL        _binarizar+0, 0
;Rayito.c,250 :: 		if(rango == 0){
	MOVLW       0
	XORWF       FARG_prueba_sensores_rango+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__prueba_sensores138
	MOVLW       0
	XORWF       FARG_prueba_sensores_rango+0, 0 
L__prueba_sensores138:
	BTFSS       STATUS+0, 2 
	GOTO        L_prueba_sensores41
;Rayito.c,251 :: 		LED1 = sens_bin[0];
	BTFSC       _sens_bin+0, 0 
	GOTO        L__prueba_sensores139
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L__prueba_sensores140
L__prueba_sensores139:
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
L__prueba_sensores140:
;Rayito.c,252 :: 		LED2 = sens_bin[1];
	BTFSC       _sens_bin+2, 0 
	GOTO        L__prueba_sensores141
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L__prueba_sensores142
L__prueba_sensores141:
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
L__prueba_sensores142:
;Rayito.c,253 :: 		LED3 = sens_bin[2];
	BTFSC       _sens_bin+4, 0 
	GOTO        L__prueba_sensores143
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L__prueba_sensores144
L__prueba_sensores143:
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
L__prueba_sensores144:
;Rayito.c,254 :: 		TURBINA = sens_bin[3];
	BTFSC       _sens_bin+6, 0 
	GOTO        L__prueba_sensores145
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L__prueba_sensores146
L__prueba_sensores145:
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
L__prueba_sensores146:
;Rayito.c,255 :: 		}
	GOTO        L_prueba_sensores42
L_prueba_sensores41:
;Rayito.c,257 :: 		else if(rango == 1){
	MOVLW       0
	XORWF       FARG_prueba_sensores_rango+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__prueba_sensores147
	MOVLW       1
	XORWF       FARG_prueba_sensores_rango+0, 0 
L__prueba_sensores147:
	BTFSS       STATUS+0, 2 
	GOTO        L_prueba_sensores43
;Rayito.c,258 :: 		LED1= sens_bin[4];
	BTFSC       _sens_bin+8, 0 
	GOTO        L__prueba_sensores148
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L__prueba_sensores149
L__prueba_sensores148:
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
L__prueba_sensores149:
;Rayito.c,259 :: 		LED2= sens_bin[5];
	BTFSC       _sens_bin+10, 0 
	GOTO        L__prueba_sensores150
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L__prueba_sensores151
L__prueba_sensores150:
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
L__prueba_sensores151:
;Rayito.c,260 :: 		LED3= sens_bin[6];
	BTFSC       _sens_bin+12, 0 
	GOTO        L__prueba_sensores152
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L__prueba_sensores153
L__prueba_sensores152:
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
L__prueba_sensores153:
;Rayito.c,261 :: 		TURBINA= sens_bin[7];
	BTFSC       _sens_bin+14, 0 
	GOTO        L__prueba_sensores154
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L__prueba_sensores155
L__prueba_sensores154:
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
L__prueba_sensores155:
;Rayito.c,262 :: 		}
	GOTO        L_prueba_sensores44
L_prueba_sensores43:
;Rayito.c,263 :: 		else if(rango == 2){
	MOVLW       0
	XORWF       FARG_prueba_sensores_rango+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__prueba_sensores156
	MOVLW       2
	XORWF       FARG_prueba_sensores_rango+0, 0 
L__prueba_sensores156:
	BTFSS       STATUS+0, 2 
	GOTO        L_prueba_sensores45
;Rayito.c,264 :: 		LED1= sens_bin[8];
	BTFSC       _sens_bin+16, 0 
	GOTO        L__prueba_sensores157
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L__prueba_sensores158
L__prueba_sensores157:
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
L__prueba_sensores158:
;Rayito.c,265 :: 		LED2= sens_bin[9];
	BTFSC       _sens_bin+18, 0 
	GOTO        L__prueba_sensores159
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L__prueba_sensores160
L__prueba_sensores159:
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
L__prueba_sensores160:
;Rayito.c,266 :: 		LED3= sens_bin[10];
	BTFSC       _sens_bin+20, 0 
	GOTO        L__prueba_sensores161
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L__prueba_sensores162
L__prueba_sensores161:
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
L__prueba_sensores162:
;Rayito.c,267 :: 		TURBINA= sens_bin[11];
	BTFSC       _sens_bin+22, 0 
	GOTO        L__prueba_sensores163
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L__prueba_sensores164
L__prueba_sensores163:
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
L__prueba_sensores164:
;Rayito.c,268 :: 		}
	GOTO        L_prueba_sensores46
L_prueba_sensores45:
;Rayito.c,269 :: 		else if(rango == 3){
	MOVLW       0
	XORWF       FARG_prueba_sensores_rango+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__prueba_sensores165
	MOVLW       3
	XORWF       FARG_prueba_sensores_rango+0, 0 
L__prueba_sensores165:
	BTFSS       STATUS+0, 2 
	GOTO        L_prueba_sensores47
;Rayito.c,270 :: 		LED1= sens_bin[12];
	BTFSC       _sens_bin+24, 0 
	GOTO        L__prueba_sensores166
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L__prueba_sensores167
L__prueba_sensores166:
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
L__prueba_sensores167:
;Rayito.c,271 :: 		LED2= sens_bin[13];
	BTFSC       _sens_bin+26, 0 
	GOTO        L__prueba_sensores168
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L__prueba_sensores169
L__prueba_sensores168:
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
L__prueba_sensores169:
;Rayito.c,272 :: 		LED3= sens_bin[14];
	BTFSC       _sens_bin+28, 0 
	GOTO        L__prueba_sensores170
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L__prueba_sensores171
L__prueba_sensores170:
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
L__prueba_sensores171:
;Rayito.c,273 :: 		TURBINA= sens_bin[15];
	BTFSC       _sens_bin+30, 0 
	GOTO        L__prueba_sensores172
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
	GOTO        L__prueba_sensores173
L__prueba_sensores172:
	BSF         RB3_bit+0, BitPos(RB3_bit+0) 
L__prueba_sensores173:
;Rayito.c,274 :: 		}
L_prueba_sensores47:
L_prueba_sensores46:
L_prueba_sensores44:
L_prueba_sensores42:
;Rayito.c,275 :: 		}
L_end_prueba_sensores:
	RETURN      0
; end of _prueba_sensores

_prueba_todo:

;Rayito.c,277 :: 		void prueba_todo(){
;Rayito.c,278 :: 		frente
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
	BSF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,279 :: 		pwm2_Set_Duty(100);     //m izq
	MOVLW       100
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,280 :: 		pwm1_Set_Duty(100);     //m der
	MOVLW       100
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,281 :: 		prueba_sensores(0);
	CLRF        FARG_prueba_sensores_rango+0 
	CLRF        FARG_prueba_sensores_rango+1 
	CALL        _prueba_sensores+0, 0
;Rayito.c,282 :: 		}
L_end_prueba_todo:
	RETURN      0
; end of _prueba_todo

_initTurbina:

;Rayito.c,284 :: 		void initTurbina(unsigned short modo){
;Rayito.c,285 :: 		InitTimer0(0);
	CLRF        FARG_InitTimer0_estado+0 
	CALL        _InitTimer0+0, 0
;Rayito.c,286 :: 		delay_ms(1500);
	MOVLW       39
	MOVWF       R11, 0
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       38
	MOVWF       R13, 0
L_initTurbina48:
	DECFSZ      R13, 1, 1
	BRA         L_initTurbina48
	DECFSZ      R12, 1, 1
	BRA         L_initTurbina48
	DECFSZ      R11, 1, 1
	BRA         L_initTurbina48
	NOP
;Rayito.c,287 :: 		InitTimer0(modo);
	MOVF        FARG_initTurbina_modo+0, 0 
	MOVWF       FARG_InitTimer0_estado+0 
	CALL        _InitTimer0+0, 0
;Rayito.c,288 :: 		}
L_end_initTurbina:
	RETURN      0
; end of _initTurbina

_usarTurbina:

;Rayito.c,291 :: 		void usarTurbina(unsigned short enable, unsigned short modo){
;Rayito.c,293 :: 		if(enable == 1){
	MOVF        FARG_usarTurbina_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_usarTurbina49
;Rayito.c,294 :: 		initTurbina(modo);
	MOVF        FARG_usarTurbina_modo+0, 0 
	MOVWF       FARG_initTurbina_modo+0 
	CALL        _initTurbina+0, 0
;Rayito.c,295 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_usarTurbina50:
	DECFSZ      R13, 1, 1
	BRA         L_usarTurbina50
	DECFSZ      R12, 1, 1
	BRA         L_usarTurbina50
	DECFSZ      R11, 1, 1
	BRA         L_usarTurbina50
	NOP
;Rayito.c,296 :: 		}
	GOTO        L_usarTurbina51
L_usarTurbina49:
;Rayito.c,297 :: 		else if (enable == 0){
	MOVF        FARG_usarTurbina_enable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_usarTurbina52
;Rayito.c,298 :: 		T0CON = 0x00;
	CLRF        T0CON+0 
;Rayito.c,299 :: 		TMR0H = 0x00;
	CLRF        TMR0H+0 
;Rayito.c,300 :: 		TMR0L = 0x00;
	CLRF        TMR0L+0 
;Rayito.c,301 :: 		GIE_bit = 0;
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;Rayito.c,302 :: 		TMR0IE_bit = 0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Rayito.c,303 :: 		TURBINA = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;Rayito.c,304 :: 		}
L_usarTurbina52:
L_usarTurbina51:
;Rayito.c,306 :: 		}
L_end_usarTurbina:
	RETURN      0
; end of _usarTurbina

_limpiar:

;Rayito.c,308 :: 		void limpiar(){
;Rayito.c,309 :: 		error = 0;
	CLRF        _error+0 
	CLRF        _error+1 
	CLRF        _error+2 
	CLRF        _error+3 
;Rayito.c,310 :: 		error_integral = 0;
	CLRF        _error_integral+0 
	CLRF        _error_integral+1 
	CLRF        _error_integral+2 
	CLRF        _error_integral+3 
;Rayito.c,311 :: 		error_pasado = 0;
	CLRF        _error_pasado+0 
	CLRF        _error_pasado+1 
	CLRF        _error_pasado+2 
	CLRF        _error_pasado+3 
;Rayito.c,312 :: 		PWM1_Set_Duty(0);//regulas cuantos V q se manda
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,313 :: 		PWM2_Set_Duty(0);
	CLRF        FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,314 :: 		parar
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
	BCF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,315 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_limpiar53:
	DECFSZ      R13, 1, 1
	BRA         L_limpiar53
	DECFSZ      R12, 1, 1
	BRA         L_limpiar53
	DECFSZ      R11, 1, 1
	BRA         L_limpiar53
	NOP
;Rayito.c,316 :: 		usarTurbina(1,0);
	MOVLW       1
	MOVWF       FARG_usarTurbina_enable+0 
	CLRF        FARG_usarTurbina_modo+0 
	CALL        _usarTurbina+0, 0
;Rayito.c,317 :: 		LED1 = 0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;Rayito.c,318 :: 		LED2 = 0;
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
;Rayito.c,319 :: 		LED3 = 0;
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;Rayito.c,320 :: 		}
L_end_limpiar:
	RETURN      0
; end of _limpiar

_uartSensors:

;Rayito.c,322 :: 		void uartSensors(){
;Rayito.c,323 :: 		binarizar();
	CALL        _binarizar+0, 0
;Rayito.c,324 :: 		for(i = 0; i<=15; i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_uartSensors54:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _i+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__uartSensors179
	MOVF        _i+0, 0 
	SUBLW       15
L__uartSensors179:
	BTFSS       STATUS+0, 0 
	GOTO        L_uartSensors55
;Rayito.c,325 :: 		UART1_Write(sens_bin[i] + 48);       // and send data via UART
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _sens_bin+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_sens_bin+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,326 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,324 :: 		for(i = 0; i<=15; i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Rayito.c,327 :: 		}
	GOTO        L_uartSensors54
L_uartSensors55:
;Rayito.c,328 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,329 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,330 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,331 :: 		IntToStr(error, txt);
	MOVF        _error+0, 0 
	MOVWF       R0 
	MOVF        _error+1, 0 
	MOVWF       R1 
	MOVF        _error+2, 0 
	MOVWF       R2 
	MOVF        _error+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Rayito.c,332 :: 		UART1_Write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,333 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,335 :: 		}
L_end_uartSensors:
	RETURN      0
; end of _uartSensors

_pid_bth:

;Rayito.c,337 :: 		void pid_bth(){
;Rayito.c,338 :: 		char valor = 0;
	CLRF        pid_bth_valor_L0+0 
;Rayito.c,340 :: 		if (UART1_Data_Ready()) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth57
;Rayito.c,341 :: 		valor = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       pid_bth_valor_L0+0 
;Rayito.c,343 :: 		switch (valor) // Selector es de tipo char o int
	GOTO        L_pid_bth58
;Rayito.c,345 :: 		case 0:
L_pid_bth60:
;Rayito.c,346 :: 		v1 = v1 + 10;
	MOVF        _v1+0, 0 
	MOVWF       R0 
	MOVF        _v1+1, 0 
	MOVWF       R1 
	MOVF        _v1+2, 0 
	MOVWF       R2 
	MOVF        _v1+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v1+0 
	MOVF        R1, 0 
	MOVWF       _v1+1 
	MOVF        R2, 0 
	MOVWF       _v1+2 
	MOVF        R3, 0 
	MOVWF       _v1+3 
;Rayito.c,347 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,348 :: 		case 1:
L_pid_bth61:
;Rayito.c,349 :: 		v1 = v1 - 10;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _v1+0, 0 
	MOVWF       R0 
	MOVF        _v1+1, 0 
	MOVWF       R1 
	MOVF        _v1+2, 0 
	MOVWF       R2 
	MOVF        _v1+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v1+0 
	MOVF        R1, 0 
	MOVWF       _v1+1 
	MOVF        R2, 0 
	MOVWF       _v1+2 
	MOVF        R3, 0 
	MOVWF       _v1+3 
;Rayito.c,350 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,351 :: 		case 2:
L_pid_bth62:
;Rayito.c,352 :: 		p1 = p1 + 0.5;
	MOVF        _p1+0, 0 
	MOVWF       R0 
	MOVF        _p1+1, 0 
	MOVWF       R1 
	MOVF        _p1+2, 0 
	MOVWF       R2 
	MOVF        _p1+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _p1+0 
	MOVF        R1, 0 
	MOVWF       _p1+1 
	MOVF        R2, 0 
	MOVWF       _p1+2 
	MOVF        R3, 0 
	MOVWF       _p1+3 
;Rayito.c,353 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,354 :: 		case 3:
L_pid_bth63:
;Rayito.c,355 :: 		p1 = p1 - 0.5;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        _p1+0, 0 
	MOVWF       R0 
	MOVF        _p1+1, 0 
	MOVWF       R1 
	MOVF        _p1+2, 0 
	MOVWF       R2 
	MOVF        _p1+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _p1+0 
	MOVF        R1, 0 
	MOVWF       _p1+1 
	MOVF        R2, 0 
	MOVWF       _p1+2 
	MOVF        R3, 0 
	MOVWF       _p1+3 
;Rayito.c,356 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,357 :: 		case 4:
L_pid_bth64:
;Rayito.c,358 :: 		d1 = d1 + 5;
	MOVF        _d1+0, 0 
	MOVWF       R0 
	MOVF        _d1+1, 0 
	MOVWF       R1 
	MOVF        _d1+2, 0 
	MOVWF       R2 
	MOVF        _d1+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _d1+0 
	MOVF        R1, 0 
	MOVWF       _d1+1 
	MOVF        R2, 0 
	MOVWF       _d1+2 
	MOVF        R3, 0 
	MOVWF       _d1+3 
;Rayito.c,359 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,360 :: 		case 5:
L_pid_bth65:
;Rayito.c,361 :: 		d1 = d1 - 5;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _d1+0, 0 
	MOVWF       R0 
	MOVF        _d1+1, 0 
	MOVWF       R1 
	MOVF        _d1+2, 0 
	MOVWF       R2 
	MOVF        _d1+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _d1+0 
	MOVF        R1, 0 
	MOVWF       _d1+1 
	MOVF        R2, 0 
	MOVWF       _d1+2 
	MOVF        R3, 0 
	MOVWF       _d1+3 
;Rayito.c,362 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,363 :: 		case 6:
L_pid_bth66:
;Rayito.c,364 :: 		i1 = i1 + 0.001;
	MOVF        _i1+0, 0 
	MOVWF       R0 
	MOVF        _i1+1, 0 
	MOVWF       R1 
	MOVF        _i1+2, 0 
	MOVWF       R2 
	MOVF        _i1+3, 0 
	MOVWF       R3 
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       117
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _i1+0 
	MOVF        R1, 0 
	MOVWF       _i1+1 
	MOVF        R2, 0 
	MOVWF       _i1+2 
	MOVF        R3, 0 
	MOVWF       _i1+3 
;Rayito.c,365 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,366 :: 		case 7:
L_pid_bth67:
;Rayito.c,367 :: 		i1 = i1 - 0.001;
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       117
	MOVWF       R7 
	MOVF        _i1+0, 0 
	MOVWF       R0 
	MOVF        _i1+1, 0 
	MOVWF       R1 
	MOVF        _i1+2, 0 
	MOVWF       R2 
	MOVF        _i1+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _i1+0 
	MOVF        R1, 0 
	MOVWF       _i1+1 
	MOVF        R2, 0 
	MOVWF       _i1+2 
	MOVF        R3, 0 
	MOVWF       _i1+3 
;Rayito.c,368 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,369 :: 		default:
L_pid_bth68:
;Rayito.c,371 :: 		break;
	GOTO        L_pid_bth59
;Rayito.c,372 :: 		}
L_pid_bth58:
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth60
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth61
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth62
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth63
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth64
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth65
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth66
	MOVF        pid_bth_valor_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth67
	GOTO        L_pid_bth68
L_pid_bth59:
;Rayito.c,374 :: 		if(v1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _v1+0, 0 
	MOVWF       R0 
	MOVF        _v1+1, 0 
	MOVWF       R1 
	MOVF        _v1+2, 0 
	MOVWF       R2 
	MOVF        _v1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth69
;Rayito.c,375 :: 		v1=0;
	CLRF        _v1+0 
	CLRF        _v1+1 
	CLRF        _v1+2 
	CLRF        _v1+3 
L_pid_bth69:
;Rayito.c,376 :: 		if(v1>255)
	MOVF        _v1+0, 0 
	MOVWF       R4 
	MOVF        _v1+1, 0 
	MOVWF       R5 
	MOVF        _v1+2, 0 
	MOVWF       R6 
	MOVF        _v1+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       127
	MOVWF       R2 
	MOVLW       134
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth70
;Rayito.c,377 :: 		v1 = 255;
	MOVLW       0
	MOVWF       _v1+0 
	MOVLW       0
	MOVWF       _v1+1 
	MOVLW       127
	MOVWF       _v1+2 
	MOVLW       134
	MOVWF       _v1+3 
L_pid_bth70:
;Rayito.c,378 :: 		if(p1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _p1+0, 0 
	MOVWF       R0 
	MOVF        _p1+1, 0 
	MOVWF       R1 
	MOVF        _p1+2, 0 
	MOVWF       R2 
	MOVF        _p1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth71
;Rayito.c,379 :: 		p1=0;
	CLRF        _p1+0 
	CLRF        _p1+1 
	CLRF        _p1+2 
	CLRF        _p1+3 
L_pid_bth71:
;Rayito.c,380 :: 		if(i1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _i1+0, 0 
	MOVWF       R0 
	MOVF        _i1+1, 0 
	MOVWF       R1 
	MOVF        _i1+2, 0 
	MOVWF       R2 
	MOVF        _i1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth72
;Rayito.c,381 :: 		i1=0;
	CLRF        _i1+0 
	CLRF        _i1+1 
	CLRF        _i1+2 
	CLRF        _i1+3 
L_pid_bth72:
;Rayito.c,382 :: 		if(d1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _d1+0, 0 
	MOVWF       R0 
	MOVF        _d1+1, 0 
	MOVWF       R1 
	MOVF        _d1+2, 0 
	MOVWF       R2 
	MOVF        _d1+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_pid_bth73
;Rayito.c,383 :: 		d1=0;
	CLRF        _d1+0 
	CLRF        _d1+1 
	CLRF        _d1+2 
	CLRF        _d1+3 
L_pid_bth73:
;Rayito.c,385 :: 		IntToStr(v1, txt);
	MOVF        _v1+0, 0 
	MOVWF       R0 
	MOVF        _v1+1, 0 
	MOVWF       R1 
	MOVF        _v1+2, 0 
	MOVWF       R2 
	MOVF        _v1+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Rayito.c,386 :: 		UART1_Write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,387 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,388 :: 		IntToStr(p1, txt);
	MOVF        _p1+0, 0 
	MOVWF       R0 
	MOVF        _p1+1, 0 
	MOVWF       R1 
	MOVF        _p1+2, 0 
	MOVWF       R2 
	MOVF        _p1+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Rayito.c,389 :: 		UART1_Write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,390 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,391 :: 		floatToStr(i1, txtf);
	MOVF        _i1+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _i1+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _i1+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _i1+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txtf+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txtf+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Rayito.c,392 :: 		UART1_Write_text(txtf);
	MOVLW       _txtf+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txtf+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,393 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,394 :: 		IntToStr(d1, txt);
	MOVF        _d1+0, 0 
	MOVWF       R0 
	MOVF        _d1+1, 0 
	MOVWF       R1 
	MOVF        _d1+2, 0 
	MOVWF       R2 
	MOVF        _d1+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Rayito.c,395 :: 		UART1_Write_text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,396 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,397 :: 		}
L_pid_bth57:
;Rayito.c,398 :: 		}
L_end_pid_bth:
	RETURN      0
; end of _pid_bth

_seguidor:

;Rayito.c,402 :: 		void seguidor(int Vel, int Vel_max, float kp, float kd, float ki, unsigned short frenos){
;Rayito.c,403 :: 		float ganancia=0;
	CLRF        seguidor_ganancia_L0+0 
	CLRF        seguidor_ganancia_L0+1 
	CLRF        seguidor_ganancia_L0+2 
	CLRF        seguidor_ganancia_L0+3 
;Rayito.c,406 :: 		binarizar();             //linea, contorno  //1=linea negra
	CALL        _binarizar+0, 0
;Rayito.c,408 :: 		if(error_integral>800)
	MOVF        _error_integral+0, 0 
	MOVWF       R4 
	MOVF        _error_integral+1, 0 
	MOVWF       R5 
	MOVF        _error_integral+2, 0 
	MOVWF       R6 
	MOVF        _error_integral+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       72
	MOVWF       R2 
	MOVLW       136
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor74
;Rayito.c,409 :: 		error_integral=800;
	MOVLW       0
	MOVWF       _error_integral+0 
	MOVLW       0
	MOVWF       _error_integral+1 
	MOVLW       72
	MOVWF       _error_integral+2 
	MOVLW       136
	MOVWF       _error_integral+3 
L_seguidor74:
;Rayito.c,410 :: 		if(error_integral<-800)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       200
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        _error_integral+0, 0 
	MOVWF       R0 
	MOVF        _error_integral+1, 0 
	MOVWF       R1 
	MOVF        _error_integral+2, 0 
	MOVWF       R2 
	MOVF        _error_integral+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor75
;Rayito.c,411 :: 		error_integral=-800;
	MOVLW       0
	MOVWF       _error_integral+0 
	MOVLW       0
	MOVWF       _error_integral+1 
	MOVLW       200
	MOVWF       _error_integral+2 
	MOVLW       136
	MOVWF       _error_integral+3 
L_seguidor75:
;Rayito.c,413 :: 		error_integral = error + error_integral;
	MOVF        _error+0, 0 
	MOVWF       R0 
	MOVF        _error+1, 0 
	MOVWF       R1 
	MOVF        _error+2, 0 
	MOVWF       R2 
	MOVF        _error+3, 0 
	MOVWF       R3 
	MOVF        _error_integral+0, 0 
	MOVWF       R4 
	MOVF        _error_integral+1, 0 
	MOVWF       R5 
	MOVF        _error_integral+2, 0 
	MOVWF       R6 
	MOVF        _error_integral+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__seguidor+4 
	MOVF        R1, 0 
	MOVWF       FLOC__seguidor+5 
	MOVF        R2, 0 
	MOVWF       FLOC__seguidor+6 
	MOVF        R3, 0 
	MOVWF       FLOC__seguidor+7 
	MOVF        FLOC__seguidor+4, 0 
	MOVWF       _error_integral+0 
	MOVF        FLOC__seguidor+5, 0 
	MOVWF       _error_integral+1 
	MOVF        FLOC__seguidor+6, 0 
	MOVWF       _error_integral+2 
	MOVF        FLOC__seguidor+7, 0 
	MOVWF       _error_integral+3 
;Rayito.c,414 :: 		ganancia = kp*error + kd*(error-error_pasado) + ki*(error_integral);
	MOVF        FARG_seguidor_kp+0, 0 
	MOVWF       R0 
	MOVF        FARG_seguidor_kp+1, 0 
	MOVWF       R1 
	MOVF        FARG_seguidor_kp+2, 0 
	MOVWF       R2 
	MOVF        FARG_seguidor_kp+3, 0 
	MOVWF       R3 
	MOVF        _error+0, 0 
	MOVWF       R4 
	MOVF        _error+1, 0 
	MOVWF       R5 
	MOVF        _error+2, 0 
	MOVWF       R6 
	MOVF        _error+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__seguidor+0 
	MOVF        R1, 0 
	MOVWF       FLOC__seguidor+1 
	MOVF        R2, 0 
	MOVWF       FLOC__seguidor+2 
	MOVF        R3, 0 
	MOVWF       FLOC__seguidor+3 
	MOVF        _error_pasado+0, 0 
	MOVWF       R4 
	MOVF        _error_pasado+1, 0 
	MOVWF       R5 
	MOVF        _error_pasado+2, 0 
	MOVWF       R6 
	MOVF        _error_pasado+3, 0 
	MOVWF       R7 
	MOVF        _error+0, 0 
	MOVWF       R0 
	MOVF        _error+1, 0 
	MOVWF       R1 
	MOVF        _error+2, 0 
	MOVWF       R2 
	MOVF        _error+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        FARG_seguidor_kd+0, 0 
	MOVWF       R4 
	MOVF        FARG_seguidor_kd+1, 0 
	MOVWF       R5 
	MOVF        FARG_seguidor_kd+2, 0 
	MOVWF       R6 
	MOVF        FARG_seguidor_kd+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__seguidor+0, 0 
	MOVWF       R4 
	MOVF        FLOC__seguidor+1, 0 
	MOVWF       R5 
	MOVF        FLOC__seguidor+2, 0 
	MOVWF       R6 
	MOVF        FLOC__seguidor+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__seguidor+0 
	MOVF        R1, 0 
	MOVWF       FLOC__seguidor+1 
	MOVF        R2, 0 
	MOVWF       FLOC__seguidor+2 
	MOVF        R3, 0 
	MOVWF       FLOC__seguidor+3 
	MOVF        FARG_seguidor_ki+0, 0 
	MOVWF       R0 
	MOVF        FARG_seguidor_ki+1, 0 
	MOVWF       R1 
	MOVF        FARG_seguidor_ki+2, 0 
	MOVWF       R2 
	MOVF        FARG_seguidor_ki+3, 0 
	MOVWF       R3 
	MOVF        FLOC__seguidor+4, 0 
	MOVWF       R4 
	MOVF        FLOC__seguidor+5, 0 
	MOVWF       R5 
	MOVF        FLOC__seguidor+6, 0 
	MOVWF       R6 
	MOVF        FLOC__seguidor+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__seguidor+0, 0 
	MOVWF       R4 
	MOVF        FLOC__seguidor+1, 0 
	MOVWF       R5 
	MOVF        FLOC__seguidor+2, 0 
	MOVWF       R6 
	MOVF        FLOC__seguidor+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_ganancia_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_ganancia_L0+1 
	MOVF        R2, 0 
	MOVWF       seguidor_ganancia_L0+2 
	MOVF        R3, 0 
	MOVWF       seguidor_ganancia_L0+3 
;Rayito.c,415 :: 		error_pasado = error;
	MOVF        _error+0, 0 
	MOVWF       _error_pasado+0 
	MOVF        _error+1, 0 
	MOVWF       _error_pasado+1 
	MOVF        _error+2, 0 
	MOVWF       _error_pasado+2 
	MOVF        _error+3, 0 
	MOVWF       _error_pasado+3 
;Rayito.c,417 :: 		if(error < - 70){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       140
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _error+0, 0 
	MOVWF       R0 
	MOVF        _error+1, 0 
	MOVWF       R1 
	MOVF        _error+2, 0 
	MOVWF       R2 
	MOVF        _error+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor76
;Rayito.c,418 :: 		izquierda
	BSF         RD0_bit+0, BitPos(RD0_bit+0) 
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
	BSF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,419 :: 		pwmA = vel_max;  //MI
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmA_L0+1 
;Rayito.c,420 :: 		pwmB = vel_max;  //MD
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmB_L0+1 
;Rayito.c,421 :: 		LED3=1;
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
;Rayito.c,422 :: 		}
	GOTO        L_seguidor77
L_seguidor76:
;Rayito.c,423 :: 		else if(error >= 70){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       12
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _error+0, 0 
	MOVWF       R0 
	MOVF        _error+1, 0 
	MOVWF       R1 
	MOVF        _error+2, 0 
	MOVWF       R2 
	MOVF        _error+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor78
;Rayito.c,424 :: 		derecha
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
	BCF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,425 :: 		pwmA = vel_max;  //MI
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmA_L0+1 
;Rayito.c,426 :: 		pwmB = vel_max;  //MD
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmB_L0+1 
;Rayito.c,427 :: 		LED3=0;
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;Rayito.c,428 :: 		}
	GOTO        L_seguidor79
L_seguidor78:
;Rayito.c,431 :: 		if(abs(ganancia)>vel){
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R0 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R1 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R2 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORWF       FARG_seguidor_Vel+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__seguidor182
	MOVF        R0, 0 
	SUBWF       FARG_seguidor_Vel+0, 0 
L__seguidor182:
	BTFSC       STATUS+0, 0 
	GOTO        L_seguidor80
;Rayito.c,432 :: 		if(ganancia>0){
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor81
;Rayito.c,433 :: 		derecha
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
	BCF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,434 :: 		pwmA = vel+ganancia;  //MI
	MOVF        FARG_seguidor_Vel+0, 0 
	MOVWF       R0 
	MOVF        FARG_seguidor_Vel+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmA_L0+1 
;Rayito.c,435 :: 		pwmB = (-vel+ganancia);  //MD
	MOVF        FARG_seguidor_Vel+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        FARG_seguidor_Vel+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	CALL        _int2double+0, 0
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmB_L0+1 
;Rayito.c,436 :: 		}
	GOTO        L_seguidor82
L_seguidor81:
;Rayito.c,437 :: 		else if(ganancia<0){
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R0 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R1 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R2 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_seguidor83
;Rayito.c,438 :: 		izquierda
	BSF         RD0_bit+0, BitPos(RD0_bit+0) 
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
	BSF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,439 :: 		pwmA = (-vel-ganancia);  //izq
	MOVF        FARG_seguidor_Vel+0, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        FARG_seguidor_Vel+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	CALL        _int2double+0, 0
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmA_L0+1 
;Rayito.c,440 :: 		pwmB = vel-ganancia;  //der
	MOVF        FARG_seguidor_Vel+0, 0 
	MOVWF       R0 
	MOVF        FARG_seguidor_Vel+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmB_L0+1 
;Rayito.c,441 :: 		}
L_seguidor83:
L_seguidor82:
;Rayito.c,442 :: 		}
	GOTO        L_seguidor84
L_seguidor80:
;Rayito.c,444 :: 		frente
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
	BSF         RD3_bit+0, BitPos(RD3_bit+0) 
;Rayito.c,445 :: 		pwmA=vel+ganancia;  //izq
	MOVF        FARG_seguidor_Vel+0, 0 
	MOVWF       R0 
	MOVF        FARG_seguidor_Vel+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__seguidor+0 
	MOVF        R1, 0 
	MOVWF       FLOC__seguidor+1 
	MOVF        R2, 0 
	MOVWF       FLOC__seguidor+2 
	MOVF        R3, 0 
	MOVWF       FLOC__seguidor+3 
	MOVF        FLOC__seguidor+0, 0 
	MOVWF       R0 
	MOVF        FLOC__seguidor+1, 0 
	MOVWF       R1 
	MOVF        FLOC__seguidor+2, 0 
	MOVWF       R2 
	MOVF        FLOC__seguidor+3, 0 
	MOVWF       R3 
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmA_L0+1 
;Rayito.c,446 :: 		pwmB=vel-ganancia;  //der
	MOVF        seguidor_ganancia_L0+0, 0 
	MOVWF       R4 
	MOVF        seguidor_ganancia_L0+1, 0 
	MOVWF       R5 
	MOVF        seguidor_ganancia_L0+2, 0 
	MOVWF       R6 
	MOVF        seguidor_ganancia_L0+3, 0 
	MOVWF       R7 
	MOVF        FLOC__seguidor+0, 0 
	MOVWF       R0 
	MOVF        FLOC__seguidor+1, 0 
	MOVWF       R1 
	MOVF        FLOC__seguidor+2, 0 
	MOVWF       R2 
	MOVF        FLOC__seguidor+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        R1, 0 
	MOVWF       seguidor_pwmB_L0+1 
;Rayito.c,455 :: 		}
L_seguidor84:
;Rayito.c,456 :: 		}
L_seguidor79:
L_seguidor77:
;Rayito.c,458 :: 		if(pwmA>vel_max)
	MOVLW       128
	XORWF       FARG_seguidor_Vel_max+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       seguidor_pwmA_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__seguidor183
	MOVF        seguidor_pwmA_L0+0, 0 
	SUBWF       FARG_seguidor_Vel_max+0, 0 
L__seguidor183:
	BTFSC       STATUS+0, 0 
	GOTO        L_seguidor85
;Rayito.c,459 :: 		pwmA=vel_max;
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmA_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmA_L0+1 
L_seguidor85:
;Rayito.c,460 :: 		if(pwmB>vel_max)
	MOVLW       128
	XORWF       FARG_seguidor_Vel_max+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       seguidor_pwmB_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__seguidor184
	MOVF        seguidor_pwmB_L0+0, 0 
	SUBWF       FARG_seguidor_Vel_max+0, 0 
L__seguidor184:
	BTFSC       STATUS+0, 0 
	GOTO        L_seguidor86
;Rayito.c,461 :: 		pwmB=vel_max;
	MOVF        FARG_seguidor_Vel_max+0, 0 
	MOVWF       seguidor_pwmB_L0+0 
	MOVF        FARG_seguidor_Vel_max+1, 0 
	MOVWF       seguidor_pwmB_L0+1 
L_seguidor86:
;Rayito.c,462 :: 		if(pwmA<0)
	MOVLW       128
	XORWF       seguidor_pwmA_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__seguidor185
	MOVLW       0
	SUBWF       seguidor_pwmA_L0+0, 0 
L__seguidor185:
	BTFSC       STATUS+0, 0 
	GOTO        L_seguidor87
;Rayito.c,463 :: 		pwmA=0;
	CLRF        seguidor_pwmA_L0+0 
	CLRF        seguidor_pwmA_L0+1 
L_seguidor87:
;Rayito.c,464 :: 		if(pwmB<0)
	MOVLW       128
	XORWF       seguidor_pwmB_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__seguidor186
	MOVLW       0
	SUBWF       seguidor_pwmB_L0+0, 0 
L__seguidor186:
	BTFSC       STATUS+0, 0 
	GOTO        L_seguidor88
;Rayito.c,465 :: 		pwmB=0;
	CLRF        seguidor_pwmB_L0+0 
	CLRF        seguidor_pwmB_L0+1 
L_seguidor88:
;Rayito.c,467 :: 		pwm2_Set_Duty(pwmA);     //m izq
	MOVF        seguidor_pwmA_L0+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,468 :: 		pwm1_Set_Duty(pwmB);     //m der
	MOVF        seguidor_pwmB_L0+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,469 :: 		}
L_end_seguidor:
	RETURN      0
; end of _seguidor

_main:

;Rayito.c,473 :: 		void main() {
;Rayito.c,476 :: 		unsigned short frenos_on = 1, t = 0;
;Rayito.c,477 :: 		CMCON=0X07;
	MOVLW       7
	MOVWF       CMCON+0 
;Rayito.c,478 :: 		ADC_Init();//inicialisa el combertidor analogico digital
	CALL        _ADC_Init+0, 0
;Rayito.c,480 :: 		TRISA=0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;Rayito.c,481 :: 		TRISB=0b00110000;
	MOVLW       48
	MOVWF       TRISB+0 
;Rayito.c,482 :: 		TRISC=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;Rayito.c,483 :: 		TRISD=0b11010000;
	MOVLW       208
	MOVWF       TRISD+0 
;Rayito.c,486 :: 		ADCON0.ADON=1;
	BSF         ADCON0+0, 0 
;Rayito.c,487 :: 		ADCON1=0b00001110;  //ANALOG-->Delay_us AN0-AN3
	MOVLW       14
	MOVWF       ADCON1+0 
;Rayito.c,488 :: 		ADCON2=0b10101110;
	MOVLW       174
	MOVWF       ADCON2+0 
;Rayito.c,490 :: 		PORTA=0X00;
	CLRF        PORTA+0 
;Rayito.c,491 :: 		PORTB=0X00;
	CLRF        PORTB+0 
;Rayito.c,492 :: 		PORTC=0X00;
	CLRF        PORTC+0 
;Rayito.c,493 :: 		PORTD=0X00;
	CLRF        PORTD+0 
;Rayito.c,495 :: 		PWM1_Init(25000); //inicia el pwm
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       199
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;Rayito.c,496 :: 		PWM2_Init(25000);
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       199
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;Rayito.c,497 :: 		PWM1_Start();  //arranca el pwm
	CALL        _PWM1_Start+0, 0
;Rayito.c,498 :: 		PWM2_Start();
	CALL        _PWM2_Start+0, 0
;Rayito.c,499 :: 		PWM1_Set_Duty(0);//regulas cuantos V q se manda
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,500 :: 		PWM2_Set_Duty(0);
	CLRF        FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,501 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main89:
	DECFSZ      R13, 1, 1
	BRA         L_main89
	DECFSZ      R12, 1, 1
	BRA         L_main89
	DECFSZ      R11, 1, 1
	BRA         L_main89
	NOP
	NOP
;Rayito.c,503 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Rayito.c,504 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main90:
	DECFSZ      R13, 1, 1
	BRA         L_main90
	DECFSZ      R12, 1, 1
	BRA         L_main90
	DECFSZ      R11, 1, 1
	BRA         L_main90
	NOP
	NOP
;Rayito.c,506 :: 		UART1_Write_Text("Rayito");
	MOVLW       ?lstr1_Rayito+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Rayito+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Rayito.c,507 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,508 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Rayito.c,510 :: 		pwm2_Set_Duty(0);     //m izq
	CLRF        FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,511 :: 		pwm1_Set_Duty(0);     //m der
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,513 :: 		calibrar_sens(50);
	MOVLW       50
	MOVWF       FARG_calibrar_sens_tiempo+0 
	MOVLW       0
	MOVWF       FARG_calibrar_sens_tiempo+1 
	CALL        _calibrar_sens+0, 0
;Rayito.c,514 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main91:
	DECFSZ      R13, 1, 1
	BRA         L_main91
	DECFSZ      R12, 1, 1
	BRA         L_main91
	DECFSZ      R11, 1, 1
	BRA         L_main91
	NOP
;Rayito.c,517 :: 		if ((SW1 == 0) && (SW2 == 0)){ //CON TURBINA SOMBRA BEST
	BTFSC       RD6_bit+0, BitPos(RD6_bit+0) 
	GOTO        L_main94
	BTFSC       RD7_bit+0, BitPos(RD7_bit+0) 
	GOTO        L_main94
L__main115:
;Rayito.c,518 :: 		v1 = 100; //150
	MOVLW       0
	MOVWF       _v1+0 
	MOVLW       0
	MOVWF       _v1+1 
	MOVLW       72
	MOVWF       _v1+2 
	MOVLW       133
	MOVWF       _v1+3 
;Rayito.c,519 :: 		p1 = 4;   //10.5
	MOVLW       0
	MOVWF       _p1+0 
	MOVLW       0
	MOVWF       _p1+1 
	MOVLW       0
	MOVWF       _p1+2 
	MOVLW       129
	MOVWF       _p1+3 
;Rayito.c,520 :: 		i1 = 0.001;  //0.001
	MOVLW       111
	MOVWF       _i1+0 
	MOVLW       18
	MOVWF       _i1+1 
	MOVLW       3
	MOVWF       _i1+2 
	MOVLW       117
	MOVWF       _i1+3 
;Rayito.c,521 :: 		d1 = 100;    //200
	MOVLW       0
	MOVWF       _d1+0 
	MOVLW       0
	MOVWF       _d1+1 
	MOVLW       72
	MOVWF       _d1+2 
	MOVLW       133
	MOVWF       _d1+3 
;Rayito.c,524 :: 		}
L_main94:
;Rayito.c,525 :: 		if ((SW1 == 0) && (SW2 == 1)){
	BTFSC       RD6_bit+0, BitPos(RD6_bit+0) 
	GOTO        L_main97
	BTFSS       RD7_bit+0, BitPos(RD7_bit+0) 
	GOTO        L_main97
L__main114:
;Rayito.c,526 :: 		v1 = 120;
	MOVLW       0
	MOVWF       _v1+0 
	MOVLW       0
	MOVWF       _v1+1 
	MOVLW       112
	MOVWF       _v1+2 
	MOVLW       133
	MOVWF       _v1+3 
;Rayito.c,527 :: 		p1 = 8.5;
	MOVLW       0
	MOVWF       _p1+0 
	MOVLW       0
	MOVWF       _p1+1 
	MOVLW       8
	MOVWF       _p1+2 
	MOVLW       130
	MOVWF       _p1+3 
;Rayito.c,528 :: 		i1 = 0.002;
	MOVLW       111
	MOVWF       _i1+0 
	MOVLW       18
	MOVWF       _i1+1 
	MOVLW       3
	MOVWF       _i1+2 
	MOVLW       118
	MOVWF       _i1+3 
;Rayito.c,529 :: 		d1 = 140;
	MOVLW       0
	MOVWF       _d1+0 
	MOVLW       0
	MOVWF       _d1+1 
	MOVLW       12
	MOVWF       _d1+2 
	MOVLW       134
	MOVWF       _d1+3 
;Rayito.c,532 :: 		}
L_main97:
;Rayito.c,533 :: 		if ((SW1 == 1) && (SW2 == 0)){
	BTFSS       RD6_bit+0, BitPos(RD6_bit+0) 
	GOTO        L_main100
	BTFSC       RD7_bit+0, BitPos(RD7_bit+0) 
	GOTO        L_main100
L__main113:
;Rayito.c,534 :: 		v1 = 190;
	MOVLW       0
	MOVWF       _v1+0 
	MOVLW       0
	MOVWF       _v1+1 
	MOVLW       62
	MOVWF       _v1+2 
	MOVLW       134
	MOVWF       _v1+3 
;Rayito.c,535 :: 		p1 = 6;
	MOVLW       0
	MOVWF       _p1+0 
	MOVLW       0
	MOVWF       _p1+1 
	MOVLW       64
	MOVWF       _p1+2 
	MOVLW       129
	MOVWF       _p1+3 
;Rayito.c,536 :: 		i1 = 0.001;
	MOVLW       111
	MOVWF       _i1+0 
	MOVLW       18
	MOVWF       _i1+1 
	MOVLW       3
	MOVWF       _i1+2 
	MOVLW       117
	MOVWF       _i1+3 
;Rayito.c,537 :: 		d1 = 55;
	MOVLW       0
	MOVWF       _d1+0 
	MOVLW       0
	MOVWF       _d1+1 
	MOVLW       92
	MOVWF       _d1+2 
	MOVLW       132
	MOVWF       _d1+3 
;Rayito.c,540 :: 		}
L_main100:
;Rayito.c,541 :: 		if ((SW1 == 1) && (SW2 == 1)){//SIN TURBINA SOMBRA
	BTFSS       RD6_bit+0, BitPos(RD6_bit+0) 
	GOTO        L_main103
	BTFSS       RD7_bit+0, BitPos(RD7_bit+0) 
	GOTO        L_main103
L__main112:
;Rayito.c,542 :: 		v1 = 215;
	MOVLW       0
	MOVWF       _v1+0 
	MOVLW       0
	MOVWF       _v1+1 
	MOVLW       87
	MOVWF       _v1+2 
	MOVLW       134
	MOVWF       _v1+3 
;Rayito.c,543 :: 		p1 = 5;
	MOVLW       0
	MOVWF       _p1+0 
	MOVLW       0
	MOVWF       _p1+1 
	MOVLW       32
	MOVWF       _p1+2 
	MOVLW       129
	MOVWF       _p1+3 
;Rayito.c,544 :: 		i1 = 0.001;
	MOVLW       111
	MOVWF       _i1+0 
	MOVLW       18
	MOVWF       _i1+1 
	MOVLW       3
	MOVWF       _i1+2 
	MOVLW       117
	MOVWF       _i1+3 
;Rayito.c,545 :: 		d1 = 100;
	MOVLW       0
	MOVWF       _d1+0 
	MOVLW       0
	MOVWF       _d1+1 
	MOVLW       72
	MOVWF       _d1+2 
	MOVLW       133
	MOVWF       _d1+3 
;Rayito.c,548 :: 		}
L_main103:
;Rayito.c,549 :: 		limpiar();
	CALL        _limpiar+0, 0
;Rayito.c,550 :: 		while(1){
L_main104:
;Rayito.c,552 :: 		pwm2_set_duty(200);
	MOVLW       200
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;Rayito.c,553 :: 		pwm1_set_duty(200);
	MOVLW       200
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;Rayito.c,554 :: 		RD1_bit = 1;
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
;Rayito.c,555 :: 		RD2_bit = 1;
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
;Rayito.c,556 :: 		delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main106:
	DECFSZ      R13, 1, 1
	BRA         L_main106
	DECFSZ      R12, 1, 1
	BRA         L_main106
	DECFSZ      R11, 1, 1
	BRA         L_main106
	NOP
	NOP
;Rayito.c,557 :: 		RD1_bit = 0;
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
;Rayito.c,558 :: 		RD2_bit = 0;
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
;Rayito.c,559 :: 		delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main107:
	DECFSZ      R13, 1, 1
	BRA         L_main107
	DECFSZ      R12, 1, 1
	BRA         L_main107
	DECFSZ      R11, 1, 1
	BRA         L_main107
	NOP
	NOP
;Rayito.c,589 :: 		}
	GOTO        L_main104
;Rayito.c,590 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
