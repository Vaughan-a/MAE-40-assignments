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
% giving values for graphing 
Vin = 5;
C = 10^(-6);
R = 10;
L = 1;
t = linspace(0,1,1000000);
Vout = zeros(1,1);
IL = zeros(1,1);
Vout2 = zeros(1,249999);
IL2 = zeros(1,249999);
Vout3 = zeros(1,250000);
IL3 = zeros(1,250000);
Vout4 = zeros(1,250000);
IL4 = zeros(1,250000);
Vout5 = zeros(1,250000);
IL5 = zeros(1,250000);
VoutA=11.5;
VoutB=11.5;
ILA=0;
ILB=0;
figure(1)
for n = 1:1000000
    if t(n)==0
        Vout(n) = VoutA*exp(-t(n)/(C*R)); 
        IL(n)= ILA + (Vin*t(n))/L;
        VoutA=Vout(n);
        VoutB=Vout(n);
        ILA=IL(n);
        ILB=IL(n);
    elseif (0<t(n))&&(t(n)<=(2.5^(-7)))
        Vout2(n) = VoutA*exp(-t(n)/(C*R)); 
        IL2(n)= ILA + (Vin*t(n))/L;
        VoutA=Vout2(n-1);
        VoutB=Vout2(n-1);
        ILA=IL2(n-1);
        ILB=IL2(n-1);
    elseif (2.5^(-7)<t(n))&&(t(n)<= 5^(-7))
       Vout3(n) = Vd - (exp(-t(n)/(2*C*R))*(C*L*R*Vd - C*L*R*VoutB)*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) - (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*(1/(2*C*R) - (L*Vd + ILB*L*R)/(C*L*R*Vd - C*L*R*VoutB)))/(- C*R^2 + L/4)^(1/2)))/(C*L*R);
       IL3(n)=(exp(-t(n)/(2*C*R))*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) + (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*((L*Vd + ILB*L*R - C*R^2*Vd + C*R^2*VoutB)/(C*ILB*L*R^2 + C*L*Vd*R) - 1/(2*C*R)))/(- C*R^2 + L/4)^(1/2))*(C*ILB*L*R^2 + C*L*Vd*R))/(C*L*R^2) - Vd/R;
       VoutA=Vout3(n-1);
       VoutB=Vout3(n-1);
        ILA=IL3(n-1);
        ILB=IL3(n-1);
       elseif (5^(-7)<t(n))&&(t(n)<= 7.5^(-7))
       Vout4(n) = Vd - (exp(t(n)/(2*C*R))*(C*L*R*Vd + C*L*R*VoutA)*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) + (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*(1/(2*C*R) - (L*Vd - ILA*L*R)/(C*L*R*Vd + C*L*R*VoutA)))/(- C*R^2 + L/4)^(1/2)))/(C*L*R);
       IL4(n)=Vd/R - (exp(t(n)/(2*C*R))*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) + (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*((ILA*L*R - L*Vd + C*R^2*Vd + C*R^2*VoutA)/(- C*ILA*L*R^2 + C*L*Vd*R) + 1/(2*C*R)))/(- C*R^2 + L/4)^(1/2))*(- C*ILA*L*R^2 + C*L*Vd*R))/(C*L*R^2);
       VoutA=Vout4(n-1);
       VoutB=Vout4(n-1);
       ILA=IL4(n-1);
       ILB=IL4(n-1);
       elseif (7.5^(-7)<t(n))&&(t(n)<= 10^(-6))
       Vout5(n) = Vd - (exp(-t(n)/(2*C*R))*(C*L*R*Vd - C*L*R*VoutB)*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) - (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*(1/(2*C*R) - (L*Vd + ILB*L*R)/(C*L*R*Vd - C*L*R*VoutB)))/(- C*R^2 + L/4)^(1/2)))/(C*L*R);
       IL5(n)=(exp(-t(n)/(2*C*R))*(cosh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R)) + (C*L^(1/2)*R*sinh((t(n)*(- C*R^2 + L/4)^(1/2))/(C*L^(1/2)*R))*((L*Vd + ILB*L*R - C*R^2*Vd + C*R^2*VoutB)/(C*ILB*L*R^2 + C*L*Vd*R) - 1/(2*C*R)))/(- C*R^2 + L/4)^(1/2))*(C*ILB*L*R^2 + C*L*Vd*R))/(C*L*R^2) - Vd/R;
       VoutA=Vout5(n-1);
       VoutB=Vout5(n-1);
        ILA=IL5(n-1);
        ILB=IL5(n-1);
    end 
end

plot(t,Vout)
plot(t,IL)
plot(t,Vout2)
plot(t,IL2)
plot(t,Vout3)
plot(t,IL3)
plot(t,Vout4)
plot(t,IL4)
plot(t,Vout5)
plot(t,IL5)