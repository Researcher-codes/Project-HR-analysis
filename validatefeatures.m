clc;
load('forehead_features.mat', 'hogFeatures', 'lbpFeatures', 'harrisFeatures');
load GroundTruths.mat

considerable_frames=cols;
harrisFeatures= double(harrisFeatures');
hogFeatures=double(hogFeatures);
lbpFeatures=double(lbpFeatures);
harrisf=harrisFeatures(1:considerable_frames,:);
hogf=hogFeatures(1:considerable_frames,1:300);
lbpf=lbpFeatures(1:considerable_frames,:);

%%%%% testing the features
%%%% hog%%%%
net=newff(hogf',gt,10);
net.trainparam.epochs=100;
net=train(net,hogf',gt);
resultshog=round(sim(net,hogf'));

%%%%%% harris %%%%%%
net=newff(harrisf',gt,10);
net.trainparam.epochs=100;
net=train(net,harrisf',gt);
resultsharris=round(sim(net,harrisf'));

%%%%%% lbp %%%%%%
net=newff(lbpf',gt,10);
net.trainparam.epochs=100;
net=train(net,lbpf',gt);
resultslbp=round(sim(net,lbpf'));

accuracyhog=EvaluateAccuracy(resultshog,gt);
accuracyharris=EvaluateAccuracy(resultsharris,gt);
accuracylbp=EvaluateAccuracy(resultslbp,gt);

labels = {'Hog Accuracy', 'Harris Accuracy', 'LBP Accuracy'};

% Values for the bars
values = [accuracyhog, accuracyharris, accuracylbp];
labels = {'Hog Accuracy', 'Harris Accuracy', 'LBP Accuracy'};

% Values for the bars
values = [accuracyhog, accuracyharris, accuracylbp];
figure,
customColors = [0.1 0.3 0.7; 0.9 0.2 0.2; 0.2 0.7 0.2; 1.0 0.6 0.0; 0.5 0.2 0.5];

% Create a bar graph
bar(values, 'FaceColor', 'flat');
colormap(customColors);

% Set tick labels for x-axis
set(gca, 'XTickLabel', labels);

% Add labels and title
xlabel('Accuracy Type');
ylabel('Accuracy Value');
title('Accuracy Comparison');
[maxacr,maxpos]=max(values);
% Display the graph
if maxpos==1
   featureset=hogf;
elseif maxpos==2
    featureset=harrisf;
else
    featureset=lbpf;
end
grid on;
selected_set=values(maxpos);
save('accuracies','values');

save('updatedfeatures','featureset');







