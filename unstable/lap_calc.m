function [ ret ] = lap_calc( meas, res, i )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ret = (2/(meas(i+1)+meas(i)))*((1/res(i))+(1/res(i+1)));
disp(meas(i+1))
disp(meas(i))
disp(res(i))
disp(res(i+1))
end

