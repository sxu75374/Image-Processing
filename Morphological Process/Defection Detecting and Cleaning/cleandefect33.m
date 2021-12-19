function new = cleandefect33(original,index)
height = length(original(:,1));
width = length(original(1,:));
pad = zeros(height+2,width+2);
pad(2:height+1,2:width+1) = original;

indexlen = length(index(:,1));

new = pad;
for i = 1:indexlen
    if (index(i,1)&&index(i,2))==0
        break;
    else
        r = index(i,1);
        c = index(i,2);
        new(r-3:r+3,c-3:c+3)=0;
    end
end
end