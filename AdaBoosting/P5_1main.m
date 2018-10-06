% Code for homework 1 problem 5 (1). AdaBoosting
% Tongtong Lu Oct. 2018

% Close all
clear; close all; clc

% Load data
rawdata  = load('data_bupa.mat');
raw_size = 345; % raw data size
x_raw = ones(raw_size,6); % initialization
x_raw(:,:) = rawdata.data.raw(:,1:6); % read raw data
y_raw = rawdata.data.raw(:,7);
y_raw = y_raw*2-3; % using -1 for selector field 1, 1 for malignant for selector 2

% initialize AdaBoosting parameters
train_size = raw_size;
x_train = x_raw;
y_train = y_raw;
iter = 10; % number of iterations
d = ones(train_size,1);    % sample weights
d = double(d); % double precision
d = d*(1/train_size);
j_selected = zeros(iter,1); % selected j vector for each iteration
c_thres = zeros(iter,1); % seclted threshold for each iteration
c_1 = zeros (iter,1); % class label c1 for each iteration
alpha = zeros (iter,1); % weight of each weaker learner

% Adaboost
for i=1:iter
    [j_selected(i), c_thres(i), c_1(i), error] = WeakClassifSeek(x_train, y_train, train_size, d);    % find the weak classifier 
    d = d_update(d, x_train, y_train, train_size, error, j_selected(i), c_thres(i), c_1(i));  % updata sample weights
    alpha(i) = 0.5*log((1-error)/error); % update current weak classifier weight   
end

% Print data
j_selected'
c_thres'
c_1'

