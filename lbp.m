function [ Hist ] = BasicLBP( X,Row,Col )

% BASICLBP �û�����3x3����LBP������ȡ��������

% Inputs: X --- ����ͼ�����imgRow * imgCol ����

%         R --- �ֿ������

%         C --- �ֿ������

% Output: histLBP --- X��Ӧ��LBP������ֱ��ͼ����������

 

%------------------------------��ȡͼƬ�ߴ磺-----------------------------

 

[ m,n ] = size(X);                      

 

%----------------------------����ֿ�Ĵ�С��-----------------------------

 

mWindowSize = floor(m/Row);

nWindowSize = floor(n/Col);

 

%------------------------׼���ò�������ĸ�������------------------------

 

extend = zeros(m+2,n+2);                 %��չһȦ��ȫ�����

extend(2:m+1,2:n+1) = X;                 %��X�ŵ�extend�м�

 

extend(1,2:n+1) = X(1,1:n);              %������չ

extend(m+2,2:n+1) = X(m,1:n);            %������չ

extend(2:m+1,1) = X(1:m,1);              %������չ

extend(2:m+1,n+2) = X(1:m,n);            %������չ

 

B2D = [1 2 4;128 0 8;64 32 16];          %�����ơ�ʮ����ת��ģ��

 

%------------�õ�imgRow*imgCol(��112*92����LBP����ͼ��MatLBP��------------

 

MatLBP = zeros(m,n);

for i = 1:m

    for j = 1:n

       temp =  X(i,j);                  %ȡĳ�������ֵ����������ֵa

       A = ones(3)*temp;                %3*3����Ԫ��ȫΪa

       B = extend(i:(i+2),j:(j+2));     %����չͼ����ȡ3*3�������

       C = B - A;                       %���

       C(C>=0) = 1;                    %�ж�C�зǸ�������1

       C(C<0) = 0;                     %�ж�C�и�������0

       MatLBP(i,j) = sum(sum(C.*B2D));  %�����ͣ�����MatLBP

    end

end

 

%------------------------�ֿ����ֱ��ͼͳ�Ʋ����ӣ�------------------------   

 

%Ԥ��׼�������հ׾������ڴ��ֱ��ͼ����

h = zeros(1,59); H = zeros(Row*Col,59);

%Ԥ��׼��һ���հ׾������ڴ�ŵ�ǰ�ֿ�ͼ��

Window = zeros(mWindowSize,nWindowSize);

 

for i = 1:Row

    for j = 1:Col

       

       %��ȡ��i�е�j�еķֿ飺

       Window = MatLBP(((i-1)*mWindowSize+1):((i-1)*mWindowSize+mWindowSize),((j-1)*nWindowSize+1):((j-1)*nWindowSize+nWindowSize));

       %ת����������������ֱ��ͼ��

       Window = reshape(Window,1,mWindowSize*nWindowSize);   

       

       h = histLBP(Window);             %�����Զ���ġ�ֱ��ͼ��������h��1*59��������

       H((i-1)*Col+j,:) = h;            %���б�������ֿ��Ӧ��ֱ��ͼ������

       

    end

end

 

%�Ѿ���H�е�ֱ��ͼ��������һ�У���Ϊ������ֱ��ͼ��

H = H'; %ת�ú�����㰴������

Hist = reshape(H,1,Row*Col*59);

 

 

end