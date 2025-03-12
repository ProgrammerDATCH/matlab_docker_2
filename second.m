
function Z=second(t,x)

global SM Lamda1 Lamda2 muM a1 a2 muMi ST Lamda3 muT a3 muTi 
global N2 N3 Gamma1 k1 muV N1 Gamma2 k2 muB
% x(1): M(t) densities of Macrophage cell
% x(2): Mi (t) Infected Macrophage cell
% x(3): T(t) T-cell
% x(4): Ti(t) Infected T-cell
% x(5): V(t) Virus population
% x(6): B(t) Bacteria population

Z1=SM-Lamda1*x(6)*x(1)-Lamda2*x(1)*x(5)-muM*x(1);
Z2=Lamda1*x(6)*x(1)+Lamda2*x(1)*x(5)-a1*x(2)-a2*x(2)-muMi*x(2);
Z3=ST-Lamda3*x(3)*x(5)-muT*x(3);
Z4=Lamda3*x(3)*x(5)-a3*x(4)-muTi*x(4);
Z5=N3*a3*x(4)+N2*a2*x(2)+Gamma1*x(5)*x(6)-k1*x(5)*x(3)-muV*x(5);
Z6=N1*a1*x(2)+Gamma2*x(5)*x(6)-k2*x(6)*x(1)-muB*x(6);

Z=[Z1;Z2;Z3;Z4;Z5;Z6];