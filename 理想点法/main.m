% for i=2:8
%     for j=2:i
%         i
%         j
%         touguanglv_ilp(j,i);   %透光率——基础矩阵
%     end
% end

% for i=2:8
%     for j=2:i
%         i
%         j
%         touguanglv_ilp_lie(j,i);  %透光率——列矩阵
%     end
% end 

% path=strcat('C:/Users/方佳/Desktop/1.txt');
% f1=fopen(path,'w');
% for i=2:8
%     for j=2:i
%         i
%         j
%         lie_k_n(j,i,f1);   %对比度——列矩阵
%     end
% end
% fclose(f1);

% path=strcat('C:/Users/方佳/Desktop/1.txt');
% f1=fopen(path,'w');
% for i=2:8
%     for j=2:i
%         i
%         j
%         lie_k_n_mul_obj(j,i,f1);   %对比度——列矩阵-多目标
%     end
% end
% fclose(f1);

% for i=2:8
%     for j=2:i
%         i
%         j
%         lie_k_n_mul_obj_two(j,i);   %对比度——列矩阵-理想点法（二次）
%     end
% end
% 
% path=strcat('C:/Users/方佳/Desktop/4.txt');
% f1=fopen(path,'w');
% for i=2:8
%     for j=2:i
%         i
%         j
%         lie_k_n_level_mul_obj(j,i,f1);   %对比度——列矩阵-层次分析法
%     end
% end
% fclose(f1);

% path=strcat('C:/Users/方佳/Desktop/4.txt');
% f1=fopen(path,'w');
% for i=2:8
%     for j=2:i
%         i
%         j
%         lie_k_n_level_mul_obj_pro(j,i,f1);   %对比度——列矩阵
%     end
% end
% fclose(f1);

path=strcat('C:/Users/方佳/Desktop/2.txt');
f1=fopen(path,'w');
for i=2:8
    for j=2:i
        i
        j
        lie_k_n_mul_obj_pro(j,i,f1);   %对比度——列矩阵
    end
end
fclose(f1);

