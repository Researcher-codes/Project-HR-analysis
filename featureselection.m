clc;
load('accuracies','values');
load GroundTruths.mat
% Define your fitness function

load('updatedfeatures','featureset');
selected_features=featureset;

% Define Firefly Algorithm parameters
num_features = size(selected_features, 2); % Number of available features
num_fireflies = 50; % Number of fireflies (population size)
max_generations = 10; % Maximum number of iterations
alpha = 0.2; % Attraction coefficient
beta_min = 0.2; % Minimum value for beta
gamma = 1; % Light absorption coefficient
initial_intensity = 1; % Initial firefly intensity

% Initialize fireflies
fireflies = rand(num_fireflies, num_features) > 0.5; % Randomly initialize
data=selected_features;
labels=gt;
% Main loop for Firefly Algorithm
for generation = 1:max_generations
    % Evaluate fitness of each firefly
    fitness = zeros(num_fireflies, 1);
    for i = 1:num_fireflies
        fitness(i) = fitnessfunction(find(fireflies(i, :)), data, labels);
    end
    
    % Update fireflies
    for i = 1:num_fireflies
        for j = 1:num_fireflies
            if fitness(i) < fitness(j)
                % Compute distance between fireflies
                distance = norm(fireflies(i, :) - fireflies(j, :));
                % Update beta based on attractiveness and distance
                beta = beta_min + (1 - beta_min) * exp(-gamma * distance^2);
                % Update firefly position
                fireflies(i, :) = fireflies(i, :) + alpha * (rand(1, num_features) - 0.5) * beta;
            end
        end
    end
end

% Find the best firefly (features) with the highest fitness
best_firefly = fireflies(find(fitness == max(fitness)), :);

% Selected features based on the best firefly
selected_features = find(best_firefly);

% Display the selected features
disp('Selected Features:');
disp(selected_features);




