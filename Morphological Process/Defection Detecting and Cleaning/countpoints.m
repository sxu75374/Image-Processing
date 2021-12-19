function number = countpoints(original)
height = length(original(:,1));
width = length(original(1,:));
number = 0;
for i = 1:height
    for j = 1:width
        if original(i,j)==1
            number = number +1;
        end
    end
end
end