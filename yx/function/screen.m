function [ seri,num ] = screen( main,ref,threshold )
%�������ܣ�ɸѡ��main��������ref�����м����������������ƶȽϸߵ�һЩ��
%main             input         Ŀ������
%ref              input         �ο����м���Ŀǰֻ���ǵ������е������
%threshold        input         ��ֵ�����ڶ������������ƶȣ����Ƽ�ȡֵ0.05��
%seri             output        ���Ƶ���main�����е�λ��
%num              output        ɸѡ���ĵ����Ŀ

k = (main - ref)./main;%���ƶ�

flag = 1;
i = 1;
seri = [];%��¼�����������߶����Ƶ�Ƶ������
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

