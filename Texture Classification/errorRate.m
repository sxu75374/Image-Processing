function error_rate = errorRate(correctlabel,predictlabel)

e = 0;
for i = 1:length(predictlabel(:,1))
    if predictlabel(i,1) ~= correctlabel(i,1)
        e = e+1;
    end
end
error_rate = e/length(predictlabel(:,1));