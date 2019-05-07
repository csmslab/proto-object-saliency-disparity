function [I1_cont,I2_cont]=ContrastEvaluation(im1,im2,blockSize,threshold)
%Cut the low contrast area
%By Elena Mancinelli, Johns Hopkins University, 2018

I1=rgb2gray(im1);
I2=rgb2gray(im2);
[rows,columns]=size(I1);
r=mod(rows,blockSize);

if r ~= 0
    I1_temp=I1(1:rows-r,:);
    I2_temp=I2(1:rows-r,:);
    [rows,~]=size(I1_temp);
    I1=I1_temp;
    I2=I2_temp;
end

c=mod(columns,blockSize);
if c ~= 0
    I2_temp=I2(:,1:columns-c);
    [~,columns]=size(I1_temp);
    I1=I1_temp;
    I2=I2_temp;
end

%devo avere l'immagine tra 0 e 1
for i=1:blockSize:(rows-blockSize)
    for j=1:blockSize:(columns-blockSize)
        I1_temp= I1(i:(i+blockSize-1),j:(j+blockSize-1));
        I2_temp= I2(i:(i+blockSize-1),j:(j+blockSize-1));
        
        I1_mean=mean(I1_temp(:));
        I2_mean=mean(I2_temp(:));
        
        I1_sq= (I1_temp - I1_mean).^2;
        I2_sq= (I2_temp - I2_mean).^2;
        
        I1_sum=sum(I1_sq(:));
        I2_sum=sum(I2_sq(:));
        
        I1_div=(I1_sum)/(blockSize.^2);
        I2_div=(I2_sum)/(blockSize.^2);
        RMS_r_cont= sqrt(I1_div);
        RMS_l_cont= sqrt(I2_div);
        if  RMS_r_cont<threshold
            I1(i:(i+blockSize-1),j:(j+blockSize-1))=-1;
        end
        
        if RMS_l_cont< threshold
            I2(i:(i+blockSize-1),j:(j+blockSize-1))=-1;
        end
    end
end
I1_cont=I1;
I2_cont=I2;
end