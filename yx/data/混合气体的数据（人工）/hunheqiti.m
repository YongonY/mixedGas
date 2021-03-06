%createDate：2017/2/21
%生成混合气体
%%
clear all
clc
load('单组份数据以及背景数据.mat');
for i = 1:length(wave)
end
%去背景光谱，对数化处理

tempSO2_44 = (back_SO2./SO2_44);
tempSO2_94 = (back_SO2./SO2_94);
tempSO2_295 = (back_SO2./SO2_295);
tempSO2_496 = (back_SO2./SO2_496);

tempNO2_48 = (back_NO2./NO2_48);
tempNO2_93 = (back_NO2./NO2_93);
tempNO2_296 = (back_NO2./NO2_296);
tempNO2_495 = (back_NO2./NO2_495);

tempNO_50 = (back_NO./NO_50);
tempNO_99 = (back_NO./NO_99);
tempNO_301 = (back_NO./NO_301);
tempNO_499 = (back_NO./NO_499);

for i = 1:length(wave)
    if tempSO2_44(i)<=0
        tempSO2_44(i) = 1;
    end
     if tempSO2_94(i)<=0
        tempSO2_94(i) = 1;
     end
     if tempSO2_295(i)<=0
        tempSO2_295(i) = 1;
     end
     if tempSO2_496(i)<=0
        tempSO2_496(i) = 1;
     end
     if tempNO2_48(i)<=0
        tempNO2_48(i) = 1;
     end
     if tempNO2_93(i)<=0
        tempNO2_93(i) = 1;
     end
    if tempNO2_296(i)<=0
        tempNO2_296(i) = 1;
    end
    if tempNO2_495(i)<=0
        tempNO2_495(i) = 1;
    end
    if tempNO_50(i)<=0
        tempNO_50(i) = 1;
    end
    if tempNO_99(i)<=0
        tempNO_99(i) = 1;
    end
    if tempNO_301(i)<=0
        tempNO_301(i) = 1;
    end
    if tempNO_499(i)<=0
        tempNO_499(i) = 1;
    end
end

qdsSO2_44 = log(tempSO2_44);
qdsSO2_94 = log(tempSO2_94);
qdsSO2_295 = log(tempSO2_295);
qdsSO2_496 = log(tempSO2_496);

qdsNO2_48 = log(tempNO2_48);
qdsNO2_93 = log(tempNO2_93);
qdsNO2_296 = log(tempNO2_296);
qdsNO2_495 = log(tempNO2_495);

qdsNO_50 = log(tempNO_50);
qdsNO_99 = log(tempNO_99);
qdsNO_301 = log(tempNO_301);
qdsNO_499 = log(tempNO_499);


%合成混合气体
SO2NO_1 = back_SO2.*exp(-qdsSO2_44-qdsNO_499);
SO2NO_2 = back_SO2.*exp(-qdsSO2_496-qdsNO_50);
SO2NO_3 = back_SO2.*exp(-qdsSO2_295-qdsNO_301);
SO2NO_mix1 = struct('NO',499,'SO2',44, 'Intense',SO2NO_1);
SO2NO_mix2 = struct('NO',50,'SO2',496, 'Intense',SO2NO_2);
SO2NO_mix3 = struct('NO',301,'SO2',295, 'Intense',SO2NO_3);

SO2NO2_1 = back_SO2.*exp(-qdsSO2_44-qdsNO2_495);
SO2NO2_2 = back_SO2.*exp(-qdsSO2_496-qdsNO2_48);
SO2NO2_3 = back_SO2.*exp(-qdsSO2_295-qdsNO2_296);
SO2NO2_mix1 = struct('NO2',495,'SO2',44, 'Intense',SO2NO2_1);
SO2NO2_mix2 = struct('NO2',48,'SO2',496, 'Intense',SO2NO2_2);
SO2NO2_mix3 = struct('NO2',296,'SO2',295, 'Intense',SO2NO2_3);

NONO2_1 = back_SO2.*exp(-qdsNO_499-qdsNO2_48);
NONO2_2 = back_SO2.*exp(-qdsNO_50-qdsNO2_495);
NONO2_3 = back_SO2.*exp(-qdsNO_301-qdsNO2_296);
NONO2_mix1 = struct('NO2',48,'NO',499, 'Intense',NONO2_1);
NONO2_mix2 = struct('NO2',495,'NO',50, 'Intense',NONO2_2);
NONO2_mix3 = struct('NO2',296,'NO',301, 'Intense',NONO2_3);

triple_1 = back_SO2.*exp(-qdsNO2_495-qdsNO_301-qdsSO2_295);
triple_2 = back_SO2.*exp(-qdsNO2_296-qdsNO_499-qdsSO2_295);
triple_3 = back_SO2.*exp(-qdsNO2_296-qdsNO_301-qdsSO2_496);
triple_4 = back_SO2.*exp(-qdsNO2_296-qdsNO_301-qdsSO2_295);
tripleMix_1 = struct('NO2',495,'NO',301,'SO2',295, 'Intense',triple_1);
tripleMix_2 = struct('NO2',296,'NO',499,'SO2',295, 'Intense',triple_2);
tripleMix_3 = struct('NO2',296,'NO',301,'SO2',496, 'Intense',triple_3);
tripleMix_4 = struct('NO2',296,'NO',301,'SO2',295, 'Intense',triple_4);



