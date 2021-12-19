function new = random_thresholding(original)
height = length(original(:,1));
width = length(original(1,:));
new = zeros(height,width);
for i = 1:height
    for j = 1:width
        if original(i,j) < rand(1,1)*255
            new(i,j) = 0;
        else
            new(i,j) = 255;
        end
    end
end
end
    
