%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   (1) Shuai Xu           %%%
%%%   (2) 4922836719         %%%
%%%   (3) sxu75374@usc.edu   %%%
%%%   (4) 2/7/2021           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function new = padding(original_image,filtersize)

height = length(original_image(:,1,:));
width = length(original_image(1,:,:));
%padding rows
mid = zeros(height+filtersize-1,width,1);
for i = 1:(filtersize-1)/2
    for j = 1:width
        mid(i,j,1) = original_image(filtersize+1-i-(filtersize-1)/2,j,1);
    end
end
mid((filtersize+1)/2:(filtersize-1)/2+height,:,1) = original_image(:,:,1);
for i = 1:(filtersize-1)/2
    for j = 1:width
        mid(height+(filtersize-1)/2+i,j,1) = mid(height-i+(filtersize-1)/2,j,1);
    end
end

%padding columns
new = zeros(height+filtersize-1,width+filtersize-1,1);
for i = 1:height+filtersize-1
    for j = 1:(filtersize-1)/2
        new(i,j,1) = mid(i,filtersize+1-j-(filtersize-1)/2,1);
    end
end
new(:,(filtersize+1)/2:(filtersize+1)/2+width-1,1) = mid(:,:,1);
for i = 1:height+filtersize-1
    for j = 1:(filtersize-1)/2
         new(i,width+(filtersize-1)/2+j,1) = new(i,width-j+(filtersize-1)/2,1);
    end
end
end