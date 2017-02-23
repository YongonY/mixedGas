
%createDate��2017/2/17
%SO2����ݷ����㷨

%%
%��������������
%**************ϵ���볣��**************************************************
%wave_SO2:SO2ʵ�鲨��270~320nm
%air: 5ppmSO2��������
%back_SO2:����Ũ��SO2�ı�������
%L:��̣���λcm

%SO2_5ppm:Ũ��Ϊ5ppm��SO2�����չ���
%SO2_44ppm:Ũ��Ϊ44ppm��SO2�����չ���
%SO2_94ppm:Ũ��Ϊ94ppm��SO2�����չ���
%SO2_295ppm:Ũ��Ϊ295ppm��SO2�����չ���
%SO2_496ppm:Ũ��Ϊ496.3ppm��SO2�����չ���
%SO2_1500ppm:ʵ��Ũ��Ӧ����Ϊ800ppm���ҵ�SO2�����չ���

%C_SO2_5:5ppm��Ӧ��molecule/cm3Ũ��
%C_SO2_44:44ppm��Ӧ��molecule/cm3Ũ��
%C_SO2_94��94ppm��Ӧ��molecule/cm3Ũ��
%C_SO2_295��295ppm��Ӧ��molecule/cm3Ũ��
%C_SO2_496��496ppm��Ӧ��molecule/cm3Ũ��
%C_SO2_1500:Լ800ppm��Ӧ��molecule/cm3Ũ��

%diffSO2_5:SO2_5ppm�Ĳ�ֻ�
%diffSO2_44:SO2_44ppm�Ĳ�ֻ�
%diffSO2_94:SO2_94ppm�Ĳ�ֻ�
%diffSO2_295:SO2_295ppm�Ĳ�ֻ�
%diffSO2_496:SO2_496ppm�Ĳ�ֻ�
%diffSO2_1500:SO2_1500ppm�Ĳ�ֻ�

%diffarea_5:SO2_5ppm������õĲ�����ս���
%diffarea_44:SO2_44ppm������õĲ�����ս���
%diffarea_94:SO2_94ppm������õĲ�����ս���
%diffarea_295:SO2_295ppm������õĲ�����ս���
%diffarea_496:SO2_496ppm������õĲ�����ս���
%diffarea_1500:SO2_1500ppm������õĲ�����ս���
%diffArea:�Ż�������õĲ�����ս���
clear all;
clc;
load SO2_nanjing;
load SO2_wuhan;


Na = 6.022*10^23; %����٤���޳���
ppm2mg = 2.86;%ppm��mg/m3��ת��ϵ��
L = 100;
C_SO2_5 = ppm2mg*5*Na/(64*10^9);
C_SO2_44 = ppm2mg*44*Na/(64*10^9);
C_SO2_94 = ppm2mg*94*Na/(64*10^9);
C_SO2_295 = ppm2mg*295*Na/(64*10^9);
C_SO2_496 = ppm2mg*496.3*Na/(64*10^9);
C_SO2_1500 = ppm2mg*789*Na/(64*10^9);%���ppmŨ�Ⱦ���Ϊ���٣�����

wave = wave_SO2;    %�����в��õĲ���,��λ:nm
wave_num = length(wave);    %wave_x����ĳ���

%***************��ֻ�����***************************************************
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

%%
%�������ս�����Ż�����
%***************����Ƶ���ѡ��***************************************************

[ temp1,num1 ] = screen( diffarea_496,diffarea_295,0.05 );

%***************�Ŵ��㷨�Ż�***************************************************
%Ч���ܲ���ʱ����
%diffArea_in = [diffarea_44,diffarea_94,diffarea_295,diffarea_496];
%diffArea_in = diffArea_in';
%[ diffArea_out ] = genetic_fun( diffArea_in );

%************��ͨ�˲���********************************************************
%������ս�����˲�����
yuzhi = 52;

ttteeesssttt1 = highPassFilter(diffarea_496, yuzhi );
ttteeesssttt2 = highPassFilter(diffarea_295, yuzhi );
ttteeesssttt3 = highPassFilter(diffarea_1500, yuzhi );


%������չ��׵��˲�����

twt_44 = highPassFilter(diffSO2_44, yuzhi );
twt_94 = highPassFilter(diffSO2_94, yuzhi );
twt_295 = highPassFilter(diffSO2_295, yuzhi );
twt_496 = highPassFilter(diffSO2_496, yuzhi );
twt_1500 = highPassFilter(diffSO2_1500, yuzhi );


%***************����һ�㷨�����˲���ɸ��***************************************************
[ temp2,num2 ] = screen( ttteeesssttt1,ttteeesssttt2,0.05 );

%***************����һ�㷨����ɸ����˲�***************************************************
screenSpectrum_496 = fft(diffarea_496(temp1));
screenSpectrum_94 = fft(diffarea_94(temp1));

screenSpectrum_496_2 = fft(screenSpectrum_496);
screenSpectrum_94_2 = fft(screenSpectrum_94);
seri = 1:length(screenSpectrum_496_2);
plot(seri,screenSpectrum_496_2,'r',seri,screenSpectrum_94_2,'b');
%***************��Ƶ��ɸ��***************************************************
[retArea_496,num3] = screenFilter( diffarea_496,diffarea_496,diffarea_295,0.05 );
[retSO2_44,num3] = screenFilter( diffSO2_44,diffarea_496,diffarea_295,0.05 );
%%
%��ͨ�˲�
%diffSO2_test = twt_44;
%diffArea = ttteeesssttt1;

%ɸ��
%diffSO2_test = diffSO2_44(temp1);
%diffArea = diffarea_496(temp1);

%���˲���ɸ��
diffSO2_test = twt_44(temp2);
diffArea = ttteeesssttt1(temp2);

%��Ƶ��ɸ��
diffSO2_test = retSO2_44;
diffArea = retArea_496;

%����
%diffSO2_test = diffSO2_94;
%diffArea = diffarea_496;

%������С���˷���Ũ�ȷ����㷨

C_LSM = (diffArea'*diffSO2_test)/(diffArea'*diffArea*L);
C_LSM = (C_LSM*64*10^9)/(ppm2mg*Na);

%���ھ���ֵ���ֹ��׷�
delt = sum(abs(diffArea));
C_Integrat = sum(abs(diffSO2_test))/(delt*L);
C_Integrat = (C_Integrat*64*10^9)/(ppm2mg*Na);
%���ڻ��ֹ��׷�
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

%%

%plot(seri,spectrum_496,'r',seri,spectrum_1500,'g',seri,spectrum_295,'b');legend('496ppm','1500ppm','295ppm');






%plot(20:120,error);
%plot(wave,diffarea_496,'b',wave,ttteeesssttt1,'g');

%plot(seri,spectrum_496.*lvboqi,'b',seri,spectrum_295.*lvboqi,'g');legend('496ppm','295ppm')
%plot(abs(spectrum_94));

%plot(wave,ttteeesssttt,'b');
%��ͨ�˲���




