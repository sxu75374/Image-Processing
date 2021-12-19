function new = Panorama(original,H_left,H_right,boundary)

height = length(original(:,1,1));
width = length(original(1,:,1));
new = zeros(height,width,3);

for i = 7+boundary:489+boundary
    for j = 1+boundary:322+boundary
        for k = 1:3
            p = [i;j;1];
            p = H_left*p;
            x = round(p(1)/p(3));
            y = round(p(2)/p(3));
            if(x>1&&y>1)
                new(x-3:x+3,y-3:y+3,k) = original(i,j,k) ;
            end
        end
    end
end

for i = 1+boundary:489+boundary
    for j = 1+322+325+boundary:322+325+325+boundary
        for k = 1:3
            p = [i;j;1];
            p = H_right*p;
            x = round(p(1)/p(3));
            y = round(p(2)/p(3));
            if(x>1&&y>1)
                new(x-3:x+3,y-3:y+3,k) = original(i,j,k) ;

            end
        end
    end
end
for i = 3+boundary:489+boundary
    for j = 1+322+boundary:322+325+boundary
        for k = 1:3
            if (new(i,j,:)==0)
                new(i,j,:)=original(i,j,:);
            else
            new(i,j,k) = (new(i,j,k)+original(i,j,k))/2;
            end
        end
    end
end
end

