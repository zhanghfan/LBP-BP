function main()

% MAIN 本次实验内容：基本LBP独立系统的主函数

clear all; clc;

addpath(genpath('C:\Users\lenovo\Desktop\Recent Projects\05- Graduation Project\07 - LBP System'));

global imgRow; global imgCol; global N;

 

tic;

%-----读取训练集

display('读入训练集数据');

N = 5;

[ imgRow,imgCol,Gallery_Set ] = ReadFaces( N,40,0);

display('.........................')

 

%-----读取测试集

display('读入测试集数据');

[ ~,~,Probe_Set ] = ReadFaces( N,40,1 );

display('.........................')

 

%-----提取LBP特征

display('提取LBP特征');

 

%分块方式7x7：

Row = 7;

Col = 7;

 

GalleryFea = zeros(40*N,Row*Col*59);

for i = 1:(40*N)

    X =reshape(Gallery_Set(i,:),imgRow,imgCol);  %将训练集每一行数据先恢复成矩阵形式

    GalleryFea(i,:)= BasicLBP( X,Row,Col );       %提取每张训练集图片的LBP特征

end

 

ProbeFea = zeros(40*(10-N),Row*Col*59);

for i = 1:(40*(10-N))

    X =reshape(Probe_Set(i,:),imgRow,imgCol);   %将测试集每一行数据先恢复成矩阵形式

    ProbeFea(i,:)= BasicLBP( X,Row,Col );       %提取每张测试集图片的LBP特征

end

 

display('.........................')

 

%-----分类器

display('开始分类');

Rank = 1; Type = 1;

Accuracy = NNClassifier( GalleryFea,ProbeFea,Rank,Type,N);

display('.........................')

 

%-----显示结果

display(strcat('Accuracy = ',num2str(Accuracy)));

toc;

 

end