function new = convert_to_bw(original,T)
height = length(original(:,1));
width = length(original(1,:));
new = zeros(height,width);
for i = 1:height
    for j = 1:width
        if original(i,j) < T
            new(i,j) = 0;
        else
            new(i,j) = 255;
        end
    end
end
end