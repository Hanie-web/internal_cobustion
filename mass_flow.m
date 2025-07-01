clc;clear;
gamma = 1.4;
R = 287;
T_t = 300;
C_d = 0.8;
d = 0.0345;               % [m]
A = pi * (d/2)^2;         % [m^2]
Pt = 105000;              % [Pa]
Pu = linspace(0, 400000, 800);   % [Pa]
critical_factor = ((gamma + 1)/2)^(gamma / (gamma - 1));
Pu_critical = Pt * critical_factor;

mass_flow = zeros(size(Pu));
rho = Pu ./ (R * T_t);
velocity = zeros(size(Pu));

for i = 1:length(Pu)
    if Pu(i) < 1
        mass_flow(i) = 0;
        velocity(i) = 0;
        continue;
    end
    
    if Pu(i) >= Pu_critical
        const = sqrt(gamma / (R * T_t)) * (2 / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1)));
        mass_flow(i) = C_d * A * Pu(i) * const;
    else
        ratio = Pt / Pu(i);
        term1 = (2 * gamma) / (R * T_t * (gamma - 1));
        term2 = ratio^(2 / gamma) - ratio^((gamma + 1) / gamma);
        mass_flow(i) = C_d * A * Pu(i) * sqrt(term1 * term2);
    end
    velocity(i) = mass_flow(i) / (rho(i) * A);
end

%Plot: Mass Flow Rate vs Upstream Pressure ---
figure;
subplot(1,2,1);
plot(Pu/1000, mass_flow*1000, 'Color', [0.5 0 0.9], 'LineWidth', 2);  % Purple
hold on;
xline(Pu_critical/1000, '--', 'Color', [1 0 0], 'LineWidth', 2);     % Red dashed line
xlabel('Upstream Pressure (kPa)');
ylabel('Mass Flow Rate (g/s)');
title('Mass Flow Rate vs Upstream Pressure');
legend('Mass Flow Rate','Choked Flow Limit','Location','northwest');
grid on;

%Plot: Jet Velocity vs Upstream Pressure ---
subplot(1,2,2);
plot(Pu/1000, velocity, 'Color', [1 0.5 0], 'LineWidth', 2);     % Orange
hold on;
xline(Pu_critical/1000, '--', 'Color', [1 0 0], 'LineWidth', 2);     % Red dashed line
xlabel('Upstream Pressure (kPa)');
ylabel('Velocity (m/s)');
title('Velocity vs Upstream Pressure');
legend('Velocity','Choked Flow Limit','Location','northwest');
grid on;
sgtitle('Toyota 2ZZ-GE - Intake Flow Regimes');