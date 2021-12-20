%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   (1) Shuai Xu           %%%
%%%   (2) 4922836719         %%%
%%%   (3) sxu75374@usc.edu   %%%
%%%   (4) 2/7/2021           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function recovered_image = convolute(padded_image,filter)
height_padded = length(padded_image(:,1));
width_padded = length(padded_image(1,:));
height_filter = length(filter(:,1));%number of the rows of the filter
width_filter = length(filter(1,:));%number of the columns of the filter
height_recovered = height_padded-height_filter+1;
width_recovered = width_padded-width_filter+1;

recovered_image = zeros(height_recovered,width_recovered);
for i = 1:height_padded-height_filter+1
    for j = 1:width_padded-width_filter+1
        for m = 1:height_filter
            for n = 1:width_filter
                 recovered_image(i,j) = recovered_image(i,j) + padded_image(i+m-1,j+n-1)*filter(m,n);
            end
        end
    end
end
end