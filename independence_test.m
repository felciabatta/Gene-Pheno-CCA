function [outputArg1,outputArg2] = independence_test(SNPloc,MVpvals,Plim)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

randlogpvals = @(n) -log10(rand(n,1)*Plim);
n = length(SNPloc);
randlogpairs = nchoosek(randlogpvals(n));
randlogsum = sum(randlogpairs,2)

end

