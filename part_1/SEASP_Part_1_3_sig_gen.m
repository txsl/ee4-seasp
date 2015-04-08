function [ sig ] = SEASP_Part_1_3_sig_gen(f0, a1, a2, phi1, phi2, alpha, N, sigma_sq)

sig = a1*sin(f0*2*pi*(0:N-1) + phi1) + a2*sin((f0 + alpha/N)*2*pi*(0:N-1) + phi2) + sqrt(sigma_sq)*randn(1, N);

end

