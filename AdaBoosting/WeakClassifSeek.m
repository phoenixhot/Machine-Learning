function [j_found, c_found, c_1_found, error] = WeakClassifSeek(x_train,y_train,train_size, d)
    error = 1;  % initialize error to maximum
    for j = 1:6     % search for each vector component
        min_value = round(min(x_train(:,j)))-0.5; % find the threshold bottom
        max_value = round(max(x_train(:,j)))+0.5;    % find the threshold limit
        for i = min_value:max_value     % try different threshold
                 current_c1 = -1;   % c1 = -1;
                 current_error = 0;   
                 
                 for k = 1:train_size   % compute errors
                    if ((x_train(k,j)<i)&&(y_train(k)==-1))
                        current_error = current_error + d(k);
                    end
                    if ((x_train(k,j)>=i)&&(y_train(k)==1))
                        current_error = current_error + d(k);
                    end
                 end
                 if (current_error<error)
                    j_found = j;
                    c_found = i;
                    c_1_found = current_c1;
                    error = current_error;
                 end
                 
                 current_c1 = 1;    % c1 =1;
                 current_error = 0;
                 for k = 1:train_size   % compute errors
                    if ((x_train(k,j)<i)&&(y_train(k)==1))
                        current_error = current_error + d(k);
                    end
                    if ((x_train(k,j)>=i)&&(y_train(k)==-1))
                        current_error = current_error + d(k);
                    end
                 end
                 if (current_error<error)
                    j_found = j;
                    c_found = i;
                    c_1_found = current_c1;
                    error = current_error;
                 end
        end
    end
end