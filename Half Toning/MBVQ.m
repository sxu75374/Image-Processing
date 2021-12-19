function new = MBVQ(original)
height = length(original(:,1,1));
width = length(original(1,:,1));
new = zeros(height,width,3);
pad = zeros(height+2,width+2,3);
pad(2:height+1,2:width+1,:) = original(:,:,:);
h = (1/16)*[0 0 0; 0 0 7; 3 5 1];
for i = 2:height+1
    if mod(i+1,2)~=0
        for j = 2:width+1
            quadrant = determine_MBVQ(pad(i,j,1),pad(i,j,2),pad(i,j,3));
            v = getNearestVertex(quadrant, pad(i,j,1)/255, pad(i,j,2)/255, pad(i,j,3)/255);
            new(i-1,j-1,1) = v(1,1,1);
            new(i-1,j-1,2) = v(1,1,2);
            new(i-1,j-1,3) = v(1,1,3);
            e1 = pad(i,j,1) - new(i-1,j-1,1);
            e2 = pad(i,j,2) - new(i-1,j-1,2);
            e3 = pad(i,j,3) - new(i-1,j-1,3);

            pad(i,j+1,1) = pad(i,j+1,1) + h(2,3)*e1;
            pad(i,j+1,2) = pad(i,j+1,2) + h(2,3)*e2;
            pad(i,j+1,3) = pad(i,j+1,3) + h(2,3)*e3;

            pad(i+1,j+1,1)=pad(i+1,j+1,1)+h(3,3)*e1;
            pad(i+1,j+1,2)=pad(i+1,j+1,2)+h(3,3)*e2;
            pad(i+1,j+1,3)=pad(i+1,j+1,3)+h(3,3)*e3;

            pad(i+1,j-1,1)=pad(i+1,j-1,1)+h(3,1)*e1;
            pad(i+1,j-1,2)=pad(i+1,j-1,2)+h(3,1)*e2;
            pad(i+1,j-1,3)=pad(i+1,j-1,3)+h(3,1)*e3;

            pad(i+1,j,1)=pad(i+1,j,1)+h(3,2)*e1;
            pad(i+1,j,2)=pad(i+1,j,2)+h(3,2)*e2;
            pad(i+1,j,3)=pad(i+1,j,3)+h(3,2)*e3;
        end
    else
        for j = width+1:-1:2
            quadrant = determine_MBVQ(pad(i,j,1),pad(i,j,2),pad(i,j,3));
            v = getNearestVertex(quadrant, pad(i,j,1)/255, pad(i,j,2)/255, pad(i,j,3)/255);
            new(i-1,j-1,1) = v(1,1,1);
            new(i-1,j-1,2) = v(1,1,2);
            new(i-1,j-1,3) = v(1,1,3);
            e1 = pad(i,j,1) - new(i-1,j-1,1);
            e2 = pad(i,j,2) - new(i-1,j-1,2);
            e3 = pad(i,j,3) - new(i-1,j-1,3);

            pad(i,j-1,1) = pad(i,j-1,1) + h(2,3)*e1;
            pad(i,j-1,2) = pad(i,j-1,2) + h(2,3)*e2;
            pad(i,j-1,3) = pad(i,j-1,3) + h(2,3)*e3;

            pad(i+1,j-1,1)=pad(i+1,j-1,1)+h(3,3)*e1;
            pad(i+1,j-1,2)=pad(i+1,j-1,2)+h(3,3)*e2;
            pad(i+1,j-1,3)=pad(i+1,j-1,3)+h(3,3)*e3;

            pad(i+1,j+1,1)=pad(i+1,j+1,1)+h(3,1)*e1;
            pad(i+1,j+1,2)=pad(i+1,j+1,2)+h(3,1)*e2;
            pad(i+1,j+1,3)=pad(i+1,j+1,3)+h(3,1)*e3;

            pad(i+1,j,1)=pad(i+1,j,1)+h(3,2)*e1;
            pad(i+1,j,2)=pad(i+1,j,2)+h(3,2)*e2;
            pad(i+1,j,3)=pad(i+1,j,3)+h(3,2)*e3;
        end
    end
end
end