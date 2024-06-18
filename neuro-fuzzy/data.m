%% initializing
clear all;
clc;
close all;
%% inserting data
x = [568000	693000	860000	1124000	1321000	1342000	1402000	1585000	1546000	1659000	1889000	2735000	2219000	2034000	2116000	2938000	3294126	4070415	4801826	5044412	5181018	4901083	5113524
];
m = numel (x)
X = zeros(m-1,1);
% calculating tourists of each year minus tourists of the next year
for i = 2:m
    X(i-1) = x(i) - x(i-1);
end
%X(i) is the i_th number of tourists minus (i-1)_th number of tourists
% and i starts at 1375
%% calculating some useful variables
max_X = max(X);
min_X = min(X);
UniversOfDiscourseLength = max_X - min_X;
number_of_subsets = 10;
L = UniversOfDiscourseLength / number_of_subsets;
%% calculating intervals
% one input per row
interv_input = zeros(number_of_subsets+1 ,1);
for i = 1:number_of_subsets+1
    interv_input(i) = min_X + (i-1)*L;   
end
interv_output = interv_input ;
%% creating fuzzy variables
% 10 variables for input and 10 variables for output
input = zeros (numel(X)-1 , number_of_subsets);
output = input;
for i = 1:numel(X)-1
        input(i , :) = mf (X(i) , interv_input);
end
for i = 2:numel(X)
        output(i-1 , :) = mf (X(i) , interv_input);
end
save ('DATA.mat' , 'input' , 'output');
% y1 = mf1 (x ,interv_input );
% y2 = mf2 (x ,interv_input );
% y3 = mf3 (x ,interv_input );
% y4 = mf4 (x ,interv_input );
% y5 = mf5 (x ,interv_input );
% y6 = mf6 (x ,interv_input );
% y7 = mf7 (x ,interv_input );
% y8 = mf8 (x ,interv_input );
% y9 = mf9 (x ,interv_input );
% y10 = mf10 (x ,interv_input );
