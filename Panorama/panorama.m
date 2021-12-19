left = readraw('left.raw', 322, 483, 3);
middle = readraw('middle.raw', 325, 487, 3);
right = readraw('right_updated.raw', 325, 489, 3);
% figure();
% imshow(left/255);
% figure();
% imshow(middle/255);
% figure();
% imshow(right/255);

%%% get features
left_gray = convert_to_gray(left/255,322,483);
% figure();
% imshow(left_gray);
point_left = detectSURFFeatures(left_gray);
[feature_left, point_left] = extractFeatures(left_gray, point_left);

middle_gray = convert_to_gray(middle/255,325,487);
% figure();
% imshow(middle_gray);
point_middle = detectSURFFeatures(middle_gray);
[feature_middle, point_middle] = extractFeatures(middle_gray, point_middle);

right_gray = convert_to_gray(right/255,325,489);
% figure();
% imshow(right_gray);
point_right = detectSURFFeatures(right_gray);
[feature_right, point_right] = extractFeatures(right_gray, point_right);

%%% match features
indexPairs_LM = matchFeatures(feature_left, feature_middle, 'Unique', true);
indexPairs_MR = matchFeatures(feature_middle, feature_right, 'Unique', true);

matchedPoints_left  = point_left(indexPairs_LM(:,1),:);
matchedPoints_middleleft = point_middle(indexPairs_LM(:,2),:);
matchedPoints_middleright = point_middle(indexPairs_MR(:,1),:);
matchedPoints_right  = point_right(indexPairs_MR(:,2),:);

figure(); 
showMatchedFeatures(left/255, middle/255, matchedPoints_left, matchedPoints_middleleft);

figure(); 
showMatchedFeatures(middle/255, right/255, matchedPoints_middleright, matchedPoints_right);

expand = 400;
createcanvas = canvas(left/255,middle/255,right/255,expand);
figure;
imshow(createcanvas);
% W7 = writeraw(createcanvas, 'Figure 7: createcanvas.raw', length(createcanvas(1,:,1)),length(createcanvas(:,1,1)),3);

%%%
chosedpoints_l = [4,17,19,26];
chosedpoints_r = [7,10,20,25];

allleftpoint_index = zeros(27,2);
allmidleftpoint_index = zeros(27,2);
allmidrightpoint_index =zeros(30,2);
allrightpoint_index = zeros(30,2);

chosed_leftpoint_cartesian = zeros(4,2);
chosed_midleftpoint_cartesian = zeros(4,2);
chosed_midrightpoint_cartesian = zeros(4,2);
chosed_rightpoint_cartesian = zeros(4,2);


for i = 1:27
    allmidleftpoint_index(i,:) = matchedPoints_middleleft(i).Location;
    allleftpoint_index(i,:) = matchedPoints_left(i).Location;
end

for i = 1:30
    allmidrightpoint_index(i,:) = matchedPoints_middleright(i).Location;
    allrightpoint_index(i,:) = matchedPoints_right(i).Location;
end

for i = 1:4
    chosed_midleftpoint_cartesian(i,:) = allmidleftpoint_index(chosedpoints_l(i),:);
    chosed_leftpoint_cartesian(i,:) = allleftpoint_index(chosedpoints_l(i),:);
    chosed_midrightpoint_cartesian(i,:) = allmidrightpoint_index(chosedpoints_r(i),:);
    chosed_rightpoint_cartesian(i,:) = allrightpoint_index(chosedpoints_r(i),:);
end

%%% convert to cartesian coordinate
chosed_leftpoint_cartesian(:,1) = chosed_leftpoint_cartesian(:,1) +expand;%coloum
chosed_leftpoint_cartesian(:,2) = chosed_leftpoint_cartesian(:,2) +expand;
chosed_midleftpoint_cartesian(:,1) = chosed_midleftpoint_cartesian(:,1)+322+expand;
chosed_midleftpoint_cartesian(:,2) = chosed_midleftpoint_cartesian(:,2)+expand;
chosed_midrightpoint_cartesian(:,1) = chosed_midrightpoint_cartesian(:,1)+322+expand;
chosed_midrightpoint_cartesian(:,2) = chosed_midrightpoint_cartesian(:,2)+expand;
chosed_rightpoint_cartesian(:,1) = chosed_rightpoint_cartesian(:,1)+647+expand;
chosed_rightpoint_cartesian(:,2) = chosed_rightpoint_cartesian(:,2)+expand;

syms h11 h12 h13 h21 h22 h23 h31 h32
eqns = [
    chosed_leftpoint_cartesian(1,2)*h11+chosed_leftpoint_cartesian(1,1)*h12+h13==chosed_midleftpoint_cartesian(1,2)*(chosed_leftpoint_cartesian(1,2)*h31+chosed_leftpoint_cartesian(1,1)*h32+1),
    chosed_leftpoint_cartesian(1,2)*h21+chosed_leftpoint_cartesian(1,1)*h22+h23==(chosed_midleftpoint_cartesian(1,1))*(chosed_leftpoint_cartesian(1,2)*h31+chosed_leftpoint_cartesian(1,1)*h32+1),
    chosed_leftpoint_cartesian(2,2)*h11+chosed_leftpoint_cartesian(2,1)*h12+h13==chosed_midleftpoint_cartesian(2,2)*(chosed_leftpoint_cartesian(2,2)*h31+chosed_leftpoint_cartesian(2,1)*h32+1),
    chosed_leftpoint_cartesian(2,2)*h21+chosed_leftpoint_cartesian(2,1)*h22+h23==(chosed_midleftpoint_cartesian(2,1))*(chosed_leftpoint_cartesian(2,2)*h31+chosed_leftpoint_cartesian(2,1)*h32+1),
    chosed_leftpoint_cartesian(3,2)*h11+chosed_leftpoint_cartesian(3,1)*h12+h13==chosed_midleftpoint_cartesian(3,2)*(chosed_leftpoint_cartesian(3,2)*h31+chosed_leftpoint_cartesian(3,1)*h32+1),
    chosed_leftpoint_cartesian(3,2)*h21+chosed_leftpoint_cartesian(3,1)*h22+h23==(chosed_midleftpoint_cartesian(3,1))*(chosed_leftpoint_cartesian(3,2)*h31+chosed_leftpoint_cartesian(3,1)*h32+1),
    chosed_leftpoint_cartesian(4,2)*h11+chosed_leftpoint_cartesian(4,1)*h12+h13==chosed_midleftpoint_cartesian(4,2)*(chosed_leftpoint_cartesian(4,2)*h31+chosed_leftpoint_cartesian(4,1)*h32+1),
    chosed_leftpoint_cartesian(4,2)*h21+chosed_leftpoint_cartesian(4,1)*h22+h23==(chosed_midleftpoint_cartesian(4,1))*(chosed_leftpoint_cartesian(4,2)*h31+chosed_leftpoint_cartesian(4,1)*h32+1)
    ];
S = solve(eqns,[h11 h12 h13 h21 h22 h23 h31 h32]);
H = ones(3,3);
H(1,1) = double(S.h11);
H(1,2) = double(S.h12);
H(1,3) = double(S.h13);
H(2,1) = double(S.h21);
H(2,2) = double(S.h22);
H(2,3) = double(S.h23);
H(3,1) = double(S.h31);
H(3,2) = double(S.h32);

H_r = ones(3,3);
eqns = [
    chosed_rightpoint_cartesian(1,2)*h11+chosed_rightpoint_cartesian(1,1)*h12+h13==chosed_midrightpoint_cartesian(1,2)*(chosed_rightpoint_cartesian(1,2)*h31+chosed_rightpoint_cartesian(1,1)*h32+1),
    chosed_rightpoint_cartesian(1,2)*h21+chosed_rightpoint_cartesian(1,1)*h22+h23==(chosed_midrightpoint_cartesian(1,1))*(chosed_rightpoint_cartesian(1,2)*h31+chosed_rightpoint_cartesian(1,1)*h32+1),
    chosed_rightpoint_cartesian(2,2)*h11+chosed_rightpoint_cartesian(2,1)*h12+h13==chosed_midrightpoint_cartesian(2,2)*(chosed_rightpoint_cartesian(2,2)*h31+chosed_rightpoint_cartesian(2,1)*h32+1),
    chosed_rightpoint_cartesian(2,2)*h21+chosed_rightpoint_cartesian(2,1)*h22+h23==(chosed_midrightpoint_cartesian(2,1))*(chosed_rightpoint_cartesian(2,2)*h31+chosed_rightpoint_cartesian(2,1)*h32+1),
    chosed_rightpoint_cartesian(3,2)*h11+chosed_rightpoint_cartesian(3,1)*h12+h13==chosed_midrightpoint_cartesian(3,2)*(chosed_rightpoint_cartesian(3,2)*h31+chosed_rightpoint_cartesian(3,1)*h32+1),
    chosed_rightpoint_cartesian(3,2)*h21+chosed_rightpoint_cartesian(3,1)*h22+h23==(chosed_midrightpoint_cartesian(3,1))*(chosed_rightpoint_cartesian(3,2)*h31+chosed_rightpoint_cartesian(3,1)*h32+1),
    chosed_rightpoint_cartesian(4,2)*h11+chosed_rightpoint_cartesian(4,1)*h12+h13==chosed_midrightpoint_cartesian(4,2)*(chosed_rightpoint_cartesian(4,2)*h31+chosed_rightpoint_cartesian(4,1)*h32+1),
    chosed_rightpoint_cartesian(4,2)*h21+chosed_rightpoint_cartesian(4,1)*h22+h23==(chosed_midrightpoint_cartesian(4,1))*(chosed_rightpoint_cartesian(4,2)*h31+chosed_rightpoint_cartesian(4,1)*h32+1)
    ];

S = solve(eqns,[h11 h12 h13 h21 h22 h23 h31 h32]);
H_r(1,1) = double(S.h11);
H_r(1,2) = double(S.h12);
H_r(1,3) = double(S.h13);
H_r(2,1) = double(S.h21);
H_r(2,2) = double(S.h22);
H_r(2,3) = double(S.h23);
H_r(3,1) = double(S.h31);
H_r(3,2) = double(S.h32);

% create panorama
panorama=Panorama(createcanvas,H,H_r,expand);
figure;
imshow(panorama);
% W8 = writeraw(panorama.*255, 'Figure 8: panorama.raw', length(panorama(1,:,1)),length(panorama(:,1,1)),3);
