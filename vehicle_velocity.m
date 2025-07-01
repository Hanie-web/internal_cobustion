clc; clear;

GR = [3.166, 2.05, 1.481, 1.166, 0.916, 0.725, 3.25];
[GR_sorted, idx] = sort(GR);
Velocity = 123.84 ./ GR;
Velocity_sorted = Velocity(idx);

for i = 1:length(GR_sorted)
    fprintf('Gear %d \t Gear Ratio = %.3f \t Velocity = %.2f km/h\n', ...
            i, GR_sorted(i), Velocity_sorted(i));
end

plot(GR_sorted, Velocity_sorted)
xlabel('Gear Ratio')
ylabel('Vehicle Velocity (km/h)')
title('Vehicle Velocity vs Sorted Gear Ratios')
grid on
