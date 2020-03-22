function [px,py]= sidm(kdata)
kdata = abs(kdata);
sz = size(kdata);
[px,py] = find(kdata == max(kdata(:)));
return