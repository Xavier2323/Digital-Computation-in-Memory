** DCIM **
** Environment setting **

.include 'testcases.sp'

**********************************************
*** Don't modify the pin name in this file ***
**********************************************

.ic V(Xdcim.Xcim1.W10)=1.8v V(Xdcim.Xcim1.W11)=0v V(Xdcim.Xcim1.W12)=0v V(Xdcim.Xcim1.W13)=0v
.ic V(Xdcim.Xcim1.W20)=1.8v V(Xdcim.Xcim1.W21)=1.8v V(Xdcim.Xcim1.W22)=0v V(Xdcim.Xcim1.W23)=0v
.ic V(Xdcim.Xcim1.W30)=1.8v V(Xdcim.Xcim1.W31)=1.8v V(Xdcim.Xcim1.W32)=1.8v V(Xdcim.Xcim1.W33)=0v
.ic V(Xdcim.Xcim1.W40)=1.8v V(Xdcim.Xcim1.W41)=1.8v V(Xdcim.Xcim1.W42)=1.8v V(Xdcim.Xcim1.W43)=1.8v
.ic V(Xdcim.Xcim2.W10)=0v V(Xdcim.Xcim2.W11)=1.8v V(Xdcim.Xcim2.W12)=0v V(Xdcim.Xcim2.W13)=0v
.ic V(Xdcim.Xcim2.W20)=0v V(Xdcim.Xcim2.W21)=1.8v V(Xdcim.Xcim2.W22)=1.8v V(Xdcim.Xcim2.W23)=0v
.ic V(Xdcim.Xcim2.W30)=0v V(Xdcim.Xcim2.W31)=0v V(Xdcim.Xcim2.W32)=0v V(Xdcim.Xcim2.W33)=1.8v
.ic V(Xdcim.Xcim2.W40)=0v V(Xdcim.Xcim2.W41)=0v V(Xdcim.Xcim2.W42)=1.8v V(Xdcim.Xcim2.W43)=1.8v

*****************
*** call cell ***
*****************
Xdcim I1 I2 I3 I4 IN_VAL CLK RST O10 O11 O12 O13 O14 O15 O16 O17 O18 O19 O20 O21 O22 O23 O24 O25 O26 O27 O28 O29 OUT_VAL DCIM


******************
*** DCIM block ***
******************
.subckt DCIM I1 I2 I3 I4 IN_VAL CLK RST O10 O11 O12 O13 O14 O15 O16 O17 O18 O19 O20 O21 O22 O23 O24 O25 O26 O27 O28 O29 OUT_VAL

** Your code **

Xcontrol_in I1 I2 I3 I4 CLK IN_VAL ii1 ii2 ii3 ii4 CON_IN
Xcim1 ii1 ii2 ii3 ii4 P10 P11 P12 P13 P14 P15 COMPUTE
Xcim2 ii1 ii2 ii3 ii4 P20 P21 P22 P23 P24 P25 COMPUTE
Xcontrol_out1 P10 P11 P12 P13 P14 P15 GND GND GND GND CLK RST O10 O11 O12 O13 O14 O15 O16 O17 O18 O19 CON_OUT
Xcontrol_out2 P20 P21 P22 P23 P24 P25 GND GND GND GND CLK RST O20 O21 O22 O23 O24 O25 O26 O27 O28 O29 CON_OUT
Xdff1 IN_VAL CLK RST IN_VAL_T_1 IN_VAL_T_1_INV DFF
Xdff2 IN_VAL_T_1 CLK RST IN_VAL_T_2 IN_VAL_T_2_INV DFF
Xnor IN_VAL_T_1 IN_VAL_T_2_INV OUT_VAL NOR2
.ends

************************
*** input controller ***
************************
.subckt CON_IN I1 I2 I3 I4 CLK ENB ii1 ii2 ii3 ii4 
*** Your code ***
Xinv CLK CLK_INV INV
Xand1 I1 ENB N1 AND2
Xand2 I2 ENB N2 AND2
Xand3 I3 ENB N3 AND2
Xand4 I4 ENB N4 AND2
Xdlatch1_master N1 CLK Y1 Y1_INV DLATCH
Xdlatch1_slave Y1 CLK_INV ii1 ii1_INV DLATCH
Xdlatch2_master N2 CLK Y2 Y2_INV DLATCH
Xdlatch2_slave Y2 CLK_INV ii2 ii2_INV DLATCH
Xdlatch3_master N3 CLK Y3 Y3_INV DLATCH
Xdlatch3_slave Y3 CLK_INV ii3 ii3_INV DLATCH
Xdlatch4_master N4 CLK Y4 Y4_INV DLATCH
Xdlatch4_slave Y4 CLK_INV ii4 ii4_INV DLATCH
.ends

*************************
*** output controller ***
*************************
.subckt CON_OUT P0 P1 P2 P3 P4 P5 P6 P7 P8 P9 CLK RST O0 O1 O2 O3 O4 O5 O6 O7 O8 O9
*** Your code ***
Xadder9 GND P0 P1 P2 P3 P4 P5 P6 P7 P8 GND O0 O1 O2 O3 O4 O5 O6 O7 S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 ADDER9
Xreg10 S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 CLK RST O0 O1 O2 O3 O4 O5 O6 O7 O8 O9 REG10
.ends

*******************
*** Your subckt ***
*******************

.subckt INV IN OUT
Mp1 OUT IN VDD VDD p_18 l=0.18u w=0.72u
Mn1 OUT IN GND GND n_18 l=0.18u w=0.36u
.ends

.subckt NOR2 IN1 IN2 OUT
Mp1 N1 IN1 VDD VDD p_18 l=0.18u w=0.72u
Mp2 OUT IN2 N1 VDD p_18 l=0.18u w=0.72u
Mn1 OUT IN1 GND GND n_18 l=0.18u w=0.36u
Mn2 OUT IN2 GND GND n_18 l=0.18u w=0.36u
.ends

.subckt NAND2 IN1 IN2 OUT
Mp1 OUT IN1 VDD VDD p_18 l=0.18u w=0.72u
Mp2 OUT IN2 VDD VDD p_18 l=0.18u w=0.72u
Mn1 N1 IN1 GND GND n_18 l=0.18u w=0.36u
Mn2 OUT IN2 N1 GND n_18 l=0.18u w=0.36u
.ends

.subckt AND2 IN1 IN2 OUT
Xnand2 IN1 IN2 N1 NAND2
Xinv N1 OUT INV
.ends

.subckt OR2 IN1 IN2 OUT
Xnor2 IN1 IN2 N1 NOR2
Xinv N1 OUT INV
.ends

.subckt XOR2 IN1 IN2 OUT
Xinv1 IN1 IN1_INV INV
Xinv2 IN2 IN2_INV INV
Mp1 N1 IN2_INV VDD VDD p_18 l=0.18u w=0.72u
Mp2 OUT IN1 N1 VDD p_18 l=0.18u w=0.72u
Mp3 N2 IN2 VDD VDD p_18 l=0.18u w=0.72u
Mp4 OUT IN1_INV N2 VDD p_18 l=0.18u w=0.72u
Mn1 N3 IN1 GND GND n_18 l=0.18u w=0.36u
Mn2 OUT IN2 N3 GND n_18 l=0.18u w=0.36u
Mn3 N4 IN1_INV GND GND n_18 l=0.18u w=0.36u
Mn4 OUT IN2_INV N4 GND n_18 l=0.18u w=0.36u
.ends


*************************
*** Bit Multiplier ***
*************************
.subckt BIT_MUL IN1 IN2 OUT
Xand IN1 IN2 OUT AND2
.ends

*************************
*** 4-bit Multiplier ***
*************************
.subckt MUL4 W0 W1 W2 W3 IN O0 O1 O2 O3
Xmul1 IN W0 O0 BIT_MUL
Xmul2 IN W1 O1 BIT_MUL
Xmul3 IN W2 O2 BIT_MUL
Xmul4 IN W3 O3 BIT_MUL
.ends

*************************
*** Half-Adder ***
*************************
.subckt HA A B SUM CARRY
Xxor A B SUM XOR2
Xand A B CARRY AND2
.ends

*************************
*** Full-Adder ***
*************************
.subckt FA A B CIN SUM COUT
Xxor1 A B N1 XOR2
Xxor2 N1 CIN SUM XOR2
Xand1 A B N2 AND2
Xand2 N1 CIN N3 AND2
Xor N2 N3 COUT OR2
.ends

*************************
*** 4-bit Adder ***
*************************
.subckt ADDER4 CIN A0 A1 A2 A3 B0 B1 B2 B3 S0 S1 S2 S3 COUT
Xfa1 A0 B0 CIN S0 C1 FA
Xfa2 A1 B1 C1 S1 C2 FA
Xfa3 A2 B2 C2 S2 C3 FA
Xfa4 A3 B3 C3 S3 COUT FA
.ends

*************************
*** 5-bit Adder ***
*************************
.subckt ADDER5 CIN A0 A1 A2 A3 A4 B0 B1 B2 B3 B4 S0 S1 S2 S3 S4 COUT
Xfa1 A0 B0 CIN S0 C1 FA
Xfa2 A1 B1 C1 S1 C2 FA
Xfa3 A2 B2 C2 S2 C3 FA
Xfa4 A3 B3 C3 S3 C4 FA
Xfa5 A4 B4 C4 S4 COUT FA
.ends

*************************
*** 4 of 4 bit Adder Tree ***
*************************
.subckt ADDER_TREE4 CIN I10 I11 I12 I13 I20 I21 I22 I23 I30 I31 I32 I33 I40 I41 I42 I43 S0 S1 S2 S3 S4 S5
Xadder41 CIN I10 I11 I12 I13 I20 I21 I22 I23 TP10 TP11 TP12 TP13 TP14 ADDER4
Xadder42 CIN I30 I31 I32 I33 I40 I41 I42 I43 TP20 TP21 TP22 TP23 TP24 ADDER4
Xadder5 CIN TP10 TP11 TP12 TP13 TP14 TP20 TP21 TP22 TP23 TP24 S0 S1 S2 S3 S4 S5 ADDER5
.ends

*************************
*** Latch ***
.subckt LATCH W
Xinv1 TMP W INV
Xinv2 W TMP INV
.ends

*************************
*** Compute Cell ***
.subckt COMPUTE I1 I2 I3 I4 S0 S1 S2 S3 S4 S5
Xlatch1 W10 LATCH
Xlatch2 W11 LATCH
Xlatch3 W12 LATCH
Xlatch4 W13 LATCH
Xlatch5 W20 LATCH
Xlatch6 W21 LATCH
Xlatch7 W22 LATCH
Xlatch8 W23 LATCH
Xlatch9 W30 LATCH
Xlatch10 W31 LATCH
Xlatch11 W32 LATCH
Xlatch12 W33 LATCH
Xlatch13 W40 LATCH
Xlatch14 W41 LATCH
Xlatch15 W42 LATCH
Xlatch16 W43 LATCH

Xmul41 W10 W11 W12 W13 I1 O10 O11 O12 O13 MUL4
Xmul42 W20 W21 W22 W23 I2 O20 O21 O22 O23 MUL4
Xmul43 W30 W31 W32 W33 I3 O30 O31 O32 O33 MUL4
Xmul44 W40 W41 W42 W43 I4 O40 O41 O42 O43 MUL4
Xadder_tree1 GND O10 O11 O12 O13 O20 O21 O22 O23 O30 O31 O32 O33 O40 O41 O42 O43 S0 S1 S2 S3 S4 S5 ADDER_TREE4
.ends

*************************
*** 9-bit Adder ***
*************************
.subckt ADDER9 CIN A0 A1 A2 A3 A4 A5 A6 A7 A8 B0 B1 B2 B3 B4 B5 B6 B7 B8 S0 S1 S2 S3 S4 S5 S6 S7 S8 COUT
Xfa1 A0 B0 CIN S0 C1 FA
Xfa2 A1 B1 C1 S1 C2 FA
Xfa3 A2 B2 C2 S2 C3 FA
Xfa4 A3 B3 C3 S3 C4 FA
Xfa5 A4 B4 C4 S4 C5 FA
Xfa6 A5 B5 C5 S5 C6 FA
Xfa7 A6 B6 C6 S6 C7 FA
Xfa8 A7 B7 C7 S7 C8 FA
Xfa9 A8 B8 C8 S8 COUT FA
.ends

*************************
*** D latch ***
.subckt DLATCH D ENB Q Q_INV
Xinv D D_INV INV
Xnand21 D ENB N1 NAND2
Xnand22 D_INV ENB N2 NAND2
Xnand23 N1 Q_INV Q NAND2
Xnand24 N2 Q Q_INV NAND2
.ends

*    *************************
*    *** D flip-flop ***
*    *************************
*    .subckt DFF D CLK RST Q Q_INV
*    Xinv1 CLK CLK_INV INV
*    Mn1 N1 CLK_INV D GND n_18 l=0.18u w=0.36u
*    Xnand1 N1 RST N2 NAND2
*    Xinv2 N2 N3 INV
*    Mn2 N1 CLK N3 GND n_18 l=0.18u w=0.36u
*    Mn3 N4 CLK N2 GND n_18 l=0.18u w=0.36u
*    Xinv3 N4 Q INV
*    Xnand2 Q RST Q_INV NAND2
*    Mn4 N4 CLK_INV Q_INV GND n_18 l=0.18u w=0.36u
*    .ends

*************************
*** D flip-flop ***
*************************
.subckt DFF DI CLK RST Q Q_INV
Xand1 DI RST D AND2
Xinv1 CLK CLK_INV INV
Mn1 N1 CLK_INV D GND n_18 l=0.18u w=0.36u
Xnand1 N1 VDD N2 NAND2
Xinv2 N2 N3 INV
Mn2 N1 CLK N3 GND n_18 l=0.18u w=0.36u
Mn3 N4 CLK N2 GND n_18 l=0.18u w=0.36u
Xinv3 N4 Q INV
Xnand2 Q VDD Q_INV NAND2
Mn4 N4 CLK_INV Q_INV GND n_18 l=0.18u w=0.36u
.ends


*************************
*** 10-bit Register ***
*************************
.subckt REG10 I0 I1 I2 I3 I4 I5 I6 I7 I8 I9 CLK ENB O0 O1 O2 O3 O4 O5 O6 O7 O8 O9
Xdff1 I0 CLK ENB O0 O0_INV DFF
Xdff2 I1 CLK ENB O1 O1_INV DFF
Xdff3 I2 CLK ENB O2 O2_INV DFF
Xdff4 I3 CLK ENB O3 O3_INV DFF
Xdff5 I4 CLK ENB O4 O4_INV DFF
Xdff6 I5 CLK ENB O5 O5_INV DFF
Xdff7 I6 CLK ENB O6 O6_INV DFF
Xdff8 I7 CLK ENB O7 O7_INV DFF
Xdff9 I8 CLK ENB O8 O8_INV DFF
Xdff10 I9 CLK ENB O9 O9_INV DFF
.ends