%there is something wrong with the graphing, should give a notch filter
clear all; clc; close all;
syms s
omega = 10^4;
Q =1;
c1 = 0;
tf = ((s^2)+(omega^2))/((c1+1)*(s^2)+(omega/Q)*s+(c1+1)*(omega^2))
Vo_LPF2_undamped= ((s^2+omega^2)/((c1+1)*(s^2)+(omega/Q)*s+((c1+1)*(omega^2))));
F_LPF2_undamped=RR_tf([1 0 omega^2],[c1+1 omega/Q (c1+1)*(omega^2)]);
figure(4), RR_bode(F_LPF2_undamped)
Q2 = 0.1;
tf2 = ((s^2)+(omega^2))/((c1+1)*(s^2)+(omega/Q2)*s+(c1+1)*(omega^2))
F_LPF2_undamped=RR_tf([1 0 omega^2],[c1+1 omega/Q2 (c1+1)*(omega^2)]);
figure(5), RR_bode(F_LPF2_undamped)
Q3 =10;
tf3 = ((s^2)+(omega^2))/((c1+1)*(s^2)+(omega/Q3)*s+(c1+1)*(omega^2))
F_LPF2_undamped=RR_tf([1 0 omega^2],[c1+1 omega/Q3 (c1+1)*(omega^2)]);
figure(6), RR_bode(F_LPF2_undamped)
Q4 =1;
c1 = 1;
tf4 = ((s^2)+(omega^2))/((c1+1)*(s^2)+(omega/Q4)*s+(c1+1)*(omega^2))
F_LPF2_undamped=RR_tf([1 0 omega^2],[c1+1 omega/Q4 (c1+1)*(omega^2)]);
figure(7), RR_bode(F_LPF2_undamped)
