function [ h ] = histLBP( I )

% HISTLBP 根据LBP纹理图，得出直方图向量

% Input: I --- 某个分块的LBP纹理图（已经转换为行向量）

% Output: h --- 该分块的直方图特征（以8位Uniform为例，h是1*59的行向量）

 

%---------------------------计算映射表vecLBPMap----------------------------

 

vecLBPMap = zeros(1,256);   %初始化映射表

nCurBin = 1;       %当前收集箱的编号

bits = zeros(1,8);  %数据初始化

   

for i = 0:255

   

    %-----将num转化为二进制bits：

    num= i; nCnt = 0;

    while (num)

       bits(8-nCnt) = mod(num,2);

       num = floor(num/2);

       nCnt = nCnt+1;

    end

   

    %-----判断bits是否属于Uniform模式：

    nJmp= 0;  %初始化：跳变的位数

       

    for j = 1:7                   %先看1~7位的跳变

       if bits(j) ~= bits(j+1)

          nJmp = nJmp+1;

       end

    end

       

    if bits(1) ~= bits(8)         %再看首尾两位之间有无跳变

       nJmp = nJmp+1;

    end

       

    if nJmp > 2                   %然后判断是否属于Uniform模式

       Uni = 0;                  %跳变多于两次，则不属于，记为0

    else

       Uni = 1;

    end

       

    %-----根据是否为Uniform模式，分配“收集箱”（Bin）

   

    if Uni == 1

       %每个Uniform模式，分配一个收集箱：

       vecLBPMap(i+1) = nCurBin;

       nCurBin = nCurBin+1;

    else

       %所有的非Uniform模式，都放入59号收集箱

       vecLBPMap(i+1) = 59;

    end

   

end

   

 

%---------------------------计算直方图：行向量h----------------------------

 

h = zeros(1,59);   %初始化直方图行向量h

L = length(I);     %整个函数的输入图像拉成行向量I后，有多少个元素等待统计

 

for ii = 1:L

    %逐个检索I的元素，根据映射表统计每个收集箱中有多少个元素

    h(vecLBPMap(I(ii)+1))= h(vecLBPMap(I(ii)+1)) + 1;

end

 

end