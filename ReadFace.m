function [ imgRow,imgCol,FaceContainer ] = ReadFaces(nFacesPerPerson,nPerson,bTest )

% READFACES ��ȡ����������

% Inputs: nFacesPerPerson --- ÿ������Ҫ�������������Ĭ��Ϊ5

%         nPerson --- ��Ҫ�����������Ĭ��Ϊȫ��40����

%         bTest --- Ĭ��Ϊ0����ʾ����ѵ��������ÿ���˵�ǰ5�ţ������Ϊ1�����ʾ�������������ÿ���˵ĺ�5�ţ�

% Outputs: FaceContainer --- ��������������������M��N����ÿһ�д���һ��ͼƬ��

%                            M =nPerson��nFacesPerPerson, N = imgRow * imgCol

%         imgRow,imgCol --- ÿ��ͼ��ĳߴ�

 

 

%-----------------------------������ȱʡ���ã�-----------------------------

 

if nargin ==0

    nFacesPerPerson= 5; %Ĭ��ѡȡǰ5������ѵ��

    nPerson= 40;        %�����������

    bTest= 0;           %Ĭ��Ϊ��ȡѵ������

elseif nargin < 3

    bTest= 0;           %����bTestȱʡֵΪ0

end

 

%-----------------------Ϊ�˼���ߴ磬�ȶ�ȡһ��ͼƬ-----------------------

 

img = imread('s1\1.bmp');

[ imgRow,imgCol ] = size(img);

 

%-----------------------------��������������------------------------------

 

FaceContainer = zeros(nFacesPerPerson*nPerson,imgRow*imgCol);

 

if bTest == 0

   

    %����ѵ������

    for i = 1:nPerson

       for j = 1:nFacesPerPerson         %ֻ��ȡÿ���˵�ǰnFacesPerPerson��ͼƬ��Ϊѵ��/����ͼ��

           img = imread(strcat('s',num2str(i),'\',num2str(j),'.bmp'));

      

           %����������ת��Ϊ1��N������������FaceContainer��ÿһ�У���ȡ˳���Ǵ��ϵ��£�������

           %���� N=imgRow*imgCol=112��92=10304

           FaceContainer((i-1)*nFacesPerPerson+j,:) = img(1:imgRow*imgCol);

       

           %ǿ����������ת�������ں�������������

           FaceContainer = double(FaceContainer);

       end

    end

   

elseif bTest == 1

   

    %�����������

    for i = 1:nPerson

       for j = nFacesPerPerson+1:10         %ֻ��ȡÿ���˵ĺ�(10-nFacesPerPerson)��ͼƬ��Ϊѵ��/����ͼ��

           img = imread(strcat('s',num2str(i),'\',num2str(j),'.bmp'));

      

           %����������ת��Ϊ1��N������������FaceContainer��ÿһ�У���ȡ˳���Ǵ��ϵ��£�������

           %���� N=imgRow*imgCol=112��92=10304

           FaceContainer((i-1)*nFacesPerPerson+(j-nFacesPerPerson),:) = img(1:imgRow*imgCol);

       

           %ǿ����������ת�������ں�������������

           FaceContainer = double(FaceContainer);

       end

    end

 

end

 

 

end