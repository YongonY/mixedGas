function flag=test(lenchrom,bound,code)
% ��������: ����Ⱦɫ��ı��밡�ϲ��Ϻ�Ҫ��
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% code       input: Ⱦɫ��ı���ֵ
% flag       output: 1��ʾ��������Ҫ��0��ʾ������
x=code; %�Ƚ���
flag=1;
for i = 1:sum(lenchrom)
    if (x(i)<bound(i,1))||(x(i)>bound(i,2))
        flag=0;
        break;
    end
end
     