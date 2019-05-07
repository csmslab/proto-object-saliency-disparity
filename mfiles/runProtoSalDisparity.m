function h = runProtoSalDisparity(filename1,filename2,dVector)
%Runs the proto-object based saliency algorithm with disparity channel
%
%inputs:
%filename1 - filename of image Right
%filename2 - filename of image Left
%dVector - Disparity Vector : Disparity channel is tuned to these numbers.

%
%By Alexander Russell and Stefan Mihalas, Johns Hopkins Univeristy, 2012
%Modified by Elena Mancinelli, Johns Hopkins University, 2018


fprintf('Start Proto-Object & disparity Saliency')
%generate parameter structure
params = makeDefaultParams_disparity;
if nargin==2
    params.dVector = -50:10:0;
else
    params.dVector = dVector;
end
%load and normalize image
im1 = normalizeImage(im2double(imread(filename1)));
im2 = normalizeImage(im2double(imread(filename2)));

%generate feature channels
img = generateChannels_disparity(im1,im2,params);

%generate border ownership structures
[b1Pyr b2Pyr]  = makeBorderOwnership(img,params);        
%generate grouping pyramids
gPyr = makeGrouping(b1Pyr,b2Pyr,params);
%normalize grouping pyramids and combine into final saliency map
collapseLevel=1;
h = ittiNorm_disparity(gPyr,collapseLevel);

fprintf('\nDone\n')