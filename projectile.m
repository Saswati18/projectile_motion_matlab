%% Projectile Motion
clc
clear
% close all

%% Input Parameters
R = 4.3;                  % Tower Distance in meters
h = 1.5;                  % Height of  destination Tower in meters
y0 = .9;                  % Height of starting point in meters
k=14.8;                   % Angle of launching in degrees
cd=0.08-2.72*(k-4)^2,     %drag coefficient
cl=0.1-1.4*k;             %lift coefficient
a=pi*0.125^2;
m=0.078;                  %mass of disc
rho=1.23                  %air density(ideal value)
%% Calculate Velocity and Angle
g = 9.81;                               % Acceleration due to gravity
x0 = 0;                                   % Initial x- axis position
v=sqrt((R^2*g)/2*cosd(k)^2*y0+R*tand(k));
T=2*v*sind(k)/g;
vx=v*cosd(k);
vy=v*sind(k);
vt1=sqrt(vx^2+vy^2);
vt2=vt1-v*exp(g*T*cd*rho*a/2*m*sind(k));            %effect of drag and gravity
vtf=vt2+v*exp(cl*T*rho*a/2*m);
vtx=vtf*cosd(k);
vty=vtf*sind(k);
clc
fprintf('>>Velocity and Range are %2.2f m/s, %2.2f  respectively! \n',v,R)

%% Solve differential eqn for x-axis and y-axis 
dT = 1e-03;
Tstart = 0;
Tstop = T;
tspan = [Tstart Tstop];
% Initial Conditions and Inputs
xh0 = [x0; vtx];         % Initial position and velocity in x-axis direction
xv0 = [y0; vty];         % Initial position and velocity in y-axis direction
uh = 0;                     % Acceleration in x-axis direction
uv = -g;                    % Acceleration in y-axis direction
[th, xh] = ode45(@(t, xh) quadDiff(t, xh, uh),tspan,xh0);
[tv, xv] = ode45(@(t, xv) quadDiff(t, xv, uv),tspan,xv0);

%% Plotting
t = Tstart: dT: Tstop;
x = interp1(th, xh(:, 1), t);
y = interp1(tv, xv(:, 1), t);
fig = figure(1);
set(fig, 'Position', [500 300 800 700])

plot(x, y, '-.', 'LineWidth',1.5) ;hold on; 
stem(x(end),h, 'LineWidth', 2.2);
stem(x0,y0, 'LineWidth', 1.6,'color','k')
str = ['h = ',num2str(h),'m'];
text(1.01*x(end), h/2, str)
text(0.2, y0/2, 'start_point')
xlabel('x [m]')
ylabel('y [m]')
title('Projectile Motion')
% xlim([-1 1.2*x(end)])
axis([-1 10 0 10])
grid minor
%xdot = quadDiff(t, x, v);