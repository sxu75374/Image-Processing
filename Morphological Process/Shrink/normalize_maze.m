function new = normalize_maze(original)

height = length(original(:,1));
width = length(original(1,:));
new = zeros(height,width);
for i = 1:height
    for j =1:width
        if original(i,j)<150 %maze horsedetect:150, shrink and thin sfj correct reult:200, spring connect ring:60, srk jar twopart: 128
            new(i,j)=0;
        else
            new(i,j)=1;
        end
    end
end
end
