function d_output =d_update(d_input, x_train, y_train, train_size, error, j_vec, threshold, c1_value)
    d_output = zeros(train_size,1);
    for i=1:train_size
        if (c1_value == -1)
            if (x_train(i,j_vec)>=threshold)
                if (y_train(i)==1)
                     d_output(i) = d_input(i)/(2*error); % wrong
                else
                     d_output(i) = d_input(i)/(2*(1-error));    % correct
                end
            else
                if (y_train(i)==1)
                     d_output(i) = d_input(i)/(2*(1-error)); 
                else
                     d_output(i) =  d_input(i)/(2*error);
                end
            end
        else % c1=1
            if (x_train(i,j_vec)>=threshold)
                if (y_train(i)==1)
                     d_output(i) = d_input(i)/(2*(1-error)); 
                else
                     d_output(i) = d_input(i)/(2*error);
                end
            else
                if (y_train(i)==1)
                     d_output(i) = d_input(i)/(2*error); 
                else
                     d_output(i) = d_input(i)/(2*(1-error));
                end
            end
        end
    end
end