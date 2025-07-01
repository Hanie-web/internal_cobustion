% Valve timing and lift settings
% Intake Valve
maxLift_in = 11.5;               % Max lift [mm]
startAngle_in = 340;           % Opening angle [deg]
duration_in = 260;             % Open duration [deg]
% Exhaust Valve
maxLift_ex = 10;               % Max lift [mm]
startAngle_ex = 120;           % Opening angle [deg]
duration_ex = 260;             % Open duration [deg]

angle = 0:1:720;
lift_in = zeros(size(angle));
lift_ex = zeros(size(angle));
active_in = angle >= startAngle_in & angle <= (startAngle_in + duration_in);
lift_in(active_in) = maxLift_in * sin( pi * (angle(active_in) - startAngle_in) / duration_in );
active_ex = angle >= startAngle_ex & angle <= (startAngle_ex + duration_ex);
lift_ex(active_ex) = maxLift_ex * sin( pi * (angle(active_ex) - startAngle_ex) / duration_ex );

% Plot
figure('Color','w');
plot(angle, lift_in, 'Color', [0.2 0.6 1], 'LineWidth', 2); hold on;
plot(angle, lift_ex, 'Color', [1 0.4 0.4], 'LineWidth', 2);
plot([startAngle_in, startAngle_in + duration_in], [0 0], 'o', 'Color', [0 0.3 0.7], 'MarkerFaceColor', 'w', 'MarkerSize', 7);
plot([startAngle_ex, startAngle_ex + duration_ex], [0 0], 'o', 'Color', [0.8 0 0], 'MarkerFaceColor', 'w', 'MarkerSize', 7);
xlabel('Crank Angle (deg)');
ylabel('Valve Lift (mm)');
title('Toyota 2ZZ-GE Valve Lift – Sinusoidal Profile');
legend('Intake Valve','Exhaust Valve', 'Location','northoutside');
xlim([0 720]);
ylim([0 max(maxLift_in, maxLift_ex) + 2]);
grid on;

text(startAngle_in-70, 1, 'Intake Opens', 'Color','b', 'FontSize',10);
text(startAngle_in + duration_in, 1, 'Intake Closes', 'Color','b', 'FontSize',10);
text(startAngle_ex, 1, 'Exhaust Opens', 'Color','r', 'FontSize',10);
text(startAngle_ex + duration_ex, 1, 'Exhaust Closes', 'Color','r', 'FontSize',10);