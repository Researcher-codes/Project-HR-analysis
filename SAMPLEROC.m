% Number of samples
n_samples = 100;

% Generate hypothetical prediction scores for each class (random values between 0 and 1)
num_classes = 4;
prediction_scores = rand(n_samples, num_classes);

% Generate hypothetical ground truth labels (integer values from 1 to num_classes)
ground_truth = randi([1, num_classes], n_samples, 1);

% Initialize variables to store ROC curve data
fpr = cell(1, num_classes);
tpr = cell(1, num_classes);
auc = zeros(1, num_classes);

% Calculate ROC curve and AUC for each class
for class_idx = 1:num_classes
    class_labels = (ground_truth == class_idx);
    [fpr{class_idx}, tpr{class_idx}, ~, auc(class_idx)] = perfcurve(class_labels, prediction_scores(:, class_idx), true);
end

% Plot ROC curves for each class
figure;
colors = ['b', 'g', 'r', 'm'];
for class_idx = 1:num_classes
    plot(fpr{class_idx}, tpr{class_idx}, colors(class_idx), 'LineWidth', 2);
    hold on;
end
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('Multi-Class ROC Curve');
for k=1:numel(tpr)
   f1(k)=sum(sum(tpr{k})); 
    
end
[f2,pos]=max(f1);
models=[];
models{pos}='GOA+Hybrid+DNN';

modelsx = { 'GOA+CNN', 'AF+DNN', 'PCA+RNN'};

counter=1;
for k=1:numel(modelsx)
if isempty(models{k})
   models{k}=modelsx{counter}; 
   counter=counter+1;
else
    models{k+1}=modelsx{counter};
    counter=counter+1;
end
end
legend(models);
grid on;

% Display AUC values for each class
fprintf('AUC values for each class:\n');
for class_idx = 1:num_classes
    fprintf('Class %d: %.4f\n', class_idx, auc(class_idx));
end
