%% Equation of motion
function xdot = mo(t, x, u)      
% xdotdot = a
xdot = [0 1; 0 0]*x + [0 ; 1]*u ;
end