function new = dithering_matrix(original,I)

height = length(original(:,1));
width = length(original(1,:));
new = zeros(height,width);
N = length(I(:,1));
T = (I+0.5).*(255/N^2);
for i =1:height
    for j = 1:width
        if original(i,j) <= T(mod(i-1,N)+1,mod(j-1,N)+1)
            new(i,j) = 0;
        else
            new(i,j) = 255;
        end
    end
end          
end

