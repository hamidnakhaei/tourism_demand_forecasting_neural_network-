%% Initialization
clear all ; close all; clc

%% defining MLP overall properties
input_layer_size  = 5;    % 4 Inputs
hidden_layer_size = 20;    % 9 hidden units
output_layer_size = 1;   % 1 out put equevalent to incoming number of tourists  
                
%% Loading Data 
%  We start by first loading the dataset. 

% Load Training Data
fprintf('Loading Data ...\n')
% implementing k_fold cross validation method
load('DATA');
% k = number of folds
k = 5;
% ith is fold number ith 
ith = 2; 
% randomizing the order of data
sell = randperm ( size(raw_X , 1));
% selecting two first rows of randomized data for final test 

% X = raw_X;
% y = raw_y;
% m = size(raw_X, 1);
% for i = 1:m
%     raw_X (i,:) = X (sell(i) , :);
%     raw_y (i,:) = y(sell(i) , :);
% end
[X , y , Xv , yv , Xt , yt , validation , ymean , ymax , ymin , Xf] = Kfold (raw_X , raw_y , k ,ith);
validation
% for simplicity
pause;

%% Initializing Pameters 

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, output_layer_size);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% Compute Cost (Feedforward) 
[E , grad] = nnCostFunction(initial_nn_params, input_layer_size, hidden_layer_size, ...
                   output_layer_size, X, y);

fprintf(['Cost at initial parameters without regularization: %f '], E);
pause;

%% Training NN 
%training NN with SD method
fprintf('\nTraining Neural Network... \n')
nn_params = initial_nn_params;

% etta is training rate
etta = 5;
number_of_max_epochs = 10000;
E2 = E;
%Emax is the cost that we can tolerate
Emax = 1e-3;
for  i = 1:number_of_max_epochs
    if E >= Emax
        %avoiding of local mins
        E1 = E;
        if etta > .003
            if E2 > E1
                etta = 0.7*etta;
            elseif E2 < E1
                etta = 1.1*etta;
            end
        end
        nn_params = SD (nn_params , input_layer_size, ...
                          hidden_layer_size, output_layer_size, grad, etta); 
        [E, grad] = nnCostFunction(nn_params, input_layer_size, ...
                          hidden_layer_size, output_layer_size, X, y);
        E2 = E;
        E
    else
        fprintf('stopped after %d epochs with %f cost value' , i , E);
        break;
    end
end
fprintf('stopped stopped because of maximum epoch');

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 output_layer_size, (hidden_layer_size + 1));
E
fprintf('Program paused. Press enter to continue.\n');
pause;


%%  showing Weights

fprintf('\n showing Neural Network weights... \n')

display(Theta1(:, 2:end));
pause;
display(Theta2(:, 2:end));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% validation

pred = predict(Theta1, Theta2, Xv);
pred
c = pred - yv;
c = c.^2;
c = sum (c) / numel(yv);
c = c ^(1/2)
%% test
test = predict ( Theta1 , Theta2 , Xt);
test
C = test - yt;
C = C.^2;
C = sum(C)/ numel(yt);
C = C^(1/2)
o1 = test(1)*(ymax - ymin) + ymean
o2 = test(2)*(ymax - ymin) + ymean
%% future
future = predict ( Theta1 , Theta2 , Xf);
future (1) = future(1)* (ymax - ymin) + ymean
future (2) = future(2) * (ymax - ymin) + ymean