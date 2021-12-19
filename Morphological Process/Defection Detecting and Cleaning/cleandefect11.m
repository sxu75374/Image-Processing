function new = cleandefect11(original,index)
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
        new(r-1:r+1,c-1:c+1)=0;

    end
end
end