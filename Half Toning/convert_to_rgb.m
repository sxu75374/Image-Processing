function new = convert_to_rgb(original)
height = length(original(:,1,1));
width = length(original(1,:,1));
new = zeros(height,width,3);

for i = 1:height
    for j =1:width
        new(i,j,1) = 255 - original(i,j,1);%C - R 
        new(i,j,2) = 255 - original(i,j,2);%M - G
        new(i,j,3) = 255 - original(i,j,3);%Y - B
    end
end
end
