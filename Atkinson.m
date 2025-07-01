clc;clear;
%% Atkinson Cycle
k = 1.4;
C_v = 0.718; %(kJ/kg.k)
C_p = 1.005; %(kJ/kg.k)
CR = 14;
cutoff_ratio = 1 + 0.05*(CR-1);
P1 = 100; %(kPa)
T1 = 300; %(K)

v1 = 0.287*T1/P1;
v2 = 0.0615;
v3_atkinson = v2;
v4_atkinson = v3_atkinson*17;

P2_atkinson = 4023.27;
T2_atkinson = 862.13;
P3_atkinson = 5279.87;
T3_atkinson = 1131.4;
P4_atkinson = 100;
T4_atkinson = 364.27;
n = 100;
v12_atkinson = linspace(v1,v2,n);
P12_atkinson = P1*((v1./v12_atkinson).^k);
v23_atkinson = linspace(v2,v3_atkinson,n);
P23_atkinson = linspace(P2_atkinson,P3_atkinson,n);
v34_atkinson = linspace(v3_atkinson,v4_atkinson,n);
P34_atkinson = P3_atkinson*((v3_atkinson./v34_atkinson).^k);
v41_atkinson = linspace(v4_atkinson,v1,2);
P41_atkinson = linspace(P4_atkinson,P1,2);

plot(v12_atkinson,P12_atkinson,'LineWidth',1,'Color','b')
hold on
plot(v23_atkinson,P23_atkinson,'LineWidth',1,'Color','b')
plot(v34_atkinson,P34_atkinson,'LineWidth',1,'Color','b')
plot(v41_atkinson,P41_atkinson,'LineWidth',1,'Color','b')
plot([v1 v2 v3_atkinson v4_atkinson], [P1 P2_atkinson P3_atkinson P4_atkinson], 'ko', 'MarkerFaceColor','k')
text(v1, P1, ' 1', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold')
text(v2, P2_atkinson, ' 2', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold')
text(v3_atkinson, P3_atkinson, ' 3', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold')
text(v4_atkinson, P4_atkinson, ' 4', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold')

xlabel('specific volume (m3/kg)')
ylabel('pressure (kPa)')
title('Atkinson Cycle P-v Diagram')
