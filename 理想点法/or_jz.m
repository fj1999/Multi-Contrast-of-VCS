function [after]  = or_jz( n)
if n==1
    after=[0 0;0 1];
else 
    after=[or_jz(n-1),or_jz(n-1);or_jz(n-1),ones(size(or_jz(n-1)))];
end