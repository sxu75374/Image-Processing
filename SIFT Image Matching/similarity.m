function result = similarity(hist,hist_dog3)
minv = 0;
maxv = 0;
for i = 1:8
    minv = minv + min(hist(1,i),hist_dog3(1,i));
    maxv = maxv + max(hist(1,i),hist_dog3(1,i));
end
result = minv/maxv;
end