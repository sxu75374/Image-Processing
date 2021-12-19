function b = error_diffusion(original,filtername,threshold)
height = length(original(:,1));
width = length(original(1,:));

switch filtername
    case 'Floyd'
        
h = (1/16)*[0 0 0; 0 0 7; 3 5 1];
filtersize = length(h(:,1));
b = zeros(height,width);
pad = zeros(height+filtersize-1,width+filtersize-1);
pad((filtersize+1)/2:(filtersize-1)/2+height,(filtersize+1)/2:(filtersize-1)/2+width) = original(:,:);
for i = (filtersize+1)/2:(filtersize-1)/2+height
    if mod(i+1,2)~=0 % odd
        for j = (filtersize+1)/2:(filtersize-1)/2+width
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j+1)=pad(i,j+1)+h(2,3)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(3,3)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(3,1)*e;
                pad(i+1,j)=pad(i+1,j)+h(3,2)*e;
        end
    else % even
        for j = width+(filtersize-1)/2:-1:1+(filtersize-1)/2
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j-1)=pad(i,j-1)+h(2,3)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(3,3)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(3,1)*e;
                pad(i+1,j)=pad(i+1,j)+h(3,2)*e;
         end
    end

end

    case 'JJN'
        
h = (1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5; 3 5 7 5 3; 1 3 5 3 1];
filtersize = length(h(:,1));
b = zeros(height,width);
pad = zeros(height+filtersize-1,width+filtersize-1);
pad((filtersize+1)/2:(filtersize-1)/2+height,(filtersize+1)/2:(filtersize-1)/2+width) = original(:,:);
for i = (filtersize+1)/2:(filtersize-1)/2+height
    if mod(i,2)~=0 % odd
        for j = (filtersize+1)/2:(filtersize-1)/2+width
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j+1)=pad(i,j+1)+h(3,4)*e;
                pad(i,j+2)=pad(i,j+2)+h(3,5)*e;
                pad(i+1,j-2)=pad(i+1,j-2)+h(4,1)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(4,2)*e;
                pad(i+1,j)=pad(i+1,j)+h(4,3)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(4,4)*e;
                pad(i+1,j+2)=pad(i+1,j+2)+h(4,5)*e;
                pad(i+2,j-2)=pad(i+2,j-2)+h(5,1)*e;
                pad(i+2,j-1)=pad(i+2,j-1)+h(5,2)*e;
                pad(i+2,j)=pad(i+2,j)+h(5,3)*e;
                pad(i+2,j+1)=pad(i+2,j+1)+h(5,4)*e;
                pad(i+2,j+2)=pad(i+2,j+2)+h(5,5)*e;
        end
    else % even
        for j = width+(filtersize-1)/2:-1:1+(filtersize-1)/2
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j-1)=pad(i,j-1)+h(3,4)*e;
                pad(i,j-2)=pad(i,j-2)+h(3,5)*e;
                pad(i+1,j+2)=pad(i+1,j+2)+h(4,1)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(4,2)*e;
                pad(i+1,j)=pad(i+1,j)+h(4,3)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(4,4)*e;
                pad(i+1,j-2)=pad(i+1,j-2)+h(4,5)*e;
                pad(i+2,j+2)=pad(i+2,j+2)+h(5,1)*e;
                pad(i+2,j+1)=pad(i+2,j+1)+h(5,2)*e;
                pad(i+2,j)=pad(i+2,j)+h(5,3)*e;
                pad(i+2,j-1)=pad(i+2,j-1)+h(5,4)*e;
                pad(i+2,j-2)=pad(i+2,j-2)+h(5,5)*e;
         end
    end

end
      
    case 'Stucki'

h = (1/42)*[0 0 0 0 0;0 0 0 0 0;0 0 0 8 4; 2 4 8 4 2; 1 2 4 2 1];
filtersize = length(h(:,1));
b = zeros(height,width);
pad = zeros(height+filtersize-1,width+filtersize-1);
pad((filtersize+1)/2:(filtersize-1)/2+height,(filtersize+1)/2:(filtersize-1)/2+width) = original(:,:);
for i = (filtersize+1)/2:(filtersize-1)/2+height
    if mod(i,2)~=0 % odd
        for j = (filtersize+1)/2:(filtersize-1)/2+width
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j+1)=pad(i,j+1)+h(3,4)*e;
                pad(i,j+2)=pad(i,j+2)+h(3,5)*e;
                pad(i+1,j-2)=pad(i+1,j-2)+h(4,1)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(4,2)*e;
                pad(i+1,j)=pad(i+1,j)+h(4,3)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(4,4)*e;
                pad(i+1,j+2)=pad(i+1,j+2)+h(4,5)*e;
                pad(i+2,j-2)=pad(i+2,j-2)+h(5,1)*e;
                pad(i+2,j-1)=pad(i+2,j-1)+h(5,2)*e;
                pad(i+2,j)=pad(i+2,j)+h(5,3)*e;
                pad(i+2,j+1)=pad(i+2,j+1)+h(5,4)*e;
                pad(i+2,j+2)=pad(i+2,j+2)+h(5,5)*e;
        end
    else % even
        for j = width+(filtersize-1)/2:-1:1+(filtersize-1)/2
            if pad(i,j) > threshold
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 255;
                e = pad(i,j)-255;
            else
                b(i-(filtersize-1)/2,j-(filtersize-1)/2) = 0;
                e = pad(i,j)-0;
            end
                pad(i,j-1)=pad(i,j-1)+h(3,4)*e;
                pad(i,j-2)=pad(i,j-2)+h(3,5)*e;
                pad(i+1,j+2)=pad(i+1,j+2)+h(4,1)*e;
                pad(i+1,j+1)=pad(i+1,j+1)+h(4,2)*e;
                pad(i+1,j)=pad(i+1,j)+h(4,3)*e;
                pad(i+1,j-1)=pad(i+1,j-1)+h(4,4)*e;
                pad(i+1,j-2)=pad(i+1,j-2)+h(4,5)*e;
                pad(i+2,j+2)=pad(i+2,j+2)+h(5,1)*e;
                pad(i+2,j+1)=pad(i+2,j+1)+h(5,2)*e;
                pad(i+2,j)=pad(i+2,j)+h(5,3)*e;
                pad(i+2,j-1)=pad(i+2,j-1)+h(5,4)*e;
                pad(i+2,j-2)=pad(i+2,j-2)+h(5,5)*e;
         end
    end

end



end