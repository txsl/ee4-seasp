
addpath('../')
common.init

SEASP_Part_4_1_c

ORDER = 1;
MU = 0.01;

%% CLMS for the balanced signal

[ h_est_bal , ~, error ] = clms(v_bal, v_bal, ORDER, MU);

fo_bal = (fs/(2*pi))*atan(imag(h_est_bal)./real(h_est_bal));

figure
plot(fo_bal)

%% ACLMS for the Unbalanced signal

[ h_est_unbal, g_est_unbal, ~, ~ ] = aclms(v_unbal, v_unbal, ORDER, MU);

fo_unbal = (fs/(2*pi))*atan( sqrt( (imag(h_est_unbal).^2) - (abs(g_est_unbal).^2)) ./ ...
                real(h_est_unbal));
            
figure
plot(fo_unbal)