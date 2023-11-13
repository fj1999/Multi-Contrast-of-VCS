function []=lie_k_n_level_mul_obj(k,n,f1)
%
% k=3;
% n=6;
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



ss="( "+num2str(k)+" , "+num2str(n)+" )";
fprintf(f1,"\n\n\n%s\n",ss);

for j=k:n
    p0=value(sum(x(1,:).*h(2^j,:)));
    p1=value(sum(x(2,:).*h(2^j,:)));
    ddd=(p1-p0);
    ss=num2str(j)+"张对比度：";
    fprintf(f1,"%s  %.4f\n",ss,ddd);
end

% ss="p0的解: ";
% fprintf(f1,"%s\n",ss);
% for j=1:2^n
%     if value(x(1,j))>0.0001
%         ss=num2str(j-1)+":";
%         fprintf(f1,"  %s %.4f   ",ss,value(x(1,j)));
%     end
% end

ss="p0的解: ";
fprintf(f1,"%s\n",ss);
p=zeros(6,1);
countaa=1;

aaa=zeros(2^n,1);
for i=1:2^n
    aaa(i)=round(value(x(1,i)),4);
end

for i=1:2^n
    if aaa(i)>0.001
        flag=0;
        for kkk=1:countaa
            if p(kkk,1)==aaa(i)
                flag=1;
                break;
            end
        end
        if flag==0
            p(countaa,1)=aaa(i);
            countaa=countaa+1;
        end
    end
end

for i=1:countaa-1
    for j=1:2^n
        if round(value(x(1,j)),4)==round(p(i,1),4)
            ss=num2str(j-1)+":";
            fprintf(f1,"  %s %.4f   ",ss,value(x(1,j)));
        end
    end
    fprintf(f1,"\n ");
end




ss="p1的解: ";
fprintf(f1,"%s\n",ss);
p=zeros(6,1);
countaa=1;
aaa=zeros(2^n,1);
for i=1:2^n
    aaa(i)=round(value(x(2,i)),4);
end

for i=1:2^n
    if aaa(i)>0.001
        flag=0;
        for kkk=1:countaa
            if p(kkk,1)==aaa(i)
                flag=1;
                break;
            end
        end
        if flag==0
            p(countaa,1)=aaa(i);
            countaa=countaa+1;
        end
    end
end

for i=1:countaa-1
    for j=1:2^n
        if round(value(x(2,j)),4)==p(i,1)
            ss=num2str(j-1)+":";
            fprintf(f1,"%s %.4f   ",ss,value(x(2,j)));
        end
    end
    fprintf(f1,"\n ");
end

% ss="p1的解: ";
% fprintf(f1,"\n%s\n",ss);
% 
% for j=1:2^n
%     if value(x(2,j))>0.0001
%         ss=num2str(j-1)+":";
%         fprintf(f1,"  %s %.4f   ",ss,value(x(2,j)));
%     end
% end

% end
% show_or_pro_test_2_3(solution,n);