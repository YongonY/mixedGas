function ret=fun(chrom,fun_C,fun_diff)
%�������ܼ���Ⱦɫ���Ӧ����Ӧ��ֵ����������Ĭ����Ӧ�ȣ�����ֵ��ԽСԽ��
L = 100;
ret = 0;
for i = 1:length(fun_C)
    ret = ret + abs(fun_C(i) - (chrom'*fun_diff(:,i))/(chrom'*chrom*L))/fun_C(i);
end
end