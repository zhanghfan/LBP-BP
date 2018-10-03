function [ Hist ] = BasicLBP( X,Row,Col )

% BASICLBP 用基本的3x3邻域LBP算子提取纹理特征

% Inputs: X --- 人脸图像矩阵（imgRow * imgCol 矩阵）

%         R --- 分块的行数

%         C --- 分块的列数

% Output: histLBP --- X对应的LBP特征：直方图（行向量）

 

%------------------------------读取图片尺寸：-----------------------------

 

[ m,n ] = size(X);                      

 

%----------------------------计算分块的大小：-----------------------------

 

mWindowSize = floor(m/Row);

nWindowSize = floor(n/Col);

 

%------------------------准备好参与运算的各个矩阵：------------------------

 

extend = zeros(m+2,n+2);                 %扩展一圈的全零矩阵

extend(2:m+1,2:n+1) = X;                 %把X放到extend中间

 

extend(1,2:n+1) = X(1,1:n);              %向上扩展

extend(m+2,2:n+1) = X(m,1:n);            %向下扩展

extend(2:m+1,1) = X(1:m,1);              %向左扩展

extend(2:m+1,n+2) = X(1:m,n);            %向右扩展

 

B2D = [1 2 4;128 0 8;64 32 16];          %二进制→十进制转换模板

 

%------------得到imgRow*imgCol(即112*92）的LBP纹理图像MatLBP：------------

 

MatLBP = zeros(m,n);

for i = 1:m

    for j = 1:n

       temp =  X(i,j);                  %取某点的像素值，即中心阈值a

       A = ones(3)*temp;                %3*3矩阵，元素全为a

       B = extend(i:(i+2),j:(j+2));     %从扩展图像中取3*3邻域矩阵

       C = B - A;                       %相减

       C(C>=0) = 1;                    %判断C中非负数，置1

       C(C<0) = 0;                     %判断C中负数，置0

       MatLBP(i,j) = sum(sum(C.*B2D));  %点乘求和，返回MatLBP

    end

end

 

%------------------------分块进行直方图统计并连接：------------------------   

 

%预先准备两个空白矩阵，用于存放直方图数据

h = zeros(1,59); H = zeros(Row*Col,59);

%预先准备一个空白矩阵，用于存放当前分块图像

Window = zeros(mWindowSize,nWindowSize);

 

for i = 1:Row

    for j = 1:Col

       

       %读取第i行第j列的分块：

       Window = MatLBP(((i-1)*mWindowSize+1):((i-1)*mWindowSize+mWindowSize),((j-1)*nWindowSize+1):((j-1)*nWindowSize+nWindowSize));

       %转换成行向量才能求直方图：

       Window = reshape(Window,1,mWindowSize*nWindowSize);   

       

       h = histLBP(Window);             %计算自定义的“直方图”，存入h（1*59行向量）

       H((i-1)*Col+j,:) = h;            %按行保存各个分块对应的直方图行向量

       

    end

end

 

%把矩阵H中的直方图数据连成一行（称为：复合直方图）

H = H'; %转置后更方便按行连接

Hist = reshape(H,1,Row*Col*59);

 

 

end