function [count,output] = thinning_test(original,n)

height = length(original(:,1));
width = length(original(1,:));
pad = zeros(height+2,width+2);
pad(2:height+1,2:width+1) = original;
output = zeros(height+2,width+2);
new = zeros(height+2,width+2);
count = 0;
for k = 1:n
    count = count +1;
M = zeros(height+2,width+2);
for i = 2:height+1
    for j = 2:width+1
        if(pad(i,j)==0)
                M(i,j)=0;
        else
            if(matchmask4thin(pad(i-1:i+1,j-1:j+1))==1)
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
pad=new;
end
output = pad;
end
