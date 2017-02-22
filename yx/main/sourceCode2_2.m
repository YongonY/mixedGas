
%createDate��2017/2/19
%NO2����ݷ����㷨

%%
%��������������
%**************ϵ���볣��**************************************************
%wave:NO2ʵ�鲨��350~400nm
%back_NO2:NO2�ı�������
%L:��̣���λcm

%NO2_48ppm:Ũ��Ϊ48ppm��NO2�����չ���
%NO2_93ppm:Ũ��Ϊ93ppm��NO2�����չ���
%NO2_296ppm:Ũ��Ϊ296ppm��NO2�����չ���
%NO2_495ppm:Ũ��Ϊ495ppm��NO2�����չ���

%C_NO2_48:48ppm��Ӧ��molecule/cm3Ũ��
%C_NO2_93:93ppm��Ӧ��molecule/cm3Ũ��
%C_NO2_296:296ppm��Ӧ��molecule/cm3Ũ��
%C_NO2_495:495ppm��Ӧ��molecule/cm3Ũ��


%diffNO2_48:NO2_48ppm�Ĳ�ֻ�
%diffNO2_93:NO2_93ppm�Ĳ�ֻ�
%diffNO2_296:NO2_296ppm�Ĳ�ֻ�
%diffNO2_495:NO2_495ppm�Ĳ�ֻ�

%diffarea_48:NO2_48ppm������õĲ�����ս���
%diffarea_93:NO2_99ppm������õĲ�����ս���
%diffarea_296:NO2_296ppm������õĲ�����ս���
%diffarea_495:NO2_495ppm������õĲ�����ս���
%diffArea:�Ż�������õĲ�����ս���
clear all;
clc;
load NO2_nanjing;

Na = 6.022*10^23; %����٤���޳���
ppm2mg = 2.05;%ppm��mg/m3��ת��ϵ��
L = 100;

C_NO2_48 = ppm2mg*48*Na/(46*10^9);
C_NO2_93 = ppm2mg*99*Na/(46*10^9);
C_NO2_296 = ppm2mg*296*Na/(46*10^9);
C_NO2_495 = ppm2mg*495*Na/(46*10^9);

wave_num = length(wave);    %wave_x����ĳ���

%***************��ֻ�����***************************************************

[ diffNO2_48 ] = Differ( NO2_48ppm,back_NO2,wave_num);
[ diffNO2_93 ] = Differ( NO2_93ppm,back_NO2,wave_num);
[ diffNO2_296 ] = Differ( NO2_296ppm,back_NO2,wave_num);
[ diffNO2_495 ] = Differ( NO2_495ppm,back_NO2,wave_num);

diffarea_48 = diffNO2_48/(C_NO2_48*L);
diffarea_93 = diffNO2_93/(C_NO2_93*L);
diffarea_296 = diffNO2_296/(C_NO2_296*L);
diffarea_495 = diffNO2_495/(C_NO2_495*L);




plot(wave,diffarea_296,'r',wave,diffarea_495,'b');
