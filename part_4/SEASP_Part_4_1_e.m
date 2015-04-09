
addpath('../')
common.init

SEASP_Part_4_1_c

ORDER = 1;
MU = 0.01;

%% CLMS for the balanced signal

[ h_est_bal , ~, error ] = clms(v_bal(1:end-1), v_bal(2:end), ORDER, MU);

fo_bal = (fs/(2*pi))*atan(imag(h_est_bal)./real(h_est_bal));

fprintf('Last measured Balanced CLMS frequency: %f Hz\n', fo_bal(end));

%% CLMS for the unbalanced signal

[ h_est_unbal , ~, error ] = clms(v_unbal(1:end-1), v_unbal(2:end), ORDER, MU);

fo_unbal = (fs/(2*pi))*atan(imag(h_est_bal)./real(h_est_bal));

fprintf('Last measured Unbalanced CLMS frequency: %f Hz\n', fo_unbal(end));

%% ACLMS for the Unbalanced signal

[ h_est_unbal, g_est_unbal, ~, ~ ] = aclms(v_unbal(1:end-1), v_unbal(2:end), ORDER, MU);

fo_unbal = (fs/(2*pi))*atan( sqrt( (imag(h_est_unbal).^2) - (abs(g_est_unbal).^2)) ./ ...
                real(h_est_unbal));
            
fprintf('Last measured Unbalanced ACLMS frequency: %f Hz\n', fo_unbal(end));