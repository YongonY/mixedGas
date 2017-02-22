
%createDate��2017/2/21
%NO����ݷ����㷨

%%
%��������������
%**************ϵ���볣��**************************************************
%wave:NOʵ�鲨��220~260nm
%back_NO:NO�ı�������
%L:��̣���λcm

%NO_50ppm:Ũ��Ϊ50ppm��NO�����չ���
%NO_99ppm:Ũ��Ϊ99ppm��NO�����չ���
%NO_301ppm:Ũ��Ϊ301ppm��NO�����չ���
%NO_499ppm:Ũ��Ϊ499ppm��NO�����չ���

%C_NO_50:50ppm��Ӧ��molecule/cm3Ũ��
%C_NO_99:99ppm��Ӧ��molecule/cm3Ũ��
%C_NO_301:301ppm��Ӧ��molecule/cm3Ũ��
%C_NO_499:499ppm��Ӧ��molecule/cm3Ũ��


%diffNO_50:NO_50ppm�Ĳ�ֻ�
%diffNO_99:NO_99ppm�Ĳ�ֻ�
%diffNO_301:NO_301ppm�Ĳ�ֻ�
%diffNO_499:NO_499ppm�Ĳ�ֻ�

%diffarea_50:NO_50ppm������õĲ�����ս���
%diffarea_99:NO_99ppm������õĲ�����ս���
%diffarea_301:NO_301ppm������õĲ�����ս���
%diffarea_499:NO_499ppm������õĲ�����ս���
%diffArea:�Ż�������õĲ�����ս���
clear all;
clc;
load NO_nanjing;

Na = 6.022*10^23; %����٤���޳���
ppm2mg = 1.34;%ppm��mg/m3��ת��ϵ��
L = 100;

C_NO_50 = ppm2mg*50*Na/(30*10^9);
C_NO_99 = ppm2mg*99*Na/(30*10^9);
C_NO_301 = ppm2mg*301*Na/(30*10^9);
C_NO_499 = ppm2mg*499*Na/(30*10^9);

wave_num = length(wave);    %wave_x����ĳ���

%***************��ֻ�����***************************************************

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
