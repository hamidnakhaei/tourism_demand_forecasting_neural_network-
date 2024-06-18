function [X_train , y_train , X_validation , y_validation ,...
                X_test , y_test] = ...
                Kfold (raw_X , raw_y , k , ith)
% X is training input data set, y is training output data set
% Xv is validation input data set, yv is validation output data set
% Xt is test input data set, yt is test output data set

X_test = raw_X (20:21 , :);
y_test = raw_y (20:21 , :);

raw_X (20:21 , :) = [];
raw_y (20:21 , :) = [];

s = (ith - 1)*k + 1;  % starting row of validation data
e = ith*k;            % ending row of validation data
X_validation = raw_X (s:e  , :);
X_train = raw_X;
X_train (s:e  , :) = [];
y_validation = raw_y (s:e  , :);
y_train = raw_y;
y_train (s:e , :) = [];



end