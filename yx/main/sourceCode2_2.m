
%createDate：2017/2/19
%NO2单组份反演算法

%%
%变量定义与引用
%**************系数与常数**************************************************
%wave:NO2实验波段350~400nm
%back_NO2:NO2的背景光谱
%L:光程，单位cm

%NO2_48ppm:浓度为48ppm的NO2的吸收光谱
%NO2_93ppm:浓度为93ppm的NO2的吸收光谱
%NO2_296ppm:浓度为296ppm的NO2的吸收光谱
%NO2_495ppm:浓度为495ppm的NO2的吸收光谱

%C_NO2_48:48ppm对应的molecule/cm3浓度
%C_NO2_93:93ppm对应的molecule/cm3浓度
%C_NO2_296:296ppm对应的molecule/cm3浓度
%C_NO2_495:495ppm对应的molecule/cm3浓度


%diffNO2_48:NO2_48ppm的差分化
%diffNO2_93:NO2_93ppm的差分化
%diffNO2_296:NO2_296ppm的差分化
%diffNO2_495:NO2_495ppm的差分化

%diffarea_48:NO2_48ppm计算而得的差分吸收截面
%diffarea_93:NO2_99ppm计算而得的差分吸收截面
%diffarea_296:NO2_296ppm计算而得的差分吸收截面
%diffarea_495:NO2_495ppm计算而得的差分吸收截面
%diffArea:优化计算而得的差分吸收截面
clear all;
clc;
load NO2_nanjing;

Na = 6.022*10^23; %阿伏伽德罗常数
ppm2mg = 2.05;%ppm与mg/m3的转换系数
L = 100;

C_NO2_48 = ppm2mg*48*Na/(46*10^9);
C_NO2_93 = ppm2mg*99*Na/(46*10^9);
C_NO2_296 = ppm2mg*296*Na/(46*10^9);
C_NO2_495 = ppm2mg*495*Na/(46*10^9);

wave_num = length(wave);    %wave_x数组的长度

%***************差分化处理***************************************************

[ diffNO2_48 ] = Differ( NO2_48ppm,back_NO2,wave_num);
[ diffNO2_93 ] = Differ( NO2_93ppm,back_NO2,wave_num);
[ diffNO2_296 ] = Differ( NO2_296ppm,back_NO2,wave_num);
[ diffNO2_495 ] = Differ( NO2_495ppm,back_NO2,wave_num);

diffarea_48 = diffNO2_48/(C_NO2_48*L);
diffarea_93 = diffNO2_93/(C_NO2_93*L);
diffarea_296 = diffNO2_296/(C_NO2_296*L);
diffarea_495 = diffNO2_495/(C_NO2_495*L);




plot(wave,diffarea_296,'r',wave,diffarea_495,'b');
