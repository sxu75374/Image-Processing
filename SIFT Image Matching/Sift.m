%% -------need to run the code one section by one section------
% load image 
dog1 = imread('Dog_1.png');
% figure()
% imshow(dog1)
dog3 = imread('Dog_3.png');

% figure()
% imshow(dog3)
figure()
imshow(cat(2, dog3, dog1))
% setup vlfeat
run('/Users/xs/Documents/MATLAB/EE569HW4/vlfeat-0.9.21/toolbox/vl_setup.m')

% change rgb image to gray image
dog1_gray = single(rgb2gray(dog1)) ;
dog3_gray = single(rgb2gray(dog3)) ;

% get sift keypoints and descriptors
[f_dog1_gray,d_dog1_gray] = vl_sift(dog1_gray) ; % f:feature, d: descriptors
[f_dog3_gray,d_dog3_gray] = vl_sift(dog3_gray);

% find largest scale keypoints in dog3
[maxvalue,maxindex] = max(f_dog3_gray(3,:));
d_largestscale = d_dog3_gray(:,maxindex);

% find nearest neighbor in dog1
kdtree = vl_kdtreebuild(single(d_dog1_gray), 'NumTrees', 4) ;
[knnindex, distance] = vl_kdtreequery(kdtree, single(d_dog1_gray), single(d_largestscale)) ;

% show the match
f_dog1_gray(1,:) = f_dog1_gray(1,:)+640;
h1 = vl_plotframe(f_dog3_gray(:,maxindex)) ;
% h11 = vl_plotsiftdescriptor(d_dog3_gray(:,maxindex),f_dog3_gray(:,maxindex)) ;
% h2 = vl_plotframe(f_dog3_gray(:,maxindex)) ;
h3 = vl_plotframe(f_dog1_gray(:,knnindex));
% h33 = vl_plotsiftdescriptor(d_dog1_gray(:,knnindex),f_dog1_gray(:,knnindex)) ;
set(h1,'color','r','linewidth',2) ;
% set(h11,'color','g','linewidth',2) ;
set(h3,'color','r','linewidth',2) ;
% set(h33,'color','g','linewidth',2) ;
%W4 = writeraw(, 'Figure 10: largest scale.raw', 575, 360, 1);

%%  matching points dog3 dog1
dog3 = imread('Dog_3.png');
dog1 = imread('Dog_1.png');
% figure()
% imshow(dog2)
figure();
% imshow(dog3)
imshow(cat(2, dog3, dog1));
dog3_gray = single(rgb2gray(dog3)) ;
dog1_gray = single(rgb2gray(dog1)) ;

% sift pairs between dog2 & dog3
[f_dog1_gray,d_dog1_gray] = vl_sift(dog1_gray) ; % f:frame, d: descriptors
[f_dog3_gray,d_dog3_gray] = vl_sift(dog3_gray) ;

[matches, scores] = vl_ubcmatch(d_dog1_gray, d_dog3_gray);
score_sorted = sort(scores, 'descend');
findindex = zeros(1,length(scores));
for i = 1:length(score_sorted)
    findindex(1,i) = find(scores==score_sorted(1,i));
end
f_dog1_gray(1,matches(1,findindex(1,1:10))) = f_dog1_gray(1,matches(1,findindex(1,1:10)))+640;
x_dog1 = f_dog1_gray(1,matches(1,findindex(1,1:10)));
y_dog1 = f_dog1_gray(2,matches(1,findindex(1,1:10)));
h_x_dog1 = vl_plotframe(f_dog1_gray(:,matches(1,findindex(1,1:10))));
set(h_x_dog1,'color','r','linewidth',2) ;
x_dog3 = f_dog3_gray(1,matches(2,findindex(1,1:10)));
y_dog3 = f_dog3_gray(2,matches(2,findindex(1,1:10)));
h_x_dog3 = vl_plotframe(f_dog3_gray(:,matches(2,findindex(1,1:10))));
set(h_x_dog3,'color','r','linewidth',2) ;
l = line([x_dog3 ; x_dog1], [y_dog3 ; y_dog1]) ;
set(l,'linewidth', 1, 'color', 'y') ;


%%  matching points dog3 dog2
dog3 = imread('Dog_3.png');
dog2 = imread('Dog_2.png');
% figure()
% imshow(dog2)
figure();
% imshow(dog3)
imshow(cat(2, dog3, dog2));
dog3_gray = single(rgb2gray(dog3)) ;
dog2_gray = single(rgb2gray(dog2)) ;

% sift pairs between dog2 & dog3
[f_dog2_gray,d_dog2_gray] = vl_sift(dog2_gray) ; % f:frame, d: descriptors
[f_dog3_gray,d_dog3_gray] = vl_sift(dog3_gray) ;

[matches, scores] = vl_ubcmatch(d_dog2_gray, d_dog3_gray);
score_sorted = sort(scores, 'descend');
findindex = zeros(1,length(scores));
for i = 1:length(score_sorted)
    findindex(1,i) = find(scores==score_sorted(1,i));
end
f_dog2_gray(1,matches(1,findindex(1,1:10))) = f_dog2_gray(1,matches(1,findindex(1,1:10)))+640;
x_dog2 = f_dog2_gray(1,matches(1,findindex(1,1:10)));
y_dog2 = f_dog2_gray(2,matches(1,findindex(1,1:10)));
h_x_dog2 = vl_plotframe(f_dog2_gray(:,matches(1,findindex(1,1:10))));
set(h_x_dog2,'color','r','linewidth',2) ;
x_dog3 = f_dog3_gray(1,matches(2,findindex(1,1:10)));
y_dog3 = f_dog3_gray(2,matches(2,findindex(1,1:10)));
h_x_dog3 = vl_plotframe(f_dog3_gray(:,matches(2,findindex(1,1:10))));
set(h_x_dog3,'color','r','linewidth',2) ;
l = line([x_dog3 ; x_dog2], [y_dog3 ; y_dog2]) ;
set(l,'linewidth', 1, 'color', 'y') ;

%% matching points dog3 cat
dog3 = imread('Dog_3.png');
cat1 = imread('Cat.png');
figure();
imshow(cat(2, dog3, cat1));
dog3_gray = single(rgb2gray(dog3)) ;
cat1_gray = single(rgb2gray(cat1)) ;

% sift pairs between dog2 & dog3
[f_cat1_gray,d_cat1_gray] = vl_sift(cat1_gray) ; % f:frame, d: descriptors
[f_dog3_gray,d_dog3_gray] = vl_sift(dog3_gray) ;

[matches, scores] = vl_ubcmatch(d_cat1_gray, d_dog3_gray);
score_sorted = sort(scores, 'descend');
findindex = zeros(1,length(scores));
for i = 1:length(score_sorted)
    findindex(1,i) = find(scores==score_sorted(1,i));
end
f_cat1_gray(1,matches(1,findindex(1,1:10))) = f_cat1_gray(1,matches(1,findindex(1,1:10)))+640;
x_cat1 = f_cat1_gray(1,matches(1,findindex(1,1:10)));
y_cat1 = f_cat1_gray(2,matches(1,findindex(1,1:10)));
h_x_cat1 = vl_plotframe(f_cat1_gray(:,matches(1,findindex(1,1:10))));
set(h_x_cat1,'color','r','linewidth',2) ;
x_dog3 = f_dog3_gray(1,matches(2,findindex(1,1:10)));
y_dog3 = f_dog3_gray(2,matches(2,findindex(1,1:10)));
h_x_dog3 = vl_plotframe(f_dog3_gray(:,matches(2,findindex(1,1:10))));
set(h_x_dog3,'color','r','linewidth',2) ;
l2 = line([x_dog3 ; x_cat1], [y_dog3 ; y_cat1]) ;
set(l2,'linewidth', 1, 'color', 'y') ;


%% matching points dog1 cat
dog1 = imread('Dog_1.png');
cat1 = imread('Cat.png');
figure();
imshow(cat(2, dog1, cat1));
dog1_gray = single(rgb2gray(dog1)) ;
cat1_gray = single(rgb2gray(cat1)) ;

% sift pairs between dog2 & dog3
[f_cat1_gray,d_cat1_gray] = vl_sift(cat1_gray) ; % f:frame, d: descriptors
[f_dog1_gray,d_dog1_gray] = vl_sift(dog1_gray) ;

[matches, scores] = vl_ubcmatch(d_cat1_gray, d_dog1_gray);
score_sorted = sort(scores, 'descend');
findindex = zeros(1,length(scores));
for i = 1:length(score_sorted)
    findindex(1,i) = find(scores==score_sorted(1,i));
end
f_cat1_gray(1,matches(1,findindex(1,1:10))) = f_cat1_gray(1,matches(1,findindex(1,1:10)))+640;
x_cat1 = f_cat1_gray(1,matches(1,findindex(1,1:10)));
y_cat1 = f_cat1_gray(2,matches(1,findindex(1,1:10)));
h_x_cat1 = vl_plotframe(f_cat1_gray(:,matches(1,findindex(1,1:10))));
set(h_x_cat1,'color','r','linewidth',2) ;
x_dog1 = f_dog1_gray(1,matches(2,findindex(1,1:10)));
y_dog1 = f_dog1_gray(2,matches(2,findindex(1,1:10)));
h_x_dog1 = vl_plotframe(f_dog1_gray(:,matches(2,findindex(1,1:10))));
set(h_x_dog1,'color','r','linewidth',2) ;
l3 = line([x_dog1 ; x_cat1], [y_dog1 ; y_cat1]) ;
set(l3,'linewidth', 1, 'color', 'y') ;



%% bag of words
% extract sift features

% d_all = double([d_dog1_gray,d_dog2_gray,d_dog3_gray,d_cat1_gray])';
% coef = pca(d_all,'NumComponents',20);
% mean(d_all)
% d_pca20 = (d_all-mean(d_all))*coef;
% class = kmeans(d_pca20,8);

d_dog1_gray_d = double(d_dog1_gray');
d_dog2_gray_d = double(d_dog2_gray');
d_dog3_gray_d = double(d_dog3_gray');
d_cat1_gray_d = double(d_cat1_gray');

coef1 = pca(d_dog1_gray_d,'NumComponents',20);
coef2 = pca(d_dog2_gray_d,'NumComponents',20);
coef3 = pca(d_dog3_gray_d,'NumComponents',20);
coef4 = pca(d_cat1_gray_d,'NumComponents',20);

d1_pca20 = (d_dog1_gray_d)*coef1;
d2_pca20 = (d_dog2_gray_d)*coef2;
d3_pca20 = (d_dog3_gray_d)*coef3;
d4_pca20 = (d_cat1_gray_d)*coef4;

d_all_pca20 = [d1_pca20',d2_pca20',d3_pca20',d4_pca20']';
class = kmeans(d_all_pca20,8);

class_dog1 = class(1:length(d_dog1_gray(1,:)));
class_dog2 = class(1+length(class_dog1):length(d_dog2_gray(1,:))+length(class_dog1));
class_dog3 = class(1+length(class_dog1)+length(class_dog2):length(d_dog3_gray(1,:))+length(class_dog1)+length(class_dog2));
class_cat1 = class(1+length(class_dog1)+length(class_dog2)+length(class_dog3):end);

hist_dog1 = zeros(1,8);
for i = 1:length(class_dog1)
    hist_dog1(1,class_dog1(i,1)) = hist_dog1(1,class_dog1(i,1))+1;
end

figure('Name','dog1')
bar(hist_dog1)

hist_dog2 = zeros(1,8);
for i = 1:length(class_dog2)
    hist_dog2(1,class_dog2(i,1)) = hist_dog2(1,class_dog2(i,1))+1;
end

figure('Name','dog2')
bar(hist_dog2)

hist_dog3 = zeros(1,8);
for i = 1:length(class_dog3)
    hist_dog3(1,class_dog3(i,1)) = hist_dog3(1,class_dog3(i,1))+1;
end

figure('Name','dog3')
bar(hist_dog3)

hist_cat1 = zeros(1,8);
for i = 1:length(class_cat1)
    hist_cat1(1,class_cat1(i,1)) = hist_cat1(1,class_cat1(i,1))+1;
end

figure('Name','cat1')
bar(hist_cat1)

similarity_cat1_dog3 = similarity(hist_cat1,hist_dog3);
similarity_dog1_dog3 = similarity(hist_dog1,hist_dog3);
similarity_dog2_dog3 = similarity(hist_dog2,hist_dog3);

