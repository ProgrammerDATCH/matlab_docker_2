
function [Sol]=solution(c1,c2,c3,c4,c5,c6)
global SolTest
%y0=[500;35;600;100;50;10];
y0=[c1;c2;c3;c4;c5;c6];
Tspan=[0:10:400];
[T Y]=ode45('second',Tspan,y0);
Sol=Y;
SolTest=Sol;
%figure(1)

%plot(T,Y(:,1),'b',T,Y(:,2),'r')
%grid on
%figure(2)

%plot(T,Y(:,3),'b',T,Y(:,4),'r')
%grid on
%figure(3)

%plot(T,Y(:,5),'b',T,Y(:,6),'r')
%grid on