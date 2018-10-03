function [ imgRow,imgCol,FaceContainer ] = ReadFaces(nFacesPerPerson,nPerson,bTest )

% READFACES 读取人脸库数据

% Inputs: nFacesPerPerson --- 每个人需要读入的样本数，默认为5

%         nPerson --- 需要读入的人数，默认为全部40个人

%         bTest --- 默认为0，表示读入训练样本（每个人的前5张）；如果为1，则表示读入测试样本（每个人的后5张）

% Outputs: FaceContainer --- 向量化人脸数据容器，M×N矩阵，每一行代表一张图片。

%                            M =nPerson×nFacesPerPerson, N = imgRow * imgCol

%         imgRow,imgCol --- 每幅图像的尺寸

 

 

%-----------------------------参数的缺省设置：-----------------------------

 

if nargin ==0

    nFacesPerPerson= 5; %默认选取前5张用于训练

    nPerson= 40;        %人脸库的人数

    bTest= 0;           %默认为读取训练样本

elseif nargin < 3

    bTest= 0;           %参数bTest缺省值为0

end

 

%-----------------------为了计算尺寸，先读取一张图片-----------------------

 

img = imread('s1\1.bmp');

[ imgRow,imgCol ] = size(img);

 

%-----------------------------读入人脸库数据------------------------------

 

FaceContainer = zeros(nFacesPerPerson*nPerson,imgRow*imgCol);

 

if bTest == 0

   

    %读入训练数据

    for i = 1:nPerson

       for j = 1:nFacesPerPerson         %只读取每个人的前nFacesPerPerson张图片作为训练/测试图像

           img = imread(strcat('s',num2str(i),'\',num2str(j),'.bmp'));

      

           %将以上数据转换为1×N的行向量存入FaceContainer的每一行，提取顺序是从上到下，从左到右

           %例如 N=imgRow*imgCol=112×92=10304

           FaceContainer((i-1)*nFacesPerPerson+j,:) = img(1:imgRow*imgCol);

       

           %强制数据类型转换，便于后面的运算操作：

           FaceContainer = double(FaceContainer);

       end

    end

   

elseif bTest == 1

   

    %读入测试数据

    for i = 1:nPerson

       for j = nFacesPerPerson+1:10         %只读取每个人的后(10-nFacesPerPerson)张图片作为训练/测试图像

           img = imread(strcat('s',num2str(i),'\',num2str(j),'.bmp'));

      

           %将以上数据转换为1×N的行向量存入FaceContainer的每一行，提取顺序是从上到下，从左到右

           %例如 N=imgRow*imgCol=112×92=10304

           FaceContainer((i-1)*nFacesPerPerson+(j-nFacesPerPerson),:) = img(1:imgRow*imgCol);

       

           %强制数据类型转换，便于后面的运算操作：

           FaceContainer = double(FaceContainer);

       end

    end

 

end

 

 

end