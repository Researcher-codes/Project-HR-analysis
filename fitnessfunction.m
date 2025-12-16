function accuracy = fitnessfunction(selected_features, data, labels)
    % Assuming you have a classification function/classifier (e.g., SVM)
    % Train the classifier with the selected features
    classifier = fitcknn(data(:, selected_features), labels);
    
    % Perform cross-validation or any other evaluation method
    % Here, we use k-fold cross-validation as an example
    cv = crossval(classifier);
    accuracy = 1 - kfoldLoss(cv); % Classification error to accuracy conversion
end