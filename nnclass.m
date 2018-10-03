function [ Accuracy ] = NNClassifier( GalleryFea,ProbeFea,Rank,Type,N)

% NNCLASSIFIER 最近邻分类器

% Inputs: N --- 每个人取了多少张图片作为训练集

%         GalleryFea --- 提取的训练集特征组成的矩阵

%         ProbeFea --- 提取的测试集特征组成的矩阵

%         Rank --- 近邻分类器阶数

%         Type --- 距离的类型：1-欧氏距离 2-卡方距离  3-直方图交叉核  4-对数似然距离

% Output: Accuracy --- 识别率

 

 

%-----------------------------参数的缺省设置：-----------------------------

 

if nargin == 2

    Rank= 1;

    Type= 1;

    N =5;

end

 

%----------------------------分类并计算识别率：----------------------------

 

correct = 0;                  %初始化判断正确的人脸数

error = zeros(1,40*N);        %初始化距离向量

 

for i = 1:(40*(10-N))

   

    %-----将测试集数据ProbeFea的第i行与训练集数据GalleryFea的第j行求距离：

    for j = 1:(40*N)

       switch Type

           case 1

                error(j) = norm(ProbeFea(i,:)-GalleryFea(j,:));

                %欧氏距离，即：相减，再取2-范数

           case 2

                error(j) = sum(  ((ProbeFea(i,:)-GalleryFea(j,:)).^2)/(ProbeFea(i,:)+GalleryFea(j,:))  );

                %卡方距离

           case 3

                error(j) = sum(  min( [ProbeFea(i,:);GalleryFea(j,:)] )  );

                %直方图交叉核( 表达式可能有错，识别率为0 )

           case 4

                error(j) = (-1)*sum(  ProbeFea(i,:)*log(GalleryFea(j,:))  );

                %对数似然距离( 表达式有错，运行报错，暂时不研究了 )

       end

       

    end

 

    %-----将error按照升序排列成ERROR，I用来存放“~”这些元素原来在error中的序号：

    [~,I]= sort(error);

       

    %-----下面将“第几行”换算成“第几个人”：

   

    true_class= ceil(i/(10-N));   %实际上我知道当前这一行的数据是代表第几个人

    recog_classes= zeros(1,Rank); %初始化

   

    for m = 1:Rank                 %“近邻法”的阶数为 Rank, 即取升序排列的前 Rank 个元素

       recog_classes(m) = ceil(I(m)/N);   %系统认为最近的 Rank 个元素，分别代表哪些人

    end

    recog_class= mode(recog_classes);      %前 Rank 个最可能的类别标签中，出现频率最高的作为结果

   

    if true_class == recog_class

       correct = correct+1;  %如果系统判断正确，那么得一分~

    end    

   

end

 

Accuracy = correct/(40*(10-N));    %输出正确率

 

 

end