function act = test(w,x_test,y_test,test_size)
    % accuracy test
    wrong = 0; % count how many errors
    result = 1.0./(1.0+exp(-x_test*w));
    for i=1:test_size
        if (result(i)<0.5)
            if (y_test(i)~=0)
                wrong = wrong + 1;
            end                
        else
            if (y_test(i)~=1)
                wrong = wrong + 1;
            end   
        end
    end
    act = wrong/test_size;
end