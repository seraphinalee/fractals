function [ s ] = twin( r )
%Takes in r, returns s such that L(s)=L(r).
%Maps rmax to rmax. s and r have equivalent renormalization constants
%
s = (5 - 22*r - 12*r^2 + sqrt((25 + 260*r + 844*r^2 + 648*r^3 + 144*r^4)))/(12*(2*r + r^2));
end

