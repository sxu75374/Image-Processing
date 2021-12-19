function new = convert_to_gray(original,width,height)
new = zeros(height,width);
for i = 1:height
    for j = 1:width
        new(i,j) = original(i,j,1) * 0.2989 + original(i,j,2) * 0.587 + original(i,j,3) * 0.114;
    end
end
end