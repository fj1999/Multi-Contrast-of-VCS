%理想点法求解多目标问题
% function []=lie_k_n_mul_obj(k,n,f1)
k=3;
n=5;
dian=zeros(n,1);
%先求所有目标的最大值
for kkk=k:n
    warning('off');
    h=xor_jz(n);
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
            Constraints=[Constraints,sum((x(1,:)-x(2,:)).*h(i,:))<=-0];
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
    zz=h(2^kkk,:);
    f= sum((x(1,:)-x(2,:)).*zz) ;
    ops=sdpsettings('solver','gurobi','verbos',0);
    result = solvesdp(Constraints, f, ops);
    solution=value(x);
    y=-value(f);
    dian(kkk)=y;
end


x=sdpvar(2, 2^n);
Constraints=[];
for i=2:2^n
    if set_num(1,i)<k
        Constraints=[Constraints,sum((x(1,:)-x(2,:)).*h(i,:))==0];
    else
        Constraints=[Constraints,sum((x(1,:)-x(2,:)).*h(i,:))<=-0];
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

%最终目标为每个目标最优解和实际解之差的平方和
for i=k:n
    if i==k
        f=(sum((-x(1,:)+x(2,:)).*h(2^k,:))-dian(k))^2;
    else
        f=f+(sum((-x(1,:)+x(2,:)).*h(2^i,:))-dian(i))^2;
    end
end

ops=sdpsettings('solver','gurobi','verbos',0);
result = solvesdp(Constraints, f, ops);
solution=value(x);
y=value(f);

for j=k:n
    p0=value(sum(x(1,:).*h(2^j,:)));
    p1=value(sum(x(2,:).*h(2^j,:)));
    ddd=(p1-p0)
end



% end
show_xor_pro_test_3_5(solution,n);