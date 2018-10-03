function [ h ] = histLBP( I )

% HISTLBP ����LBP����ͼ���ó�ֱ��ͼ����

% Input: I --- ĳ���ֿ��LBP����ͼ���Ѿ�ת��Ϊ��������

% Output: h --- �÷ֿ��ֱ��ͼ��������8λUniformΪ����h��1*59����������

 

%---------------------------����ӳ���vecLBPMap----------------------------

 

vecLBPMap = zeros(1,256);   %��ʼ��ӳ���

nCurBin = 1;       %��ǰ�ռ���ı��

bits = zeros(1,8);  %���ݳ�ʼ��

   

for i = 0:255

   

    %-----��numת��Ϊ������bits��

    num= i; nCnt = 0;

    while (num)

       bits(8-nCnt) = mod(num,2);

       num = floor(num/2);

       nCnt = nCnt+1;

    end

   

    %-----�ж�bits�Ƿ�����Uniformģʽ��

    nJmp= 0;  %��ʼ���������λ��

       

    for j = 1:7                   %�ȿ�1~7λ������

       if bits(j) ~= bits(j+1)

          nJmp = nJmp+1;

       end

    end

       

    if bits(1) ~= bits(8)         %�ٿ���β��λ֮����������

       nJmp = nJmp+1;

    end

       

    if nJmp > 2                   %Ȼ���ж��Ƿ�����Uniformģʽ

       Uni = 0;                  %����������Σ������ڣ���Ϊ0

    else

       Uni = 1;

    end

       

    %-----�����Ƿ�ΪUniformģʽ�����䡰�ռ��䡱��Bin��

   

    if Uni == 1

       %ÿ��Uniformģʽ������һ���ռ��䣺

       vecLBPMap(i+1) = nCurBin;

       nCurBin = nCurBin+1;

    else

       %���еķ�Uniformģʽ��������59���ռ���

       vecLBPMap(i+1) = 59;

    end

   

end

   

 

%---------------------------����ֱ��ͼ��������h----------------------------

 

h = zeros(1,59);   %��ʼ��ֱ��ͼ������h

L = length(I);     %��������������ͼ������������I���ж��ٸ�Ԫ�صȴ�ͳ��

 

for ii = 1:L

    %�������I��Ԫ�أ�����ӳ���ͳ��ÿ���ռ������ж��ٸ�Ԫ��

    h(vecLBPMap(I(ii)+1))= h(vecLBPMap(I(ii)+1)) + 1;

end

 

end