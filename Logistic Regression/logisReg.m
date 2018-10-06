function [w,iter] = logisReg(x_train, y_train)

    % Learning parameters initilization
    w = ones(10,1);
    count_matrix = ones(10,1);
    iter = 0; % iteralization counter

    % Gradient ascent
    delta_epsilon = 0.0001; % The iteration threshold
    delta = 1;  % iterate change
    eta = 0.001; % step size
    while (delta>delta_epsilon) % no regulization
        y_prime = 1.0./(1.0+exp(-x_train*w));
        diff = y_train-y_prime;
        delta = abs((eta.*x_train'*diff)'*count_matrix);
        w =w + (eta.*x_train'*diff);
        iter = iter +1;
    end;
end