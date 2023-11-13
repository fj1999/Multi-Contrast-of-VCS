function [kd,kn]=lie_k_n_weight(k,n,zzzz)
q=2^n;
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

% zz=h(2^k,:);
jie=5;
count=0;
% for i=k:n
%     if i==k
%         zz=h(2^k,:)*1/(k+1);
% %         zz=h(2^k,:);
%         count=count+1/10^(k+1);
%     else
%         zz=zz+h(2^i,:)*10^(i+1);
% %         zz=zz+h(2^i,:);
%         count=count+1/10^(i+1);
%     end
% end
% zz=h(2^k,:)*(n-k+1)^4;

zz=h(2^k,:)*zzzz;
zz=zz+h(2^n,:)*1;
% count=(n-k+1)^4+1;
zz=zz/(zzzz+1);


f=sum((x(1,:)-x(2,:)).*( zz));

ops=sdpsettings('solver','gurobi','verbos',1);
result = solvesdp(Constraints, f, ops);
solution=value(x);
% y=-value(f)
for i=2:2^n
    for j=1:2
        aaa(i,j)=-value(sum((x(1,:)-x(j,:)).*h(i,:)));
    end
end
aaa;

for j=k:n
    
    p0=value(sum(x(1,:).*h(2^j,:)));
    p1=value(sum(x(2,:).*h(2^j,:)));
    ddd=(p1-p0);
    if j==k
        kd=ddd;
    elseif j==n
        kn=ddd;
    end
%     fprintf('%f   ',-value(sum((x(1,:)-x(2,:)).*h(2^j,:))));
end

% end
% show_or_pro_test_2_3(solution,n);