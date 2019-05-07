function disparityChannel=CreateDisparityMap(im1,im2,DisparityVector)
%Calculate the disparity channel
%By Elena Mancinelli, Johns Hopkins University, 2018

C_SAD_cos=CosineSadMatrix(im1,im2,DisparityVector,7);
disparity_evaluated=length(DisparityVector);

for num_mappe=1:disparity_evaluated
    mappe(:,:,num_mappe)=  C_SAD_cos{1,num_mappe};
end

n=0;
for i=1:disparity_evaluated
    for j=1:disparity_evaluated
        if j~=i
            n=n+1;
            opponency_temp=mappe(:,:,i)-mappe(:,:,j);
            opponency_temp(opponency_temp<0)=0;
            disparityChannel(:,:,n)=opponency_temp;
        end
    end
end

end