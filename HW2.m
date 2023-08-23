disp('Vaughan Altmann')
% Question 1
RR_Ex10_02_passive_filters
syms Rd Ra Cb Cc Vo s
A1b=[-1 1 1 0 0 0 0; 0 -1 0 -1 0 0 0; 0 0 -1 1 1 0 0; 0 0 0 0 Rd 0 -1; 0 Ra 0 0 0 1 0; 0 0 1/(Cb*s) 0 0 0 1; 0 0 0 1/(Cc*s) 0 1 -1];
b1b = [0; 0; 0; 0; Vo; Vo; 0];
x1b =A1b\b1b; 
tf = simplify(x1b(6,:)/Vo); %transfer function in terms of Cb Cc Ra and Rd
omega = 10;
tf1c = ((s^2)+omega*s+(omega^2))/((s^2)+3*omega*s+(omega^2));
Vo_LPF2_undamped=simplify(x1b(7))
F_LPF2_undamped=RR_tf([1 omega omega^2],[1 3*omega omega^2]);
figure(4), RR_bode(F_LPF2_undamped)
% Question 2
syms Rb Rc Ca Cd
A2b=[-1 1 1 0 0 0 0; 0 -1 0 -1 0 0 0; 0 0 -1 1 1 0 0; 0 0 0 -1 0 0 Cd*s; 0 1/(Ca*s) 0 0 0 1 0; 0 0 Rb 0 0 0 1; 0 0 0 -Rc 0 1 -1];
b2b = [0; 0; 0; 0; Vo; Vo; 0];
x2b =A2b\b2b; 
tf2 = simplify(x2b(6,:)/Vo); %transfer function in terms of Cb Cc Ra and Rd
omega = 10;
Vo_LPF2_undamped=simplify(x2b(7))
F_LPF2_undamped=RR_tf([1 omega],[1]);
figure(5), RR_bode(F_LPF2_undamped)
