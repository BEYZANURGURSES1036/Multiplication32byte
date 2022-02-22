
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 0h

start:

SUB AX,AX
SUB BX,BX
SUB CX,CX
SUB DX,DX
SUB SI,SI
SUB DI,DI
        
MOV WORD PTR [0300h],0ABCDH  ;32 bitlik carpanin 16-0 bitini bellege yerlestirme
MOV WORD PTR [0302h],0EFFFH  ;32 bitlik carpanin 32-16 bitini bellege yerlestirme
MOV WORD PTR [0600h],0ABCDH  ;32 bitlik carpilanin 16-0 bitini bellege yerlestirme
MOV WORD PTR [0602h],0EF00H  ;32 bitlik carpilanin 32-16 bitini bellege yerlestirme

MOV WORD PTR [0700h],0000h  ;Carpim sonucunun 16-0  arasi bellek adresi
MOV WORD PTR [0702h],0000h  ;Carpim sonucunun 32-16  arasi bellek adresi
MOV WORD PTR [0704h],0000h  ;Carpim sonucunun 48-32  arasi bellek adresi
MOV WORD PTR [0706h],0000h  ;Carpim sonucunun 64-48  arasi bellek adresi


MOV SI,32       ;dongu degiskeni (32 kez donmesi icin)    

tekrar:

MOV BX,[300h]   ;Carpanin alt 16 bitini BX register'a aktarma
AND BX,01H 	    ;Carpanin LSB biti haricindeki bitlerini sifirlama
XOR BX,01H	    ;Carpanin en anlamsiz biti lojik 1 mi?
JZ topla_kaydir ;Evet ise Carpim sonucunu Carpilan ile topla ve bir bit saga kaydirma
CLC	

devam:

MOV AX,[0706h]
RCR AX,1        ;carpim sonucunun 64-48 bitini saga kaydirma
MOV [0706h],AX
MOV BX,[0704h]      
RCR BX,1        ;carpim sonucunun 48-32 bitini saga kaydirma
MOV [0704h],BX
MOV CX,[0702h]
RCR CX,1        ;carpim sonucunun 32-16 bitini saga kaydirma
MOV [0702h],CX	
MOV DX,[0700h]
RCR DX,1        ;carpim sonucunun 16-0 bitini saga kaydirma
MOV [0700h],DX	  
MOV AX,[0302h]
ROR AX,1        ;carpani bir bit saga kaydirma
MOV [0302h],AX 
MOV BX,[0300h]
RCR BX,1        
MOV [0300h],BX 
   		
DEC SI		;Dongu degiskenini azaltma
CMP SI,0	;degiskenin 0 kontrolu
JNZ tekrar	;0 degilse, ayni islemleri tekrarla
JMP son		;uygulamayi bitirme 


topla_kaydir: 

MOV DX,[0600h]	;DX'e carpilanin alt 16 bitini kopyalama
ADD [0704h],DX  
MOV DX,[0602h]  ;DX'e carpilanin ust 16 bitini kopyalama
ADC [0706h],DX  
JMP devam  


son:



ret




