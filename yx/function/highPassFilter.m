function ret = highPassFilter(func, threshold )
%函数功能：高通滤波器
%func         input           带滤波的信号
%threshold    input           高通截止频点（推荐取值SO2：52）
%ret          output          滤完波后的信号

spectrum = fft(func);
long = length(spectrum);
filter = ones(length(spectrum),1);
filter(threshold:long-threshold) = 0;
ret = ifft(spectrum.*filter);

end

