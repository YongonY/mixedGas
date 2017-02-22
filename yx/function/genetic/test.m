function flag=test(lenchrom,bound,code)
% 函数功能: 测试染色体的编码啊合不合乎要求
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% code       input: 染色体的编码值
% flag       output: 1表示编码满足要求，0表示不满足
x=code; %先解码
flag=1;
for i = 1:sum(lenchrom)
    if (x(i)<bound(i,1))||(x(i)>bound(i,2))
        flag=0;
        break;
    end
end
     