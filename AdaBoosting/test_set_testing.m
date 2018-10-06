function test_err = test_set_testing(alpha, j_selected, c_thres, c_1, j, x_test, y_test, test_size)
    err_counter = 0;
    for i = 1:test_size
        sign = 0;
        for k = 1:j
            sign = sign + alpha(k)*(c_1(k)*(x_test(i,j_selected(k))>=c_thres(k))+(0-c_1(k))*(x_test(i,j_selected(k))<c_thres(k)));
        end
        if ((sign>=0)&&(y_test(i)==-1))
            err_counter = err_counter + 1;
        end
        if ((sign<0)&&(y_test(i)==1))
            err_counter = err_counter + 1;
        end
    end
    test_err = err_counter/test_size;
end