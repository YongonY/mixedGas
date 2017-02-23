function ret = highPassFilter(func, threshold )
%�������ܣ���ͨ�˲���
%func         input           ���˲����ź�
%threshold    input           ��ͨ��ֹƵ�㣨�Ƽ�ȡֵSO2��52��
%ret          output          ���겨����ź�

spectrum = fft(func);
long = length(spectrum);
filter = ones(length(spectrum),1);
filter(threshold:long-threshold) = 0;
ret = ifft(spectrum.*filter);

end

