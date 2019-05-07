function C_SAD_cos=CosineSadMatrix(im1,im2,DisparityVector,blockSize)
%Calculate the cosine-tuned Sum of Absolute Difference Map 
%By Elena Mancinelli, Johns Hopkins University, 2018
I1=rgb2gray(im1);
I2=rgb2gray(im2);

[I1_cont,I2_cont]=ContrastEvaluation(im1,im2,10,0.01);
[~,c_cont]=size(I1_cont);

I1_cont_temp=I1_cont(:,(abs(min(DisparityVector))+1):c_cont-abs(max(DisparityVector)));
I2_cont_temp=I2_cont(:,(abs(min(DisparityVector))+1):c_cont-abs(max(DisparityVector)));
half_blockSize=(blockSize-1)/2;
[rows,columns]=size(I1_cont); % dimension after of cropped Image from contrast evaluation

I1_pad=zeros(rows+(half_blockSize*2),columns+(2*half_blockSize));
I2_pad=zeros(rows+(2*half_blockSize),columns+(2*half_blockSize));

I1_pad(half_blockSize+1:end-(half_blockSize),half_blockSize+1:end-(half_blockSize))= I1(1:rows,1:columns);
I2_pad(half_blockSize+1:end-(half_blockSize),half_blockSize+1:end-(half_blockSize))= I2(1:rows,1:columns);

[~,columns_pad]=size(I1_pad);

%working with Images dimensions after contrast evaluation
for m=DisparityVector  %m=mindisparity:step_disparity:maxdisparity
    index=find(DisparityVector==m);
    for i=1+half_blockSize:half_blockSize+rows
        for j=1+half_blockSize + abs(min(DisparityVector)):columns_pad-(half_blockSize + abs(max(DisparityVector)))
            if I1_cont(i-half_blockSize,j-half_blockSize)==-1  && I2_cont(i-half_blockSize,j-half_blockSize)==-1
                C_SAD{1,index}(i-half_blockSize,j-half_blockSize-abs(min(DisparityVector)))=0;
            else
                C_sad=(I1_pad(i-half_blockSize:i+half_blockSize,j-half_blockSize:j+half_blockSize)-...
                    I2_pad(i-half_blockSize:i+half_blockSize,(j+m)-half_blockSize:(j+m)+half_blockSize));
                C_sad=sum(sum(abs(C_sad)));
                C_SAD{1,index}(i-half_blockSize,j-half_blockSize-abs(min(DisparityVector)))=C_sad;
            end
        end
    end
    
end

for i=1:length(DisparityVector)
    C_SAD_norm{1,i}=rescale(C_SAD{1,i},0,1);
end          

for i=1:length(DisparityVector)
    C_SAD_med{1,i}=medfilt2(C_SAD_norm{1,i}, [7 7]);
end

% set to -1 low contrast points SAD value
for  disp=1:length(DisparityVector)
    for i=1:size( C_SAD_norm{1,1},1)
        for j=1:size( C_SAD_norm{1,1},2)
            if I1_cont_temp(i,j)== -1 && I2_cont_temp(i,j)== -1
                C_SAD_norm{1,disp}(i,j)=-1;
            end
        end
    end
end
for disp=1:length(DisparityVector)
    C_SAD_norm_med{1,disp}=medfilt2(C_SAD_norm{1,disp}, [7 7]);
end
for  disp=1:length(DisparityVector)
    C_SAD_cos{1,disp}=cos((pi/2)* C_SAD_norm_med{1,disp});
end
end