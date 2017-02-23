function [ seri,num ] = screen( main,ref,threshold )
%函数功能：筛选出main序列中与ref（序列集）中所有序列相似度较高的一些点
%main             input         目标序列
%ref              input         参考序列集（目前只考虑单个序列的情况）
%threshold        input         阈值（用于定量化描述相似度）（推荐取值0.05）
%seri             output        相似点在main序列中的位置
%num              output        筛选出的点的数目

k = (main - ref)./main;%相似度

flag = 1;
i = 1;
seri = [];%记录差分吸收面积高度相似的频点的序号
while flag
    if abs(k(i))>threshold
        k(i) = 0;
    else
         seri = [seri i];
    end
    i = i+1;
    if i>length(k)
        flag = 0;
    end
end
num = length(seri);
end

