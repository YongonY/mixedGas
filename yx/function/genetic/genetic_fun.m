function [ diffArea_out ] = genetic_fun( diffArea_in )
%函数功能：根据输入的差分吸收截面计算出更为准确的差分吸收截面
%diffArea_in        input                   差分吸收截面矩阵，每一行为一组差分吸收截面数据。
%diffArea_out       output                  求出最好的差分吸收截面。

%初始化参数
load data2genetic;
maxgen=80;                         %进化代数，即迭代次数
sizepop=length(diffArea_in(:,1));                        %种群规模,即差分吸收截面的组数
pcross=[0.4];                       %交叉概率选择，0和1之间
pmutation=[0.2];                    %变异概率选择，0和1之间
lenchrom= length(diffArea_in(1,:));          %每个变量的字串长度，如果是浮点变量，则长度都为1

individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness=[];                      %每一代种群的平均适应度
bestfitness=[];                     %每一代种群的最佳适应度
bestchrom=[];                       %适应度最好的染色体

%% 初始化种群计算适应度值
% 初始化种群
for i=1:sizepop
    individuals.chrom(i,:) = diffArea_in(i,:);
    x=individuals.chrom(i,:);
    x = x';
    %计算适应度
    individuals.fitness(i)=fun(x,fun_C,fun_diff);   %染色体的适应度
end
%找最好的染色体
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=[avgfitness bestfitness]; 

%% 迭代寻优
% 进化开始
for i=1:maxgen
    i
    % 选择
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],bound);
    
    % 计算适应度 
    for j=1:sizepop
        x=individuals.chrom(j,:); %解码
        x = x';
        individuals.fitness(j)=fun(x,fun_C,fun_diff);   
    end
    
  %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度
end
%进化结束
diffArea_out = bestchrom;

end

