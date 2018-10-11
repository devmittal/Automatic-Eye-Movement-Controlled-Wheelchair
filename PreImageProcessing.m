function [I2, x] = Untitled(vid, faceDetector)
%Pre-processing of Image
I = getsnapshot(vid);
I = rgb2gray(I);
I = imadjust(I);
I = adapthisteq(I);
bboxes = step(faceDetector, I);
m = length(bboxes(:,4));
I1 = imcrop(I,bboxes(m,:));
I2 = I1(:,1:floor(end/2.3));
I2 = I2(:,23:end-25);
figure;
imshow(I2)
pks = findpeaks(mean(I2,2), 1:size(I2,1),'MinPeakProminence',5);
x = numel(pks);
end

