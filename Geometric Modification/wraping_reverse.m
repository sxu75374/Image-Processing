function new  = wraping_reverse(original)

height = length(original(:,1,1));
width = length(original(1,:,1));
new = zeros(floor(height/sqrt(2)),floor(width/sqrt(2)),3);

R = height/2;
Hx = R;
Hy = R;
Hx_n = floor(width/sqrt(2))/2;
Hy_n = floor(height/sqrt(2))/2;
for i = 1:floor(height/sqrt(2))
    for j = 1:floor(width/sqrt(2))
        for dim = 1:3
            a = atan2(abs(Hx_n-j),abs(Hy_n-i));%radian angle
            
            r = sqrt((Hy_n-i)^2+(Hx_n-j)^2);%
            
            if (a>=0&&a<=pi/4)&&i<Hx_n&&j<Hy_n%
                l = Hx_n/cos(a);
                rate = r/l;
                x=round(Hx - R*rate*cos(a));
                y=round(Hy - R*rate*sin(a));
            
            elseif (a>pi/4&&a<=pi/2)&&i<Hx_n&&j<Hy_n
                l = Hy_n/sin(a);
                rate = r/l;
                x=round(Hx - R*rate*cos(a));
                y=round(Hy - R*rate*sin(a));
                
            elseif (a>=0&&a<=pi/4)&&i<Hx_n&&j>=Hy_n
                l = Hx_n/cos(a);
                rate = r/l;
                x=round(Hx - R*rate*cos(a));
                y=round(Hy + R*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i<Hx_n&&j>=Hy_n
                l = Hy_n/sin(a);
                rate = r/l;
                x=round(Hx - R*rate*cos(a));
                y=round(Hy + R*rate*sin(a));
                     
            elseif (a>=0&&a<=pi/4)&&i>=Hx_n&&j<Hy_n
                l = Hx_n/cos(a);
                rate = r/l;
                x=round(Hx + R*rate*cos(a));
                y=round(Hy - R*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i>=Hx_n&&j<Hy_n
                l = Hy_n/sin(a);
                rate = r/l;
                x=round(Hx + R*rate*cos(a));
                y=round(Hy - R*rate*sin(a));
                
            elseif (a>=0&&a<=pi/4)&&i>=Hx_n&&j>=Hy_n
                l = Hx_n/cos(a);
                rate = r/l;
                x=round(Hx + R*rate*cos(a));
                y=round(Hy + R*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i>=Hx_n&&j>=Hy_n
                l = Hy_n/sin(a);
                rate = r/l;
                x=round(Hx + R*rate*cos(a));
                y=round(Hy + R*rate*sin(a));
            end

            if(x<=width&&x>0&&y<=height&&y>0)
                new(i,j,dim) = original(x,y,dim);
            end
        end
    end
end
end
