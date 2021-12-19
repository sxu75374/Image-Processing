horse = imread('horse.png');
% figure()
% imshow(horse)
horse_normal_c1 = normalize_c1(horse(:,:,1)); % for c1, t = 128
horse_normal_pad = zeros(322+2,422+2);
horse_normal_pad(2:322+1,2:422+1)=horse_normal_c1;
% figure()
% imshow(horse_normal_pad)
horse_inv_normal = 1-horse_normal_pad;
figure()
imshow(horse_inv_normal)
%%% test loop to see the break part
[CDFxh,number_of_loop_horse_break2,output] = shrink_test(horse_inv_normal,8); %8 break into 2 parts, 32 break into 3 parts
figure()
imshow(output)
[CDFxxh,number_of_loop_horse_break3,output2] = shrink_test(horse_inv_normal,32); %8 break into 2 parts, 32 break into 3 parts
figure()
imshow(output2)
% c2
[CDF,counttest,horse_test] = shrink_horse(horse_inv_normal); %shrink_test:15
figure()
imshow(horse_test)
%W39 = writeraw(horse_test, 'Figure 39: horse_test.raw',length(horse_test(1,:)),length(horse_test(:,1)),1);

figure()
bar(CDF)
title('CDF of the defects for each iteration');
xlim([0 700]);
ylim([0 80]);
xlabel('iteration');
ylabel('number of the defects after each iteration');
%W40 = writeraw(CDF, 'Figure 40: CDF.raw',length(CDF(1,:)),length(CDF(:,1)),1);

f=zeros(1,100);
f(1,1)=CDF(1,1);
for i = 1:100
    f(1,i+1) = CDF(i+1)-CDF(i);
end
% c1
defects = countpoints(horse_test);%uncount the outsider
% c2
figure()
bar(f)
title('frequency of the defects for differet size');
xlim([0 100]);
ylim([0 35]);
xlabel('size');
ylabel('number of the defects');
%W41 = writeraw(f, 'Figure 41: frequency.raw',length(f(1,:)),length(f(:,1)),1);

%% c3
horse_normal_c3 = normalize(horse(:,:,1)); % for c3, t = 128
horse_normal_pad_thin = zeros(322+20,422+20);
horse_normal_pad_thin(11:322+10,11:422+10)=horse_normal_c3;
figure()
imshow(horse_normal_pad_thin)
horse_inv_normal_thin = 1-horse_normal_pad_thin;
figure()
imshow(horse_inv_normal_thin)
[countj,horse_tt] = thinning_test(horse_inv_normal_thin,4);
figure();
imshow(horse_tt)
% 1st
index = getdefectindexsp1(horse_tt);
horse_clean = cleandefect22(horse_inv_normal_thin,index);
figure('NumberTitle', 'off', 'Name', 'first clean by 33');
imshow(horse_clean)
% 2nd
[countj,horse_tt2] = thinning_test(horse_clean,4);
figure();
imshow(horse_tt2)
index2 = getdefectindexsp2(horse_tt2);
horse_clean2 = cleandefect11(horse_clean,index2);
figure();
imshow(horse_clean2)
% 
old = horse_clean;
for i = 1:5
[countj,newthin] = thinning_test(old,4);

newindex = getdefectindexsp2(newthin);
result = cleandefect11(old,newindex);

old = result;
end
figure('NumberTitle', 'off', 'Name', '2 step clean by 55 3pixel')
imshow(newthin)
figure('NumberTitle', 'off', 'Name', '2 step clean by 55 3pixel')
imshow(result)
% 3 rd
%
old2 = result;
for i = 1:4
[countj,newthin2] = thinning_test(old2,4);

newindex2 = getdefectindex2(newthin2);
result2 = cleandefect22(old2,newindex2);

old2 = result2;
end

figure('NumberTitle', 'off', 'Name', '3 step thin')
imshow(newthin2)
figure('NumberTitle', 'off', 'Name', '3 step clean by 55 4pixel')
imshow(result2)

[cdf,c,shrinktoremove] = shrink_test(result2,5);
finalindex = getdefectindex1p(shrinktoremove);
finalresultbound = cleandefect33(result2,finalindex);
finalresult = finalresultbound(21:344,21:444);

figure('NumberTitle', 'off', 'Name', 'final')
imshow(finalresult)
%W42 = writeraw(finalresult, 'Figure 42: cleandefect.raw',length(finalresult(1,:)),length(finalresult(:,1)),1);

%% c4
horse = imread('horse.png');
horse_normal_c1 = normalize_c1(horse(:,:,1)); % for c1, t = 128
horse_normal_pad = zeros(322+2,422+2);
horse_normal_pad(2:322+1,2:422+1)=horse_normal_c1;
horse_inv_normal = 1-horse_normal_pad;

figure()
imshow(horse_inv_normal) % t=128 
[check,a,b] = ccl(horse_inv_normal);
Checkunique = unique(check,'rows');

%
finala=cell(1,200);
newa = a;
testa = cell(1,200);
t=0;
while(t~=1)
for i = 1:200
    for j = 1:200
        isct = intersect(newa{1,i},newa{1,j});
        if isct ~= 0 
                u = union(newa{1,i},newa{1,j});
                lenu = length(u);
                for p = 1:lenu
                    testa{1,u(p)} = union(u, testa{1,u(p)});
                end
        end
    end
end

if isequal(testa,newa)
    t=1;
else
    newa = testa;
end
end
% set new label for the same region
newsamelabel = zeros(1,143);
for i = 1:143
    if isempty(testa{1,i})
        testa{1,i}=0;
    end
    newsamelabel(1,i) = min(testa{1,i});
end
% 
% hist_label = zeros(1,143);
% for i = 1:143
%     if newsamelabel(1,i) ~= 0
%         hist_label(1,newsamelabel(1,i)) = hist_label(1,newsamelabel(1,i))+1;
%     end
% end
nubmer_of_defect = unique(newsamelabel);
% figure()
% bar(hist_label)
height_b = length(b(:,1));
width_b = length(b(1,:));
region = zeros(height_b,width_b);
histo_region_size = zeros(1,143);
for i = 1:height_b
    for j = 1:width_b
        if b(i,j) ~= 0
            temp = b(i,j);
            region(i,j) = newsamelabel(1,temp);
            if region(i,j) ~= 1
                histo_region_size(1,region(i,j)) = histo_region_size(1,region(i,j))+1;
            end
        end
    end
end
%%
figure()
bar(histo_region_size)
title('size of each defect');
xlabel('label');
ylabel('pixel number');
%W43 = writeraw(histo_region_size, 'Figure 43: histo_region_size.raw',length(histo_region_size(1,:)),length(histo_region_size(:,1)),1);

len_hist = length(histo_region_size);
hist_frequency_4 = zeros(1,max(histo_region_size));
for i = 1:len_hist
    if histo_region_size(1,i) ~= 0
        hist_frequency_4(1,histo_region_size(1,i)) =  hist_frequency_4(1,histo_region_size(1,i))+1;
    end
end
figure()
bar(hist_frequency_4)
title('frequency of the defects for differet size');
xlabel('size');
ylabel('frequency');
%W44 = writeraw(hist_frequency_4, 'Figure 44: hist_frequency_4.raw',length(hist_frequency_4(1,:)),length(hist_frequency_4(:,1)),1);
