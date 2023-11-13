% function []=lie_k_n_level_mul_obj(k,n,f1)
%
k=3;
n=5;
warning('off');
h=or_jz(n);
x=sdpvar(2, 2^n);
set_num=zeros(1,2^n);
for i=0:n-1
    set_num(2^i+1:2^(i+1))=set_num(1:2^i)+1;
end
Constraints=[];
for i=2:2^n
    if set_num(1,i)<k
        Constraints=[Constraints,sum((x(1,:)-x(2,:)).*h(i,:))==0];
    else
        Constraints=[Constraints,sum((x(1,:)-x(2,:)).*h(i,:))<=-0.1];
    end
end
for i=2:2^n
    for j=k:n
        if set_num(i)==j
            Constraints=[Constraints,sum( (x(1,:)-x(2,:)).*( h(2^j,:)-h(i,:)  ))==0];
        end
    end
end

Constraints=[Constraints,sum(x(1,:))==1];
Constraints=[Constraints,sum(x(2,:))==1];

for i=1:2
    for j=1:2^n
        Constraints=[Constraints,x(i,j)>=0];
        Constraints=[Constraints,x(i,j)<=1];
    end
end

zz=h(2^k,:);
f=sum((x(1,:)-x(2,:)).*( zz));

ops=sdpsettings('solver','gurobi','verbos',0);
result = solvesdp(Constraints, f, ops);
solution=value(x);
y=-value(f);
if n>k
    for i=k+1:n
        zz=h(2^(i-1),:);
        Constraints=[Constraints,sum((x(1,:)-x(2,:)).*( zz))==-y];
        f=sum((x(1,:)-x(2,:)).*(h(2^i,:)));
        ops=sdpsettings('solver','gurobi','verbos',0);
        result = solvesdp(Constraints, f, ops);
        solution=value(x);
        y=-value(f);
    end
end


for j=k:n
    p0=value(sum(x(1,:).*h(2^j,:)));
    p1=value(sum(x(2,:).*h(2^j,:)));
    ddd=(p1-p0)

end

show_or_pro_test_2_3(solution,n);