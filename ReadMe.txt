Proto-Object Based Visual Saliency Model with Disparity Channel (MATLAB code)

Elena Mancinelli, elena.mancinelli@studenti.polito.it
Johns Hopkins University

This model is based on Russell et al. model and includes a disparity channel.
The detail is written in E. Mancinelli, E. Niebur, and R. Etienne-Cummings. "Computational stereo-vision model of proto-object based saliency in three-dimensional spac", BioCAS2018.

===============================================================================
How to Use

(1) Add the folder of "ProtoObjectSaliencyDisparity" and its subfolders to your MATLAB path.
(2) Run "result=runProtoSalDisparity('FILENAME1','FILENAME2',[DIAPARITY VECTOR])"
    The first argue is the input file name of the right.
    The second argue is the input file name of the left.
    The third argue is the disparity vector to define how the disparity channel is tuned. The default value (-50:10:0) is set if it's not given.
    The output is a structure and its "data" field is the predicted saliency.

===============================================================================
References

1. Mancinelli, Elena, Ernst Niebur, and Ralph Etienne-Cummings. "Computational stereo-vision model of proto-object based saliency in three-dimensional space." 2018 IEEE Biomedical Circuits and Systems Conference (BioCAS). IEEE, 2018.
2. A. F. Russell, S. Mihalaş, R. von der Heydt, E. Niebur, and R. Etienne-Cummings, “A model of proto-object based saliency,” Vision Res., vol. 94, pp. 1–15, 2014.