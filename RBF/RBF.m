
%% initializing
clear;
close all;
clc;
%% inserting raw data and statistical analysis
load('DATA');
% implementing k_fold cross validation method
% k = number of folds
k = 5;
% ith is fold number ith 
ith = 2; 
% randomizing the order of data
% sell = randperm ( size(raw_X , 1));
% X = raw_X;
% y = raw_y;
% for i = 1:size(raw_X , 1)
%     raw_X (i,:) = X (sell(i) , :);
%     raw_y (i,:) = y(sell(i) , :);
% end
[X , y , Xv , yv , Xt , yt , validation , ymean , ymax , ymin] = Kfold (raw_X , raw_y , k ,ith);
validation
%% RBF Properties
numRBFNeurons = 5;
sigma = 10;
beta = 1 ./ (2 .* sigma.^2);
%% train RBF
[Centers, betas, Theta] = trainRBF(X, y, numRBFNeurons, beta);
%% validating RBF
% Create an empty vector to hold the approximate function values.
pred = zeros(size(Xv , 1),1);
for (i = 1:length(pred))

	% Evaluate the RBFN at the query point xs(i) and store the result in ys(i).
	pred(i) = predict(Centers, betas, Theta, Xv(i,:));
	
end
c = pred - yv;
c = c.^2;
c = sum(c)/numel(yv);
c = c^(1/2)

%% test 
test = zeros(size(Xt , 1),1);
for i = 1:length(test)

	test(i) = predict(Centers, betas, Theta, Xt(i,:));
	
end
C = test - yt;
C = C.^2;
C = sum(C)/numel(yt);
C = C^(1/2)
