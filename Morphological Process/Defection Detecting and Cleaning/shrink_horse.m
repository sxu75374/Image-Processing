function [CDF,countloop,output] = shrink_horse(original)

height = length(original(:,1));
width = length(original(1,:));
pad = zeros(height+2,width+2);
pad(2:height+1,2:width+1) = original;
output = zeros(height+2,width+2);
new = zeros(height+2,width+2);
CDF=zeros(1,700);
countloop = 0;
c=0;
while(c~=1)
    countloop = countloop +1;
M = zeros(height+2,width+2);
for i = 2:height+1
    for j = 2:width+1
        if(pad(i,j)==0)
                M(i,j)=0;
        else
            if(matchmask4srk(pad(i-1:i+1,j-1:j+1))==1)
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
            if(matchmask4st_un(M(i-1:i+1,j-1:j+1))==1)
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
% check number of white point with the same size
numofpoint = 0;
for i = 2:height+1
    for j =2:width+1
        if pad(i,j)==1&&sum(sum(pad(i-1:i+1,j-1:j+1)))==1
           numofpoint = numofpoint +1;
        end
    end
end
CDF(1,countloop)=numofpoint;
    
end
output = pad;
end
