
%createDate：2017/2/21
%NO单组份反演算法

%%
%变量定义与引用
%**************系数与常数**************************************************
%wave:NO实验波段220~260nm
%back_NO:NO的背景光谱
%L:光程，单位cm

%NO_50ppm:浓度为50ppm的NO的吸收光谱
%NO_99ppm:浓度为99ppm的NO的吸收光谱
%NO_301ppm:浓度为301ppm的NO的吸收光谱
%NO_499ppm:浓度为499ppm的NO的吸收光谱

%C_NO_50:50ppm对应的molecule/cm3浓度
%C_NO_99:99ppm对应的molecule/cm3浓度
%C_NO_301:301ppm对应的molecule/cm3浓度
%C_NO_499:499ppm对应的molecule/cm3浓度


%diffNO_50:NO_50ppm的差分化
%diffNO_99:NO_99ppm的差分化
%diffNO_301:NO_301ppm的差分化
%diffNO_499:NO_499ppm的差分化

%diffarea_50:NO_50ppm计算而得的差分吸收截面
%diffarea_99:NO_99ppm计算而得的差分吸收截面
%diffarea_301:NO_301ppm计算而得的差分吸收截面
%diffarea_499:NO_499ppm计算而得的差分吸收截面
%diffArea:优化计算而得的差分吸收截面
clear all;
clc;
load NO_nanjing;

Na = 6.022*10^23; %阿伏伽德罗常数
ppm2mg = 1.34;%ppm与mg/m3的转换系数
L = 100;

C_NO_50 = ppm2mg*50*Na/(30*10^9);
C_NO_99 = ppm2mg*99*Na/(30*10^9);
C_NO_301 = ppm2mg*301*Na/(30*10^9);
C_NO_499 = ppm2mg*499*Na/(30*10^9);

wave_num = length(wave);    %wave_x数组的长度

%***************差分化处理***************************************************

[ diffNO_50 ] = Differ( NO_50ppm,back_NO,wave_num);
[ diffNO_99 ] = Differ( NO_99ppm,back_NO,wave_num);
[ diffNO_301 ] = Differ( NO_301ppm,back_NO,wave_num);
[ diffNO_499 ] = Differ( NO_499ppm,back_NO,wave_num);

diffarea_50 = diffNO_50/(C_NO_50*L);
diffarea_99 = diffNO_99/(C_NO_99*L);
diffarea_301 = diffNO_301/(C_NO_301*L);
diffarea_499 = diffNO_499/(C_NO_499*L);



a1 = diffarea_301./diffarea_499;
a2 = diffarea_99./diffarea_301;
a3 = diffarea_50./diffarea_99;

plot(wave,a1,'r',wave,a2,'b');
