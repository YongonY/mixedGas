function [ diffArea_out ] = genetic_fun( diffArea_in )
%�������ܣ���������Ĳ�����ս���������Ϊ׼ȷ�Ĳ�����ս���
%diffArea_in        input                   ������ս������ÿһ��Ϊһ�������ս������ݡ�
%diffArea_out       output                  �����õĲ�����ս��档

%��ʼ������
load data2genetic;
maxgen=80;                         %��������������������
sizepop=length(diffArea_in(:,1));                        %��Ⱥ��ģ,��������ս��������
pcross=[0.4];                       %�������ѡ��0��1֮��
pmutation=[0.2];                    %�������ѡ��0��1֮��
lenchrom= length(diffArea_in(1,:));          %ÿ���������ִ����ȣ�����Ǹ���������򳤶ȶ�Ϊ1

individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %����Ⱥ��Ϣ����Ϊһ���ṹ��
avgfitness=[];                      %ÿһ����Ⱥ��ƽ����Ӧ��
bestfitness=[];                     %ÿһ����Ⱥ�������Ӧ��
bestchrom=[];                       %��Ӧ����õ�Ⱦɫ��

%% ��ʼ����Ⱥ������Ӧ��ֵ
% ��ʼ����Ⱥ
for i=1:sizepop
    individuals.chrom(i,:) = diffArea_in(i,:);
    x=individuals.chrom(i,:);
    x = x';
    %������Ӧ��
    individuals.fitness(i)=fun(x,fun_C,fun_diff);   %Ⱦɫ�����Ӧ��
end
%����õ�Ⱦɫ��
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��
% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
trace=[avgfitness bestfitness]; 

%% ����Ѱ��
% ������ʼ
for i=1:maxgen
    i
    % ѡ��
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % ����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i maxgen],bound);
    
    % ������Ӧ�� 
    for j=1:sizepop
        x=individuals.chrom(j,:); %����
        x = x';
        individuals.fitness(j)=fun(x,fun_C,fun_diff);   
    end
    
  %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õ�Ⱦɫ��
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
%��������
diffArea_out = bestchrom;

end

