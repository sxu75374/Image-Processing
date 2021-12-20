% filterbank
kernel = [1 4 6 4 1; -1 -2 0 2 1; -1 0 2 0 -1; -1 2 0 -2 1; 1 -4 6 -4 1];

filterbank = zeros(5,5,25);
count = 1;
for i = 1:5
    for j = 1:5
        filterbank(:,:,count) = kernel(i,:)'*kernel(j,:);
        count = count+1;
    end
end

% load training data
load_training_image_blanket = zeros(128,128,9);
load_training_image_brick = zeros(128,128,9);
load_training_image_grass = zeros(128,128,9);
load_training_image_rice = zeros(128,128,9);
all_training_image = zeros(128,128,36);
for i = 1:9
name1 = ['blanket',num2str(i),'.raw'];
name2 = ['brick',num2str(i),'.raw'];
name3 = ['grass',num2str(i),'.raw'];
name4 = ['rice',num2str(i),'.raw'];
load_training_image_blanket(:,:,i) = readraw(name1,128,128,1);
load_training_image_brick(:,:,i) = readraw(name2,128,128,1);
load_training_image_grass(:,:,i) = readraw(name3,128,128,1);
load_training_image_rice(:,:,i) = readraw(name4,128,128,1);
end
all_training_image(:,:,1:9) = load_training_image_blanket;
all_training_image(:,:,10:18) = load_training_image_brick;
all_training_image(:,:,19:27) = load_training_image_grass;
all_training_image(:,:,28:36) = load_training_image_rice;

% subtract image mean for all 36 training images
all_training_image_submean = zeros(128,128,36);
for i = 1:36
    all_training_image_submean(:,:,i) = all_training_image(:,:,i)-mean(mean(all_training_image(:,:,i)));
end

% filter 36 images by 25 filters, to get a feature set (36*25 matrix)
all_feature_vector = zeros(36,25);
size = 128*128;
count = 1;
for i = 1:5
    for j = 1:5
        for k = 1:36
            pad = padding(all_training_image_submean(:,:,k),5);
            a = convolute(pad,filterbank(:,:,count));
            % average energy in response image
            a = a.^2;
            all_feature_vector(k,count) = sum(a(:))/size;
        end
        count = count+1;
    end
end

% disrimiant power of each feature dimension
%% y..
overall_average = zeros(1,25);
for i = 1:25
    overall_average(1,i) = sum(all_feature_vector(:,i))/36;
end
%% yi.
average_within_class = zeros(4,25);
for j = 1:25
    average_within_class(1,j) = sum(all_feature_vector(1:9,j))/9;
    average_within_class(2,j) = sum(all_feature_vector(10:18,j))/9;
    average_within_class(3,j) = sum(all_feature_vector(19:27,j))/9;
    average_within_class(4,j) = sum(all_feature_vector(28:36,j))/9;
end
%% intra variety
intra_class = zeros(4,25);
for j = 1:25
    temp = 0;
    for i = 1:9
        temp = temp + (all_feature_vector(i,j)-average_within_class(1,j))^2;
    end
    intra_class(1,j) = temp;
end
for j = 1:25
    temp = 0;
    for i = 10:18
        temp = temp + (all_feature_vector(i,j)-average_within_class(2,j))^2;
    end
    intra_class(2,j) = temp;
end
for j = 1:25
    temp = 0;
    for i = 19:27
        temp = temp + (all_feature_vector(i,j)-average_within_class(3,j))^2;
    end
    intra_class(3,j) = temp;
end
for j = 1:25
    temp = 0;
    for i = 28:36
        temp = temp + (all_feature_vector(i,j)-average_within_class(4,j))^2;
    end
    intra_class(4,j) = temp;
end
intra_class_final = intra_class(1,:)+intra_class(2,:)+intra_class(3,:)+intra_class(4,:);
%% inter variety
inter_class = zeros(4,25);
for i = 1:25
    inter_class(1,i) = 9*(average_within_class(1,i)-overall_average(1,i))^2;
end
for i = 1:25
    inter_class(2,i) = 9*(average_within_class(2,i)-overall_average(1,i))^2;
end
for i = 1:25
    inter_class(3,i) = 9*(average_within_class(3,i)-overall_average(1,i))^2;
end
for i = 1:25
    inter_class(4,i) = 9*(average_within_class(4,i)-overall_average(1,i))^2;
end
inter_class_final = inter_class(1,:)+inter_class(2,:)+inter_class(3,:)+inter_class(4,:);
%% discriminant power
discriminant_power = zeros(4,25);
discriminant_power(1,:) = intra_class(1,:)./inter_class(1,:);
discriminant_power(2,:) = intra_class(2,:)./inter_class(2,:);
discriminant_power(3,:) = intra_class(3,:)./inter_class(3,:);
discriminant_power(4,:) = intra_class(4,:)./inter_class(4,:);
discriminant_power_final = intra_class_final./inter_class_final;
%% pca
pca_result = pca(all_feature_vector,'NumComponents',3);
% mean(all_feature_vector)
pca_train = (all_feature_vector-mean(all_feature_vector))*pca_result;
%% scatter image of different classes 
% figure()
% scatter3(pca_test(:,1),pca_test(:,2),pca_test(:,3),'k');
figure()
a1 = scatter3(pca_train(1:9,1),pca_train(1:9,2),pca_train(1:9,3),'r');
hold on
a2 = scatter3(pca_train(10:18,1),pca_train(10:18,2),pca_train(10:18,3),'k');
hold on
a3 = scatter3(pca_train(19:27,1),pca_train(19:27,2),pca_train(19:27,3),'b');
hold on
a4 = scatter3(pca_train(28:36,1),pca_train(28:36,2),pca_train(28:36,3),'m');
legend([a1(1),a2(1),a3(1),a4(1)],'blanket','brick','grass','rice')

%% test image
% load test image
all_testing_data = zeros(128,128,12);
for i = 1:12
    name = [num2str(i),'.raw'];
    all_testing_data(:,:,i) = readraw(name,128,128,1);
end

%% subtract image mean for all 12 test images
all_testing_image_submean = zeros(128,128,12);
for i = 1:12
    all_testing_image_submean(:,:,i) = all_testing_data(:,:,i)-mean(mean(all_testing_data(:,:,i)));
end

%% filter 12 images by 25 filters, to get a test feature set (12*25 matrix)
test_all_feature_vector = zeros(12,25);
size = 128*128;
count = 1;
for i = 1:5
    for j = 1:5
        for k = 1:12
%             filter = zeros(5,5);
%             filter(:,:) = filterbank(:,:,count);
            pad = padding(all_testing_image_submean(:,:,k),5);
            a = convolute(pad,filterbank(:,:,count));
            % average energy in response image
            a = a.^2;
            test_all_feature_vector(k,count) = sum(a(:))/size;
        end
        count = count+1;
    end
end
%test_all_feature_vector = test_all_feature_vector./test_all_feature_vector(:,1);
%% test pca
% pca_result_test = pca(test_all_feature_vector,'NumComponents',3);
pca_test = (test_all_feature_vector-mean(all_feature_vector))*pca_result;
figure()
scatter3(pca_test(:,1),pca_test(:,2),pca_test(:,3),'r');
%% classification by Mahalanobis distance
x_u1 = zeros(12,3);
for i = 1:12
    x_u1(i,:) = pca_test(i,:) - mean(pca_train(1:9,:));
end
x_u2 = zeros(12,3);
for i = 1:12
    x_u2(i,:) = pca_test(i,:) - mean(pca_train(10:18,:));
end
x_u3 = zeros(12,3);
for i = 1:12
    x_u3(i,:) = pca_test(i,:) - mean(pca_train(19:27,:));
end
x_u4 = zeros(12,3);
for i = 1:12
    x_u4(i,:) = pca_test(i,:) - mean(pca_train(28:36,:));
end

% train
x_u1_t= zeros(36,3);
for i = 1:36
    x_u1_t(i,:) = pca_train(i,:) - mean(pca_train(1:9,:));
end
x_u2_t = zeros(36,3);
for i = 1:36
    x_u2_t(i,:) = pca_train(i,:) - mean(pca_train(10:18,:));
end
x_u3_t = zeros(12,3);
for i = 1:36
    x_u3_t(i,:) = pca_train(i,:) - mean(pca_train(19:27,:));
end
x_u4_t = zeros(12,3);
for i = 1:36
    x_u4_t(i,:) = pca_train(i,:) - mean(pca_train(28:36,:));
end


%% covariance
%class 1
% cov12 = sum((pca_train(1:9,1) - mean(pca_train(1:9,1))).*(pca_train(1:9,2) - mean(pca_train(1:9,2))))/8;
% cov23 = sum((pca_train(1:9,2) - mean(pca_train(1:9,2))).*(pca_train(1:9,3) - mean(pca_train(1:9,3))))/8;
% cov13 = sum((pca_train(1:9,1) - mean(pca_train(1:9,1))).*(pca_train(1:9,3) - mean(pca_train(1:9,3))))/8;
% var1 = std(pca_train(1:9,1))^2;
% var2 = std(pca_train(1:9,2))^2;
% var3 = std(pca_train(1:9,3))^2;
S1 = cov(pca_train(1:9,:));
%class 2
% cov12 = sum((pca_result(10:18,1) - mean(pca_result(10:18,1))).*(pca_result(10:18,2) - mean(pca_result(10:18,2))))/8;
% cov23 = sum((pca_result(10:18,2) - mean(pca_result(10:18,2))).*(pca_result(10:18,3) - mean(pca_result(10:18,3))))/8;
% cov13 = sum((pca_result(10:18,1) - mean(pca_result(10:18,1))).*(pca_result(10:18,3) - mean(pca_result(10:18,3))))/8;
% var1 = std(pca_result(10:18,1))^2;
% var2 = std(pca_result(10:18,2))^2;
% var3 = std(pca_result(10:18,3))^2;
S2 = cov(pca_train(10:18,:));
%class 3
% cov12 = sum((pca_result(19:27,1) - mean(pca_result(19:27,1))).*(pca_result(19:27,2) - mean(pca_result(19:27,2))))/8;
% cov23 = sum((pca_result(19:27,2) - mean(pca_result(19:27,2))).*(pca_result(19:27,3) - mean(pca_result(19:27,3))))/8;
% cov13 = sum((pca_result(19:27,1) - mean(pca_result(19:27,1))).*(pca_result(19:27,3) - mean(pca_result(19:27,3))))/8;
% var1 = std(pca_result(19:27,1))^2;
% var2 = std(pca_result(19:27,2))^2;
% var3 = std(pca_result(19:27,3))^2;
S3 = cov(pca_train(19:27,:));
%class 4
% cov12 = sum((pca_result(28:36,1) - mean(pca_result(28:36,1))).*(pca_result(28:36,2) - mean(pca_result(28:36,2))))/8;
% cov23 = sum((pca_result(28:36,2) - mean(pca_result(28:36,2))).*(pca_result(28:36,3) - mean(pca_result(28:36,3))))/8;
% cov13 = sum((pca_result(28:36,1) - mean(pca_result(28:36,1))).*(pca_result(28:36,3) - mean(pca_result(28:36,3))))/8;
% var1 = std(pca_result(28:36,1))^2;
% var2 = std(pca_result(28:36,2))^2;
% var3 = std(pca_result(28:36,3))^2;
S4 = cov(pca_train(28:36,:));

% dist
Dm = zeros(12,4);
for i = 1:12
    Dm(i,1) = sqrt((x_u1(i,:))*(S1^-1)*(x_u1(i,:))');
    Dm(i,2) = sqrt((x_u2(i,:))*(S2^-1)*(x_u2(i,:))');
    Dm(i,3) = sqrt((x_u3(i,:))*(S3^-1)*(x_u3(i,:))');
    Dm(i,4) = sqrt((x_u4(i,:))*(S4^-1)*(x_u4(i,:))');
end
predict_NearestDist = zeros(12,1);
[minvalue_ND,index]=min(Dm,[],2);
predict_NearestDist(:,1) = index-1;

% correct_test_label
correct_test_label = [2;0;0;1;3;2;1;3;3;1;0;2];

%error rate of Nearest Dist
error_rate_NearDist = errorRate(correct_test_label,predict_NearestDist);




% % train er
% 
% Dm_t = zeros(36,4);
% for i = 1:36
%     Dm_t(i,1) = sqrt((x_u1_t(i,:))*(S1^-1)*(x_u1_t(i,:))');
%     Dm_t(i,2) = sqrt((x_u2_t(i,:))*(S2^-1)*(x_u2_t(i,:))');
%     Dm_t(i,3) = sqrt((x_u3_t(i,:))*(S3^-1)*(x_u3_t(i,:))');
%     Dm_t(i,4) = sqrt((x_u4_t(i,:))*(S4^-1)*(x_u4_t(i,:))');
% end
% predict_NearestDist_t = zeros(36,1);
% [minvalue_ND_t,index_t]=min(Dm_t,[],2);
% predict_NearestDist_t(:,1) = index_t-1;

%% Classifier -- Unsupervised -- K-means
% K-means
% predict_Kmeans_train_25 = kmeans(all_feature_vector,4);
% predict_Kmeans_train_3 = kmeans(pca_train,4);
predict_Kmeans_test_25 = kmeans(test_all_feature_vector,4);
predict_Kmeans_test_3 = kmeans(pca_test,4);

% error rate for the K-means classification
error_rate_Kmeans_25 = errorRate(correct_test_label,predict_Kmeans_test_25);
error_rate_Kmeans_3 = errorRate(correct_test_label,predict_Kmeans_test_3);

%% Classifier -- Supervised -- RF
% label
train_label = zeros(36,1);
train_label(1:9,1) = 0;
train_label(10:18,1) = 1;
train_label(19:27,1) = 2;
train_label(28:36,1) = 3;
RF = TreeBagger(10,pca_train,train_label,'Method','classification');
predict_RF = predict(RF,pca_test);
predict_RF = str2num(cell2mat(predict_RF));

% error rate for the RF classification
error_rate_RF = errorRate(correct_test_label,predict_RF);



%% Classifier -- Supervised -- SVM
% train

train_label_svm = zeros(36,4);
train_label_svm(1:9,1) = 1;
train_label_svm(10:18,2) = 1;
train_label_svm(19:27,3) = 1;
train_label_svm(28:36,4) = 1;

clas0_blanket = fitcsvm(pca_train,train_label_svm(:,1),'Standardize',true,'KernelFunction','RBF');
clas1_brick = fitcsvm(pca_train,train_label_svm(:,2),'Standardize',true,'KernelFunction','RBF');
clas2_grass = fitcsvm(pca_train,train_label_svm(:,3),'Standardize',true,'KernelFunction','RBF');
clas3_rice = fitcsvm(pca_train,train_label_svm(:,4),'Standardize',true,'KernelFunction','RBF');

% predict
[l1,s1] = predict(clas0_blanket,pca_test);
[l2,s2] = predict(clas1_brick,pca_test);
[l3,s3] = predict(clas2_grass,pca_test);
[l4,s4] = predict(clas3_rice,pca_test);

score_all = zeros(12,4);
score_all(:,1) = s1(:,1);
score_all(:,2) = s2(:,1);
score_all(:,3) = s3(:,1);
score_all(:,4) = s4(:,1);
[minvalue,index_min_svm]=min(score_all,[],2);
predict_SVM = index_min_svm-1;

% error rate for SVM
error_rate_SVM = errorRate(correct_test_label,predict_SVM);
