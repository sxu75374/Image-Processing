function match = matchmask4st_un(matrix)
%PATTERNMATCH_UN ¥À¥¶œ‘ æ”–πÿ¥À∫Ø ˝µƒ’™“™
%   ¥À¥¶œ‘ æœÍœ∏Àµ√˜
STU = {[0,0,1;0,1,0;0,0,0],[1,0,0;0,1,0;0,0,0],...
    [0,0,0;0,1,0;0,1,0],[0,0,0;0,1,1;0,0,0],...
    [0,0,1;0,1,1;0,0,0],[0,1,1;0,1,0;0,0,0],[1,1,0;0,1,0;0,0,0],[1,0,0;1,1,0;0,0,0],[0,0,0;1,1,0;1,0,0],[0,0,0;0,1,0;1,1,0],[0,0,0;0,1,0;0,1,1],[0,0,0;0,1,1;0,0,1],...
    [0,1,1;1,1,0;0,0,0],[1,1,0;0,1,1;0,0,0],[0,1,0;0,1,1;0,0,1],[0,0,1;0,1,1;0,1,0]};
match = false;
x1 = matrix(1,1);
x2 = matrix(1,2);
x3 = matrix(1,3);
x4 = matrix(2,1);
x5 = matrix(2,2);
x6 = matrix(2,3);
x7 = matrix(3,1);
x8 = matrix(3,2);
x9 = matrix(3,3);

for i = 1:size(STU,2)
    if(isequal(matrix,STU{1,i}))
        match = 1;
        return;
    end
end
if(x5==0)
    match = 0;
    return;
else
    
    if((x1+x4+x8+x9)==0&&(x2+x6>=1)&&(x3+x5+x7==3))
        match = 1;
        return;
    end
    if((x3+x6+x7+x8)==0&&(x2+x4>=1)&&(x1+x5+x9==3))
        match = 1;
        return;
    end
    if((x1+x2+x6+x9)==0&&(x8+x4>=1)&&(x3+x5+x7==3))
        match = 1;
        return;
    end
    if((x2+x3+x4+x7)==0&&(x6+x8>=1)&&(x1+x5+x9==3))
        match = 1;
        return;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%spur corner cluster
    if((x1+x2+x5+x4)==4)
        match = 1;
        return;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%corner spur cluster  
    if((x3+x8+x9)==0&&(x2+x4+x5+x6==4))
        match = 1;
        return;
    end
    if((x1+x7+x8)==0&&(x2+x4+x5+x6==4))
        match = 1;
        return;
    end
    if((x1+x2+x7)==0&&(x8+x4+x5+x6==4))
        match = 1;
        return;
    end
    if((x2+x3+x9)==0&&(x8+x4+x5+x6==4))
        match = 1;
        return;
    end
    if((x6+x7+x9)==0&&(x2+x4+x5+x8==4))
        match = 1;
        return;
    end
    if((x1+x3+x6)==0&&(x2+x4+x5+x8==4))
        match = 1;
        return;
    end
    if((x1+x3+x4)==0&&(x2+x6+x5+x8==4))
        match = 1;
        return;
    end
    if((x4+x7+x9)==0&&(x2+x6+x5+x8==4))
        match = 1;
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((x7+x8+x9)==1&&(x1+x3+x5==3))
        match = 1;
        return;
    end
    if((x3+x6+x9)==1&&(x1+x5+x7==3))
        match = 1;
        return;
    end
    if((x1+x2+x3)==1&&(x5+x7+x9==3))
        match = 1;
        return;
    end
    if((x1+x4+x7)==1&&(x3+x5+x9==3))
        match = 1;
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((x3+x4+x8)==0&&(x2+x5+x6+x7==4))
        match = 1;
        return;
    end
    if((x1+x6+x8)==0&&(x2+x4+x5+x9==4))
        match = 1;
        return;
    end
    if((x2+x6+x7)==0&&(x3+x4+x5+x8==4))
        match = 1;
        return;
    end
    if((x2+x4+x9)==0&&(x1+x5+x6+x8==4))
        match = 1;
        return;
    end
end
end

