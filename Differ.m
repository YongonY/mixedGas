function [ diffRelaInten ] = Differ( Intense,background,wave_num)
%Differ函数,用于对吸收光谱做差分化处理
N_difference = 6;                                              %多项式拟合的阶数
x_difference = 1:wave_num;
relaIntense = log(Intense./background);       %消除光源吸收光谱的影响
a2_difference = polyfit(x_difference',relaIntense,N_difference);%a为拟合出的多项式系数
fitForRelaInten = polyval(a2_difference,x_difference);       %多项式拟合出的曲线
fitForRelaInten = fitForRelaInten';
diffRelaInten = relaIntense - fitForRelaInten;         %对相对吸收光强进行差分化

end

