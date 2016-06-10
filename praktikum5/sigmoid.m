function [ y ] = sigmoid( x )
%SIGMOID Summary of this function goes here
%   Detailed explanation goes here

y = 1 ./ (1 + exp(-x));

end

