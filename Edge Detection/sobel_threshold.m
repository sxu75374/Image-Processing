function new = sobel_threshold(image,threshold)
height = length(image(:,1));
width = length(image(1,:));
new = zeros(height,width);

for i = 1:height
    for j = 1:width
        if image(i,j) >= threshold
            new(i,j) = 1;
        else
            new(i,j) = 0;
        end
    end
end
end
            