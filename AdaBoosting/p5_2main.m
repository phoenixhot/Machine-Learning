% Code for homework 1 problem 5 (2). AdaBoosting
% Tongtong Lu Oct. 2018
% Note: it may take dozens of seconds to run depending on computer
% performance

% Close all
clear; close all; clc

% Load data
rawdata  = load('data_bupa.mat');
raw_size = 345; % raw data size
x_raw = ones(raw_size,6); % initialization
x_raw(:,:) = rawdata.data.raw(:,1:6); % read raw data
y_raw = rawdata.data.raw(:,7);
y_raw = y_raw*2-3; % using -1 for selector field 1, 1 for malignant for selector 2

% divide into training set and test set
train_size = 310;
test_size = 35;
x_test = zeros(test_size,6);
y_test = zeros(test_size,1);
x_train = zeros(train_size,6);
y_train = zeros(train_size,1);

iter = 100; % number of iterations
training_errors = zeros(50,iter);
test_errors = zeros(50,iter);

for i=1:50  % 50 random splits
        % Generage test set
        flag = ones (raw_size,1);   % label elements used or not
        test_set_counter = 0;
        while (test_set_counter<test_size) % generate test set
            pos = 0;
            while ((pos==0)||(pos>raw_size)) % randomize a element position
                pos = round(rand(1)*raw_size);
            end
            if (flag(pos)==1)   % element not used before
                test_set_counter = test_set_counter+1;
                x_test(test_set_counter,:) = x_raw(pos,:);
                y_test(test_set_counter,:) = y_raw(pos,:);
                flag(pos)=0;
            end
        end
        % Generate training set
        train_set_counter = 0;
        for j=1:raw_size
            if (flag(j)==1)
                train_set_counter = train_set_counter + 1;
                x_train(train_set_counter,:) = x_raw(j,:);
                y_train(train_set_counter,:) = y_raw(j,:);
            end
        end
        
        % AdaBoosting parameters
        d = ones(train_size,1);    % sample weights
        d = double(d);
        d = d*(1/train_size);
        j_selected = zeros(iter,1); % selected j vector for each iteration
        c_thres = zeros(iter,1); % seclted threshold for each iteration
        c_1 = zeros (iter,1); % class label c1 for each iteration
        alpha = zeros (iter,1); % weight of each weaker learner
        
        % Adaboosting
        for j = 1:iter
            [j_selected(j), c_thres(j), c_1(j), error] = WeakClassifSeek(x_train, y_train, train_size, d);    % find the weak classifier 
            d = d_update(d, x_train, y_train, train_size, error, j_selected(j), c_thres(j), c_1(j));  % updata sample weights
            alpha(j) = 0.5*log((1-error)/error); % update current weak classifier weight
            training_errors(i,j) = test_set_testing(alpha, j_selected, c_thres, c_1, j, x_train, y_train, train_size);
            test_errors(i,j) = test_set_testing(alpha, j_selected, c_thres, c_1, j, x_test, y_test, test_size);
        end
end

% Output
average_training_err = zeros(iter,1);
average_test_err = zeros(iter,1);
for i=1:iter
    sum_train = 0;
    sum_test = 0;
    for j = 1:50
        sum_train = sum_train + training_errors(j,i);
        sum_test = sum_test + test_errors(j,i);
    end
    average_training_err(i) = sum_train/50;
    average_test_err(i) = sum_test/50;
end
scatter(1:iter,average_training_err,'filled')
xlabel('iteration times')
hold on
scatter(1:iter,average_test_err,'g','filled');
legend('training error','testing error');
        