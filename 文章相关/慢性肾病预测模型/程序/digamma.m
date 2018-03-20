function [fi_t] = digamma( t)
%%% this is the digamma function
C=0.5772156;
if t<1
    fprintf('error\n');
else if t==1
    fi_t=-C;
    else
    
    fi_t=digamma(t-1)+1/(t-1);
        
    end
end


end

