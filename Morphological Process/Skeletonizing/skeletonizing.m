function [countloop,output] = skeletonizing(original)

height = length(original(:,1));
width = length(original(1,:));
pad = zeros(height+2,width+2);
pad(2:height+1,2:width+1) = original;
output = zeros(height+2,width+2);
new = zeros(height+2,width+2);
c=0;
countloop = 0;
while(c~=1)
    countloop = countloop +1;
M = zeros(height+2,width+2);
for i = 2:height+1
    for j = 2:width+1
        if(pad(i,j)==0)
                M(i,j)=0;
        else
            if(matchmask4skeleton(pad(i-1:i+1,j-1:j+1))==1)
                M(i,j) = 1;
            end
        end
    end
end
       
for i = 2:height+1
    for j =2:width+1
        if(M(i,j)==0)
                new(i,j) = pad(i,j);
        else  
            if(matchmask4sk_un(M(i-1:i+1,j-1:j+1))==1)
                new(i,j) = pad(i,j);
            else
                new(i,j) = 0;
            end
        end
    end
end
if (new==pad)
    c=1;
else
    c=0;
end
pad=new;
end
output = pad;
end
