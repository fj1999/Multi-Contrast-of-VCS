function [after]  = xor_jz( n)
if n==1
    after=[0 0;0 1];
else 
    after=[xor_jz(n-1),xor_jz(n-1);xor_jz(n-1),1-xor_jz(n-1)];
end