% Measurement Model
%Pm = [0.6, 0.4, 0.2, 0.8];
P_so_o = 0.6; %p(Zt = sense_open|Xt = is_open)
P_sc_o = 0.4; %p(Zt = sense_closed|Xt = is_open)
P_so_c = 0.2; %p(Zt = sense_open|Xt = is_closed)
P_sc_c = 0.8; %p(Zt = sense_closed|Xt = is_closed)

%Action Model 1
%Pa1 = [1, 0, 0.8, 0.2];

Popo = 1; %p(Xt = is_open|Ut = push, Xt-1 = is_open)
Pcpo = 0; %p(Xt = is_closed|Ut = push, Xt-1 = is_open)
Popc = 0.8; %p(Xt = is_open|Ut = push, Xt-1 = is_closed)
Pcpc = 0.2; %p(Xt = is_closed|Ut = push, Xt-1 = is_closed)

%Action Model 2
%Pa2 = [1, 0, 0, 1];
Pono = 1; %p(Xt = is_open|Ut = do_nothing, Xt-1 = is_open)
Pcno = 0; %p(Xt = is_closed|Ut = do_nothing, Xt-1 = is_open)
Ponc = 0; %p(Xt = is_open|Ut = do_nothing, Xt-1 = is_closed)
Pcnc = 1; %p(Xt = is_closed|Ut = do_nothing, Xt-1 = is_closed)

bo = 0.5; %belief it is open (here at initial state)
bc = 0.5; %belief it is closed (here at initial state)
bb1 = 0; %belief it is open
bb2 = 0; %belief it is closed
n = 0; %normalizer
Action = [1,0]; %[Open, Do_nothing]
Measurement = [1,0]; %[Open, Closed]
I = [0 0; 1 0; 0 0; 1 1; 0 1]; %Iterations
S = size(I);

for i = 1:S(1)
    if I(i,1) == 1
     bb1 = (Popo * bo) + (Popc * bc);
     bb2 = (Pcpo * bo) + (Pcpc * bc);
    else
     bb1 = (Pono * bo) + (Ponc * bc);
     bb2 = (Pcno * bo) + (Pcnc * bc);
    end
    if I(i,2) == 1
     n = (1 / ((P_so_o * bb1) + (P_so_c * bb2)));
     bo = (n * P_so_o) * bb1;
     bc = (n * P_so_c) * bb2;
    else
     n = (1 / ((P_sc_o * bb1) + (P_sc_c * bb2)));
     bo = (n * P_sc_o) * bb1;
     bc = (n * P_sc_c) * bb2;
    end
     b = [bo bc]; %belief
     disp(b);
end
