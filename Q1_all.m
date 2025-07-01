clc;clear;
pressure_ratio = 1.7;
k = 1.4;
C_v = 0.718; %(kJ/kg.k)
C_p = 1.005; %(kJ/kg.k)
CR = 14;
cutoff_ratio = 1 + 0.05*(CR-1);
P1 = 100; %(kPa)
T1 = 300; %(K)
v1 = 0.287*T1/P1;
v2 = v1/CR;
%% Dual Cycle
v3_dual = v2;
v4_dual = cutoff_ratio*v3_dual;
v5_dual = v1;
P2_dual = P1 * ((CR)^(k));
T2_dual = T1 * ((CR)^(k-1));
P3_dual = P2_dual * pressure_ratio;
T3_dual = T2_dual * (pressure_ratio);
P4_dual = P3_dual;
T4_dual = T3_dual * (cutoff_ratio);
P5_dual = P4_dual * (cutoff_ratio/CR)^(k);
T5_dual = T4_dual * (cutoff_ratio/CR)^(k-1);
n = 100;
v12_dual = linspace(v1,v2,n);
P12_dual = P1*((v1./v12_dual).^k);
v23_dual = linspace(v2,v3_dual,n);
P23_dual = linspace(P2_dual,P3_dual,n);
v34_dual = linspace(v3_dual,v4_dual,n);
P34_dual = P3_dual*ones(1,n);
v45_dual = linspace(v4_dual,v5_dual,n);
P45_dual = P4_dual*((v4_dual./v45_dual).^k);
v51_dual = linspace(v5_dual,v1,2);
P51_dual = linspace(P5_dual,P1,2);

plot(v12_dual,P12_dual,'b')
hold on, grid minor
plot(v23_dual,P23_dual,'b')
plot(v34_dual,P34_dual,'b')
plot(v45_dual,P45_dual,'b')
plot(v51_dual,P51_dual,'b')

%% Disel Cycle
P2_disel = P1 * ((CR)^(k));
T2_disel = T1 * ((CR)^(k-1));
P3_disel = P2_disel;
T3_disel = 2245.93;
v3_disel = 0.287*T3_disel/P3_disel;
P4_disel = 381.37;
T4_disel = 1145.63;
v4_disel = v1;

n = 100;
v12_disel = linspace(v1,v2,n);
P12_disel = P1*((v1./v12_disel).^k);
v23_disel = linspace(v2,v3_disel,n);
P23_disel = P2_disel*ones(1,n);
v34_disel = linspace(v3_disel,v4_disel,n);
P34_disel = P3_disel*((v3_disel./v34_disel).^k);
v41_disel = linspace(v4_disel,v1,2);
P41_disel = linspace(P4_disel,P1,2);

plot(v12_disel,P12_disel,'r')
plot(v23_disel,P23_disel,'r')
plot(v34_disel,P34_disel,'r')
plot(v41_disel,P41_disel,'r')

%% OttO Cycle
v3_otto = v2;
v4_otto = v1;
P2_otto = P1 * ((CR)^(k));
T2_otto = T1 * ((CR)^(k-1));
P3_otto = 13062.32;
T3_otto = 2799.07;
P4_otto = 324.67;
T4_otto = 974.01;

v12_otto = linspace(v1,v2,n);
P12_otto = P1*((v1./v12_otto).^k);
v23_otto = linspace(v2,v3_otto,n);
P23_otto = linspace(P2_otto,P3_otto,n);
v34_otto = linspace(v3_otto,v4_otto,n);
P34_otto = P3_otto*((v3_otto./v34_otto).^k);
v41_otto = linspace(v4_otto,v1,2);
P41_otto = linspace(P4_otto,P1,2);

plot(v12_otto,P12_otto,'g')
plot(v23_otto,P23_otto,'g')
plot(v34_otto,P34_otto,'g')
plot(v41_otto,P41_otto,'g')

xlabel('specific volume (m3/kg)')
ylabel('pressure (kPa)')