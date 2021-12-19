%% a shrink
spring = readraw('spring.raw',252,252,1);
flower = readraw('flower.raw',247,247,1);
jar = readraw('jar.raw',252,252,1);
% thre = 200 to get correct result, thre = 60 spring will connect 
spring_normal = normalize_p3a(spring);
flower_normal = normalize_p3a(flower);
jar_normal = normalize_p3a(jar);
% figure();
% imshow(spring_normal);
% figure();
% imshow(flower_normal);
% figure();
% imshow(jar_normal);
% shrink spring
[loop_of_shrink_spring,spring_s] = shrink(spring_normal);
figure();
imshow(spring_s)

% shrink flower
[loop_of_shrink_flower,flower_s] = shrink(flower_normal);
figure();
imshow(flower_s)
W12 = writeraw(flower_s, 'Figure 12: flower_s.raw',247,247,1);

% shrink jar
[loop_of_shrink_jar,jar_s] = shrink(jar_normal);
figure();
imshow(jar_s)
W15 = writeraw(jar_s, 'Figure 15: jar_s.raw',252,252,1);
