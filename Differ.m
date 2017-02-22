function [ diffRelaInten ] = Differ( Intense,background,wave_num)
%Differ����,���ڶ����չ�������ֻ�����
N_difference = 6;                                              %����ʽ��ϵĽ���
x_difference = 1:wave_num;
relaIntense = log(Intense./background);       %������Դ���չ��׵�Ӱ��
a2_difference = polyfit(x_difference',relaIntense,N_difference);%aΪ��ϳ��Ķ���ʽϵ��
fitForRelaInten = polyval(a2_difference,x_difference);       %����ʽ��ϳ�������
fitForRelaInten = fitForRelaInten';
diffRelaInten = relaIntense - fitForRelaInten;         %��������չ�ǿ���в�ֻ�

end

