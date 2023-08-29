clear all; clc; close all;
disp('HW 3, Midterm 2023, Vaughan Altmann')
% Question 1
omega = 10; Q=5; Q2 = 20/3; 
F_LPF2_undamped=RR_tf([omega/Q 0],[1 omega/Q omega^2]);
figure(1), RR_bode(F_LPF2_undamped)
hold on
F_LPF3_undamped=RR_tf([omega/Q2 0],[1 omega/Q2 omega^2]);
RR_bode(F_LPF3_undamped)
syms R C L c1 Vi s
% x=[IL IR Id Vm Vo]
A = [-1 1 1 0 0;      % 0 = IR + Id - IL
    0 R 0 0 -1;       % 0 = R*IR - Vo
    0 0 R/c1 0 -1;    % 0 = (R/c1)*Id - Vo
    L*s 0 0 1 0;      % Vi = L*s*IL + Vm
    -1 0 0 C*s -C*s]; % 0 = C*s*Vm - C*s*Vo - IL
b = [0;0;0;Vi;0];
x = A\b;
tf = simplify(x(5,:)/Vi) % gives Vo/Vi (Vo in 5th index of matrix x)

%Question 2
R = 5;
figure(2)
x2 = linspace(0, 2*pi, 100);
y2=8*sin(x2);
plot(x2,y2);
figure(3)
x2 = linspace(0, 2*pi, 100);
y3 = ((8*sin(x2))/R);
plot(x2,y3);
figure(4)
x2 = linspace(0, 2*pi, 100);
y4 = (((8*sin(x2)).^2)/R);
plot(x2,y4);
figure(5)
x3 = linspace(0, pi, 100);
y5 = 1./(1+8*sin(x3));
plot(x3,y5);





