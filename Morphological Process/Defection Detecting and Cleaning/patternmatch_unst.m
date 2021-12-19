function match = patternmatch_unst(P)
%PATTERNMATCH_UN 此处显示有关此函数的摘要
%   此处显示详细说明
STU = {[0,0,1;0,1,0;0,0,0],[1,0,0;0,1,0;0,0,0],...
    [0,0,0;0,1,0;0,1,0],[0,0,0;0,1,1;0,0,0],...
    [0,0,1;0,1,1;0,0,0],[0,1,1;0,1,0;0,0,0],[1,1,0;0,1,0;0,0,0],[1,0,0;1,1,0;0,0,0],[0,0,0;1,1,0;1,0,0],[0,0,0;0,1,0;1,1,0],[0,0,0;0,1,0;0,1,1],[0,0,0;0,1,1;0,0,1],...
    [0,1,1;1,1,0;0,0,0],[1,1,0;0,1,1;0,0,0],[0,1,0;0,1,1;0,0,1],[0,0,1;0,1,1;0,1,0]};
match = false;
x1 = P(1,1);
x2 = P(1,2);
x3 = P(1,3);
x4 = P(2,1);
x5 = P(2,2);
x6 = P(2,3);
x7 = P(3,1);
x8 = P(3,2);
x9 = P(3,3);

for i = 1:size(STU,2)
    if(isequal(P,STU{1,i}))
        match = true;
        return;
    end
end
if(x5==0)
    match = false;
    return;
else
    
    if((x1+x4+x8+x9)==0&&(x2+x6>=1)&&(x3+x5+x7==3))
        match = true;
        return;
    end
    if((x3+x6+x7+x8)==0&&(x2+x4>=1)&&(x1+x5+x9==3))
        match = true;
        return;
    end
    if((x1+x2+x6+x9)==0&&(x8+x4>=1)&&(x3+x5+x7==3))
        match = true;
        return;
    end
    if((x2+x3+x4+x7)==0&&(x6+x8>=1)&&(x1+x5+x9==3))
        match = true;
        return;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%spur corner cluster
    if((x1+x2+x5+x4)==4)
        match = true;
        return;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%corner spur cluster  
    if((x3+x8+x9)==0&&(x2+x4+x5+x6==4))
        match = true;
        return;
    end
    if((x1+x7+x8)==0&&(x2+x4+x5+x6==4))
        match = true;
        return;
    end
    if((x1+x2+x7)==0&&(x8+x4+x5+x6==4))
        match = true;
        return;
    end
    if((x2+x3+x9)==0&&(x8+x4+x5+x6==4))
        match = true;
        return;
    end
    if((x6+x7+x9)==0&&(x2+x4+x5+x8==4))
        match = true;
        return;
    end
    if((x1+x3+x6)==0&&(x2+x4+x5+x8==4))
        match = true;
        return;
    end
    if((x1+x3+x4)==0&&(x2+x6+x5+x8==4))
        match = true;
        return;
    end
    if((x4+x7+x9)==0&&(x2+x6+x5+x8==4))
        match = true;
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((x7+x8+x9)==1&&(x1+x3+x5==3))
        match = true;
        return;
    end
    if((x3+x6+x9)==1&&(x1+x5+x7==3))
        match = true;
        return;
    end
    if((x1+x2+x3)==1&&(x5+x7+x9==3))
        match = true;
        return;
    end
    if((x1+x4+x7)==1&&(x3+x5+x9==3))
        match = true;
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((x3+x4+x8)==0&&(x2+x5+x6+x7==4))
        match = true;
        return;
    end
    if((x1+x6+x8)==0&&(x2+x4+x5+x9==4))
        match = true;
        return;
    end
    if((x2+x6+x7)==0&&(x3+x4+x5+x8==4))
        match = true;
        return;
    end
    if((x2+x4+x9)==0&&(x1+x5+x6+x8==4))
        match = true;
        return;
    end
end
end

