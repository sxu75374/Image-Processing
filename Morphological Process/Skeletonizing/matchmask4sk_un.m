function match = matchmask4sk_un(matrix)
%PATTERNMATCH_UNSK ¥À¥¶œ‘ æ”–πÿ¥À∫Ø ˝µƒ’™“™
%   ¥À¥¶œ‘ æœÍœ∏Àµ√˜
match = false;
SK = {[0,0,0;0,1,0;0,0,1],[0,0,0;0,1,0;1,0,0],[0,0,1;0,1,0;0,0,0],[1,0,0;0,1,0;0,0,0],...%SPUR
    [0,0,0;0,1,0;0,1,0],[0,0,0;0,1,1;0,0,0],[0,0,0;1,1,0;0,0,0],[0,1,0;0,1,0;0,0,0],...%single 4-connection
    [0,1,0;0,1,1;0,0,0],[0,1,0;1,1,0;0,0,0],[0,0,0;0,1,1;0,1,0],[0,0,0;1,1,0;0,1,0],...%l-corner
    };
x1 = matrix(1,1);
x2 = matrix(1,2);
x3 = matrix(1,3);
x4 = matrix(2,1);
x5 = matrix(2,2);
x6 = matrix(2,3);
x7 = matrix(3,1);
x8 = matrix(3,2);
x9 = matrix(3,3);
for i = 1:size(SK,2)
    if(isequal(matrix,SK{1,i}))
        match = true;
        return;
    end
end
if(x5==0)
    match = false;
    return;
else
    if((x1+x2+x4+x5==4))
        match =true;
        return;
    end
if((x5+x6+x8+x9==4))
    match =true;
    return;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%corner-cluster
if((x2+x4+x5+x6==4))
    match =true;
    return;
end
if((x2+x4+x5+x8==4))
    match =true;
    return;
end
if((x4+x5+x6+x8==4))
    match =true;
    return;
end
if((x2+x5+x6+x8==4))
    match =true;
    return;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%tee
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%branch
if((x1+x3+x5==3)&&(x7+x8+x9>=1))
    match =true;
    return;
end

if((x1+x5+x7==3)&&(x3+x6+x9>=1))
    match =true;
    return;
end
if((x5+x7+x9==3)&&(x1+x2+x3>=1))
    match =true;
    return;
end
if((x3+x5+x9==3)&&(x1+x4+x7>=1))
    match =true;
    return;
end
if((x2+x5+x6+x7==4)&&(x3+x4+x8==0))
    match =true;
    return;
end
if((x2+x4+x5+x9==4)&&(x1+x6+x8==0))
    match =true;
    return;
end
if((x3+x4+x5+x8==4)&&(x2+x6+x7==0))
    match =true;
    return;
end
if((x1+x5+x6+x8==4)&&(x2+x4+x9==0))
    match =true;
    return;
end
end
end


