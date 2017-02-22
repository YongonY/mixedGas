
%createDate：2017/2/17
%SO2单组份反演算法

%%
%变量定义与引用
%**************系数与常数**************************************************
%wave_SO2:SO2实验波段270~320nm
%air: 5ppmSO2背景光谱
%back_SO2:其余浓度SO2的背景光谱
%L:光程，单位cm

%SO2_5ppm:浓度为5ppm的SO2的吸收光谱
%SO2_44ppm:浓度为44ppm的SO2的吸收光谱
%SO2_94ppm:浓度为94ppm的SO2的吸收光谱
%SO2_295ppm:浓度为295ppm的SO2的吸收光谱
%SO2_496ppm:浓度为496.3ppm的SO2的吸收光谱
%SO2_1500ppm:实际浓度应该是为800ppm左右的SO2的吸收光谱

%C_SO2_5:5ppm对应的molecule/cm3浓度
%C_SO2_44:44ppm对应的molecule/cm3浓度
%C_SO2_94：94ppm对应的molecule/cm3浓度
%C_SO2_295：295ppm对应的molecule/cm3浓度
%C_SO2_496：496ppm对应的molecule/cm3浓度
%C_SO2_1500:约800ppm对应的molecule/cm3浓度

%diffSO2_5:SO2_5ppm的差分化
%diffSO2_44:SO2_44ppm的差分化
%diffSO2_94:SO2_94ppm的差分化
%diffSO2_295:SO2_295ppm的差分化
%diffSO2_496:SO2_496ppm的差分化
%diffSO2_1500:SO2_1500ppm的差分化

%diffarea_5:SO2_5ppm计算而得的差分吸收截面
%diffarea_44:SO2_44ppm计算而得的差分吸收截面
%diffarea_94:SO2_94ppm计算而得的差分吸收截面
%diffarea_295:SO2_295ppm计算而得的差分吸收截面
%diffarea_496:SO2_496ppm计算而得的差分吸收截面
%diffarea_1500:SO2_1500ppm计算而得的差分吸收截面
%diffArea:优化计算而得的差分吸收截面
clear all;
clc;
load SO2_nanjing;
load SO2_wuhan;


Na = 6.022*10^23; %阿伏伽德罗常数
ppm2mg = 2.86;%ppm与mg/m3的转换系数
L = 100;
C_SO2_5 = ppm2mg*5*Na/(64*10^9);
C_SO2_44 = ppm2mg*44*Na/(64*10^9);
C_SO2_94 = ppm2mg*94*Na/(64*10^9);
C_SO2_295 = ppm2mg*295*Na/(64*10^9);
C_SO2_496 = ppm2mg*496.3*Na/(64*10^9);
C_SO2_1500 = ppm2mg*789*Na/(64*10^9);%这个ppm浓度究竟为多少？？？

wave = wave_SO2;    %试验中采用的波段,单位:nm
wave_num = length(wave);    %wave_x数组的长度

%***************差分化处理***************************************************
[ diffSO2_5 ] = Differ( SO2_5ppm,air,wave_num);
[ diffSO2_44 ] = Differ( SO2_44ppm,back_SO2,wave_num);
[ diffSO2_94 ] = Differ( SO2_94ppm,back_SO2,wave_num);
[ diffSO2_295 ] = Differ( SO2_295ppm,back_SO2,wave_num);
[ diffSO2_496 ] = Differ( SO2_496ppm,back_SO2,wave_num);
[ diffSO2_1500 ] = Differ( SO2_1500ppm,back_SO2,wave_num);

diffarea_5 = diffSO2_5/(C_SO2_5*L*4.2);
diffarea_44 = diffSO2_44/(C_SO2_44*L);
diffarea_94 = diffSO2_94/(C_SO2_94*L);
diffarea_295 = diffSO2_295/(C_SO2_295*L);
diffarea_496 = diffSO2_496/(C_SO2_496*L);
diffarea_1500 = diffSO2_1500/(C_SO2_1500*L);
%***************测试频点的选择***************************************************
k = (diffarea_496 - diffarea_295)./diffarea_496;
yuzhi = 0.05;
flag = 1;
i = 1;
temp = [];%记录差分吸收面积高度相似的频点的序号
while flag
    if abs(k(i))>yuzhi
        k(i) = 0;
    else
         temp = [temp i];
    end
    i = i+1;
    if i>length(k)
        flag = 0;
    end
end
%***************遗传算法优化***************************************************
%效果很差暂时不用
%diffArea_in = [diffarea_44,diffarea_94,diffarea_295,diffarea_496];
%diffArea_in = diffArea_in';
%[ diffArea_out ] = genetic_fun( diffArea_in );




%%
diffSO2_test = diffSO2_496(temp);
diffArea = diffarea_496(temp);
%基于最小二乘法的浓度反演算法

C_LSM = (diffArea'*diffSO2_test)/(diffArea'*diffArea*L);
C_LSM = (C_LSM*64*10^9)/(ppm2mg*Na);

%基于绝对值积分光谱法
delt = sum(abs(diffArea));
C_Integrat = sum(abs(diffSO2_test))/(delt*L);
C_Integrat = (C_Integrat*64*10^9)/(ppm2mg*Na);
%基于积分光谱法
seri_pos = [];
seri_neg = [];
for i = 1:length(diffArea)
    if diffArea(i)>0
        seri_pos = [seri_pos i];
    else
        seri_neg = [seri_neg i];
    end
end
delt1 = sum(diffArea(seri_pos)) - sum(diffArea(seri_neg));
C_Integrat1 = (sum(diffSO2_test(seri_pos)) - sum(diffSO2_test(seri_neg)))/(delt1*L);
C_Integrat1 = (C_Integrat1*64*10^9)/(ppm2mg*Na);







