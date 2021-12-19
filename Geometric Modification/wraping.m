function new  = wraping(original)

height = length(original(:,1,1));
width = length(original(1,:,1));
new = zeros(ceil(sqrt(2)*height),ceil(sqrt(2)*width),3);
%center = original((width+1)/2,(height+1)/2);
R = ceil(sqrt(2)*height)/2;
Hx = width/2;
Hy = height/2;
Hx_n = R;
Hy_n = R;
for i = 1:ceil(sqrt(2)*height)
    for j = 1:ceil(sqrt(2)*width)
        for dim = 1:3
            a = atan2(abs(Hx_n-j),abs(Hy_n-i));%radian angle
            
            r = sqrt((Hy_n-i)^2+(Hx_n-j)^2);%
            
            if (a>=0&&a<=pi/4)&&i<233&&j<233%
                l = Hx/cos(a);
                rate = r/R;
                x=round(Hx - l*rate*cos(a));
                y=round(Hy - l*rate*sin(a));
            
            elseif (a>pi/4&&a<=pi/2)&&i<233&&j<233
                l = Hy/sin(a);
                rate = r/R;
                x=round(Hx - l*rate*cos(a));
                y=round(Hy - l*rate*sin(a));
                
            elseif (a>=0&&a<=pi/4)&&i<233&&j>=233%
                l = Hx/cos(a);
                rate = r/R;
                x=round(Hx - l*rate*cos(a));
                y=round(Hy + l*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i<233&&j>=233%
                l = Hy/sin(a);
                rate = r/R;
                x=round(Hx - l*rate*cos(a));
                y=round(Hy + l*rate*sin(a));
                     
            elseif (a>=0&&a<=pi/4)&&i>=233&&j<233%
                l = Hx/cos(a);
                rate = r/R;
                x=round(Hx + l*rate*cos(a));
                y=round(Hy - l*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i>=233&&j<233%
                l = Hy/sin(a);
                rate = r/R;
                x=round(Hx + l*rate*cos(a));
                y=round(Hy - l*rate*sin(a));
                
            elseif (a>=0&&a<=pi/4)&&i>=233&&j>=233%
                l = Hx/cos(a);
                rate = r/R;
                x=round(Hx + l*rate*cos(a));
                y=round(Hy + l*rate*sin(a));
                
            elseif (a>pi/4&&a<=pi/2)&&i>=233&&j>=233%
                l = Hy/sin(a);
                rate = r/R;
                x=round(Hx + l*rate*cos(a));
                y=round(Hy + l*rate*sin(a));
            end

            if(x<=329&&x>0&&y<=329&&y>0)
                new(i,j,dim) = original(x,y,dim);
            end
        end
    end
end
end
