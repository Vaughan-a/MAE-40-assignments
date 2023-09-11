 clear all; close all; clc;
disp('Hw 4 MAE 40, Vaughan Altmann')
syms Vin C R L s Vd ILA ILB VoutA VoutB
% Phase A of buck boost, w/o diode
%Vin/s = Vm, L(IL^A)=LsIL-Vm, 0=CsVout-IC, 0=RIR-Vo, 0=IR+IC
% IL IC IR Vm Vout
A1 = [0 0 0 1 0; L*s 0 0 -1 0; 0 -1 0 0 C*s; 0 0 R 0 -1; 0 1 1 0 0];
b1 = [Vin/s; L*(ILA); C*VoutA; 0; 0];
x1 = A1\b1;
% Phase A of buck boost, w/ diode
% 0=IC+IR-IL, Vd/s=Vout-Vm, ILA=LsIL-Vm, CVoutA=-CsVout-IC, 0=RIR-Vout
%      IL IC IR Vm Vout
A2 = [-1   1 1  0  0; 
       0   0 0 -1  1; 
       L*s 0 0 -1  0; 
       0  -1 0  0 -C*s; 
       0   0 R  0  -1];
b2 = [0; Vd/s; L*ILA; C*VoutA; 0];
x2 = A2\b2;
% Phase B of buck boost, w/o diode
% ILB=LsIL-Vm, 0=IC+IR, 0=RIR-Vout, 0=IL+IC+IR, VoutB=CsVout-IC
%      IL IC IR Vm Vout
A3 = [ L*s 0  0  -1  0; 
       0   1  1  0   0; 
       0   0  R  0  -1; 
       1   1  1  0   0; 
       0  -1  0  0   C*s];
b3 = [L*ILB; 0; 0; 0; C*VoutB];
x3 = A3\b3;
% Phase B of buck boost, w/ diode
% ILB=LsIL-Vm, Vd/s=Vout-Vm, 0=RIR-Vout, 0=IL+IC+IR, VoutB=CsVout-IC
%      IL IC IR Vm Vout
A4 = [ L*s 0  0  -1  0; 
       0   0  0  -1  1; 
       0   0  R  0  -1; 
       1   1  1  0   0; 
       0  -1  0  0   C*s];
b4 = [L*ILB; Vd/s; 0; 0; C*VoutB];
x4 = A4\b4;
% getting current and Vout values
IL1=simplify(x1(1));
IL2=simplify(x2(1));
IL3=simplify(x3(1));
IL4=simplify(x4(1));
Vout1=simplify(x1(5));
Vout2=simplify(x2(5));
Vout3=simplify(x3(5));
Vout4=simplify(x4(5));
% for inverse laplace transforms
IL1_t=ilaplace(IL1);
IL2_t=ilaplace(IL2);
IL3_t=ilaplace(IL3);
IL4_t=ilaplace(IL4);
Vout1_t=ilaplace(Vout1);
Vout2_t=ilaplace(Vout2);
Vout3_t=ilaplace(Vout3);
Vout4_t=ilaplace(Vout4);
