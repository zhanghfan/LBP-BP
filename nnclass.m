function [ Accuracy ] = NNClassifier( GalleryFea,ProbeFea,Rank,Type,N)

% NNCLASSIFIER ����ڷ�����

% Inputs: N --- ÿ����ȡ�˶�����ͼƬ��Ϊѵ����

%         GalleryFea --- ��ȡ��ѵ����������ɵľ���

%         ProbeFea --- ��ȡ�Ĳ��Լ�������ɵľ���

%         Rank --- ���ڷ���������

%         Type --- ��������ͣ�1-ŷ�Ͼ��� 2-��������  3-ֱ��ͼ�����  4-������Ȼ����

% Output: Accuracy --- ʶ����

 

 

%-----------------------------������ȱʡ���ã�-----------------------------

 

if nargin == 2

    Rank= 1;

    Type= 1;

    N =5;

end

 

%----------------------------���ಢ����ʶ���ʣ�----------------------------

 

correct = 0;                  %��ʼ���ж���ȷ��������

error = zeros(1,40*N);        %��ʼ����������

 

for i = 1:(40*(10-N))

   

    %-----�����Լ�����ProbeFea�ĵ�i����ѵ��������GalleryFea�ĵ�j������룺

    for j = 1:(40*N)

       switch Type

           case 1

                error(j) = norm(ProbeFea(i,:)-GalleryFea(j,:));

                %ŷ�Ͼ��룬�����������ȡ2-����

           case 2

                error(j) = sum(  ((ProbeFea(i,:)-GalleryFea(j,:)).^2)/(ProbeFea(i,:)+GalleryFea(j,:))  );

                %��������

           case 3

                error(j) = sum(  min( [ProbeFea(i,:);GalleryFea(j,:)] )  );

                %ֱ��ͼ�����( ���ʽ�����д�ʶ����Ϊ0 )

           case 4

                error(j) = (-1)*sum(  ProbeFea(i,:)*log(GalleryFea(j,:))  );

                %������Ȼ����( ���ʽ�д����б�����ʱ���о��� )

       end

       

    end

 

    %-----��error�����������г�ERROR��I������š�~����ЩԪ��ԭ����error�е���ţ�

    [~,I]= sort(error);

       

    %-----���潫���ڼ��С�����ɡ��ڼ����ˡ���

   

    true_class= ceil(i/(10-N));   %ʵ������֪����ǰ��һ�е������Ǵ���ڼ�����

    recog_classes= zeros(1,Rank); %��ʼ��

   

    for m = 1:Rank                 %�����ڷ����Ľ���Ϊ Rank, ��ȡ�������е�ǰ Rank ��Ԫ��

       recog_classes(m) = ceil(I(m)/N);   %ϵͳ��Ϊ����� Rank ��Ԫ�أ��ֱ������Щ��

    end

    recog_class= mode(recog_classes);      %ǰ Rank ������ܵ�����ǩ�У�����Ƶ����ߵ���Ϊ���

   

    if true_class == recog_class

       correct = correct+1;  %���ϵͳ�ж���ȷ����ô��һ��~

    end    

   

end

 

Accuracy = correct/(40*(10-N));    %�����ȷ��

 

 

end