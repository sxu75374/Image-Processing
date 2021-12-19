function new = canvas(left,middle,right,expand)

height_right = length(right(:,1,1));
width_right = length(right(1,:,1));

left_new = zeros(height_right,width_right,3);
left_new(7:height_right,4:width_right,:) = left;
middle_new = zeros(height_right,width_right,3)

height_left = length(left(:,1,1));
width_left = length(left(1,:,1));
height_middle = length(middle(:,1,1));
width_middle = length(middle(1,:,1));

new = zeros(height_right+2*expand,width_left+width_middle+width_right+2*expand,3);

new(expand+7:expand+height_left+6,expand+1:expand+width_left,:) = left;
new(expand+3:expand+height_middle+2,expand+width_left+1:expand+width_left+width_middle,:) = middle;
new(expand+1:expand+height_right,expand+width_left+width_middle+1:expand+width_left+width_middle+width_right,:) = right;
% new(i+expand,j+expand+width_left,d) = middle(i,j,d);
% new(i+expand,j+2*expand+width_left+width_middle,d) = right(i,j,d);
end


