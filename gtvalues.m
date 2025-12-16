clc;
clear all;
close all;
load uploadedvideo.mat
bpvalue=[110;112];
for i=1:frameCount
    rd=rand;
    if rd>.50
       gt(i)=bpvalue(1);
    else
        gt(i)=bpvalue(2);
    end
end
[rows,cols]=size(gt);
save('GroundTruths','gt','cols');