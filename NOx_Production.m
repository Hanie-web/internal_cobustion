
clc; clear;
cycles = {'Dual', 'Otto', 'Diesel', 'Atkinson'};
T_cycles = [2418.27, 2800, 2245.9, 1131.4];                  %  [K]
P_cycles = [6839.6e3, 13062e3, 4023.27e3, 5280e3];           %  [Pa]

Kp_N_cycles = [1.25e-14, 1.23e-11, 1.57e-16, 8.19e-40];      % N2 ⇌ 2N
Kp_O_cycles = [7.5e-5, 2.94e-3, 7.3e-6, 4.2e-18];            % O2 ⇌ 2O

R = 8.314;            
y_N2 = 0.79;          
y_O2 = 0.21;          
t_reaction = 1e-3;    

for i = 1:length(cycles)
    cycle = cycles{i};
    T = T_cycles(i);
    P_total = P_cycles(i);
    Kp_N = Kp_N_cycles(i);
    Kp_O = Kp_O_cycles(i);

    % Partial Pressures [Pa]
    P_N2 = y_N2 * P_total;
    P_O2 = y_O2 * P_total;
    P_N = sqrt(Kp_N * P_N2);
    P_O = sqrt(Kp_O * P_O2);

    % Concentrations [mol/m³]
    C_N2 = P_N2 / (R * T);
    C_O2 = P_O2 / (R * T);
    C_N  = P_N  / (R * T);
    C_O  = P_O  / (R * T);

    % Rate Constants (m³/mol·s)
    k1 = 1e-6 * 7.6e13 * exp(-38000 / T);      %  N2 + O → NO + N
    k2 = 1e-6 * T * 6.4e9  * exp(-3150  / T);  %  N + O2 → NO + O

    r1 = k1 * C_N2 * C_O;
    r2 = k2 * C_N  * C_O2;
    r_total = r1 + r2;

    C_NO = r_total * t_reaction;
    C_NO_ppm = C_NO * 1e6;

    fprintf("---- %s Cycle ----\n", cycle);
    fprintf("T = %.1f K | P = %.1f kPa\n", T, P_total/1e3 );
    fprintf("[N2] = %.2e mol/m³\n", C_N2);
    fprintf("[O2] = %.2e mol/m³\n", C_O2);
    fprintf("[N]  = %.2e mol/m³\n", C_N);
    fprintf("[O]  = %.2e mol/m³\n", C_O);
    fprintf("Rate (N2 + O → NO + N)  = %.2e mol/(m³·s)\n", r1);
    fprintf("Rate (N  + O2 → NO + O) = %.2e mol/(m³·s)\n", r2);
    fprintf("Total NO production rate = %.2e mol/(m³·s)\n", r_total);
    fprintf("Estimated [NO] after %.1f ms = %.2e mol/m³\n", t_reaction * 1e3, C_NO);
    fprintf("Estimated [NO] after %.1f ms = %.2e ppm\n\n", t_reaction * 1e3, C_NO_ppm);
end
