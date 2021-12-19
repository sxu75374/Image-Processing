function new = normalize(image)
width = length(image(1,:));
height = length(image(:,1));
new = zeros(height,width);
norm = max(max(image));
minx = min(min(image));
for i = 1:height
    for j = 1:width
%new(i,j) = abs(image(i,j));
new(i,j) = (image(i,j)-minx)/(norm-minx);
    end
end
end
    
    
    