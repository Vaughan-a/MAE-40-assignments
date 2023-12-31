clear all; clc; close all;
disp('HW 3, Midterm 2023, Vaughan Altmann')
% Question 1
omega = 10; Q=5; Q2 = 10; %Q2 represents the Q value from 1h when c1 = 1
F_LPF2_undamped=RR_tf([omega/Q 0],[1 omega/Q omega^2]);
figure(1), RR_bode(F_LPF2_undamped)
hold on
F_LPF3_undamped=RR_tf([omega/Q2 0],[1 omega/Q2 omega^2]);
g.linestyle="r-."; RR_bode(F_LPF3_undamped,g)
syms R C L c1 Vi s
% x=[IL IR Id Vm Vo]
A = [-1 1 1 0 0;      % 0 = IR + Id - IL
    0 R 0 0 -1;       % 0 = R*IR - Vo
    0 0 R/c1 0 -1;    % 0 = (R/c1)*Id - Vo
    L*s 0 0 1 0;      % Vi = L*s*IL + Vm
    -1 0 0 C*s -C*s]; % 0 = C*s*Vm - C*s*Vo - IL
b = [0;0;0;Vi;0];
x = A\b;
Vo = simplify(x(5,:))
tf = simplify(x(5,:)/Vi) % gives Vo/Vi (Vo in 5th index of matrix x)

%checking work for 1g through 1j
R = 1000;
C = (1/(Q*R*omega));
L = (1/(C*omega^2));
c1 = 1;
Q3 = (c1+1)/(R*C*omega);

%Question 2
R = 5;
figure(2)
x2 = linspace(0, 2*pi, 1000);
y2 = abs(10*sin(x2));
z2 = zeros(1,1000);
for n = 1:1000
    y2(n) = abs(10*sin(x2(n)));
    if y2(n)< 2
        z2(n) = 0; 
    elseif y2(n)>=2
        z2(n) = abs(10*sin(x2(n)))-2;
    end 
end 
plot(x2,z2)

figure(3)
x2 = linspace(0, 2*pi, 1000);
y3 = abs((10*sin(x2))/R);
z3 = zeros(1,1000);
for n = 1:1000
    y3(n) = abs(10*sin(x2(n))/R);
    if y3(n)< 2/R
        z3(n) = 0; 
    elseif y3(n)>=2/R
        z3(n) = (abs(8*sin(x2(n)))-2)/R;
    end 
end 
plot(x2,z3)

figure(4)
x2 = linspace(0, 2*pi, 1000);
y4 = (((10*sin(x2)).^2)/R);
z4 = zeros(1,1000);
for n = 1:1000
    y4(n) = abs(((10*sin(x2(n)))^2)/R);
    if y4(n)< 4/R
        z4(n) = 0; 
    elseif y4(n)>=4/R
        z4(n) = (abs(10*sin(x2(n))-2)^2)/R;
    end 
end
plot(x2,z4)

figure(5)
x2 = linspace(0, 2*pi, 1000);
y5 = ((10*abs(sin(x2)).^2)/R);
z5 = zeros(1,1000);
for n = 1:1000
    y5(n) = ((10*abs(sin(x2(n)))^2)/R);
    if y4(n)< 4/R
        z5(n) = 0; 
    elseif y4(n)>=4/R
        z5(n) = 2*(8*abs(sin(x2(n)))/R);
    end 
end
plot(x2,z5)

figure(6)
x2 = linspace(0, 2*pi, 1000);
y6 = 1./(1+abs(4*sin(x2)));
z6 = zeros(1,1000);
z7 = zeros(1,1000); %z7 represents the efficiency when sin(t)=1, 
% lowest efficiency while current is running through the circuit
for n = 1:1000
    y6(n) = 1/(1+abs(4*sin(x2(n))));
    if y4(n)< 4/R
        z6(n) = 0; 
        z7(n) = 1/5;
    elseif y4(n)>=4/R
        z6(n) = 1/(1+abs(4*sin(x2(n))));
        z7(n) = 1/5;
    end 
end
plot(x2,z6,x2,z7,'g--')







