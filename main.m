function main()

% MAIN ����ʵ�����ݣ�����LBP����ϵͳ��������

clear all; clc;

addpath(genpath('C:\Users\lenovo\Desktop\Recent Projects\05- Graduation Project\07 - LBP System'));

global imgRow; global imgCol; global N;

 

tic;

%-----��ȡѵ����

display('����ѵ��������');

N = 5;

[ imgRow,imgCol,Gallery_Set ] = ReadFaces( N,40,0);

display('.........................')

 

%-----��ȡ���Լ�

display('������Լ�����');

[ ~,~,Probe_Set ] = ReadFaces( N,40,1 );

display('.........................')

 

%-----��ȡLBP����

display('��ȡLBP����');

 

%�ֿ鷽ʽ7x7��

Row = 7;

Col = 7;

 

GalleryFea = zeros(40*N,Row*Col*59);

for i = 1:(40*N)

    X =reshape(Gallery_Set(i,:),imgRow,imgCol);  %��ѵ����ÿһ�������Ȼָ��ɾ�����ʽ

    GalleryFea(i,:)= BasicLBP( X,Row,Col );       %��ȡÿ��ѵ����ͼƬ��LBP����

end

 

ProbeFea = zeros(40*(10-N),Row*Col*59);

for i = 1:(40*(10-N))

    X =reshape(Probe_Set(i,:),imgRow,imgCol);   %�����Լ�ÿһ�������Ȼָ��ɾ�����ʽ

    ProbeFea(i,:)= BasicLBP( X,Row,Col );       %��ȡÿ�Ų��Լ�ͼƬ��LBP����

end

 

display('.........................')

 

%-----������

display('��ʼ����');

Rank = 1; Type = 1;

Accuracy = NNClassifier( GalleryFea,ProbeFea,Rank,Type,N);

display('.........................')

 

%-----��ʾ���

display(strcat('Accuracy = ',num2str(Accuracy)));

toc;

 

end