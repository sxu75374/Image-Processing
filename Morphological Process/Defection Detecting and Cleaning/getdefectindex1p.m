function index = getdefectindex1p(original)

height = length(original(:,1));
width = length(original(1,:));
index = zeros(500,2);
c=0;
for i = 3:height-2
    for j = 3:width-2
        if original(i,j)==1&&sum(sum(original(i-1:i+1,j-1:j+1)))==1
            c = c+1;
            index(c,1) = i;
            index(c,2) = j;
        end
    end
end
end