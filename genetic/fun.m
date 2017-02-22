function ret=fun(chrom,fun_C,fun_diff)
%函数功能计算染色体对应的适应度值，主程序中默认适应度（返回值）越小越好
L = 100;
ret = 0;
for i = 1:length(fun_C)
    ret = ret + abs(fun_C(i) - (chrom'*fun_diff(:,i))/(chrom'*chrom*L))/fun_C(i);
end
end