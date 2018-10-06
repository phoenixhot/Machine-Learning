% Code for homework 1 problem 4. Logistic regression
% Tongtong Lu
% Oct. 2018
% main

% Clear all
clear; close all; clc

% Load data file
rawdata  = load('data_breastcaner.mat');
raw_size = 683; % raw data size
x_raw = ones(raw_size,10); % initialization
x_raw(:,2:10) = rawdata.data.raw(:,1:9); % read raw data. x_raw[1] initialized to 1 for w0
y_raw = rawdata.data.raw(:,10);
y_raw = y_raw./2.-1; % using 0 for benign, 1 for malignant

% divide train and test data set
train_size_full = 455;
test_size = 228;
x_test = zeros(test_size,10);
y_test = zeros(test_size,1);

train_size_portion = [0.01 0.02 0.03 0.125 0.625 1];
accuracy = zeros (5,1); % accuracy array for 5 averages
total_accuracy = zeros (6,1); % accuracy array for 6 train sets
for i = 1:6     % 6 train size cases
    train_size = round(train_size_portion(i)*train_size_full);
    for j = 1:5     % 5 splits average 
        flag = ones (raw_size,1);   % label elements used or not
        test_set_counter = 0;
        train_set_counter = 0;
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
        x_train = zeros(train_size,10);
        y_train = zeros(train_size,1);
        while (train_set_counter<train_size) % generate train set
            pos = 0;
            while ((pos==0)||(pos>raw_size))
                pos = round(rand(1)*raw_size);
            end
            if (flag(pos)==1)
                train_set_counter = train_set_counter+1;
                x_train(train_set_counter,:) = x_raw(pos,:);
                y_train(train_set_counter,:) = y_raw(pos,:);
                flag(pos)=0;
            end
        end        
        [w, iter] = logisReg(x_train, y_train); % iter returns iteration times
        [accuracy(j)] = test(w,x_test,y_test,test_size); % test accuracy
    end
    total_accuracy(i) = (accuracy'*[1 1 1 1 1]')/5; % Obtain average errors
end
plot(train_size_portion,total_accuracy)
xlabel('portion of the whole train set')
ylabel('error rate')
hold on 
scatter(train_size_portion, total_accuracy);