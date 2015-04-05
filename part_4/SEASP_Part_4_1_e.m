
addpath('../')
common.init

SEASP_Part_4_1_c

ORDER = 1;
MU = 0.0001;

[ h_est_bal , ~, ~ ] = clms(v_bal, v_bal, ORDER, MU);

figure
plot(real(h_est_bal))
figure
plot(imag(h_est_bal))

[ h_est_unbal, g_est_unbal, ~, ~ ] = aclms(v_unbal, v_unbal, ORDER, MU);