clc
clear all
close all
%Setting up Arduino connection
disp("Setting up Arduino Connection");
a = arduino();
%Initializing laptop webcamera
vid=videoinput('winvideo',1);
start(vid)
%initializing object for face detection
faceDetector = vision.CascadeObjectDetector('EyePairBig');
while(vid.FramesAcquired<=25)
[I2, x] = PreImageProcessing(vid, faceDetector);
obs = readDigitalPin(a,'D8');
obs1 = readDigitalPin(a,'D11');
if(x<2 || obs==1 || obs1==1)
    if(obs==1)
        disp('Obstacle on the right side');
    elseif(obs1==1)
        disp('Obstacle on the left side');
    else
        disp('Wheelchair is stationery');
    end
    writeDigitalPin(a,'D3',0);
     writeDigitalPin(a,'D5',0);
%         while(x<2)
%             [I2, x] = Untitled(vid, faceDetector);
%             disp("Wheelchair is stationary");
%         end
%         while(x>2 && obs==1)
%             [I2, x] = Untitled(vid, faceDetector);
%         end
else
I3 = imbinarize(I2,.1);
% figure;
% imshow(I3)
I3 = imcomplement(I3);
% figure;
% imshow(I3)
I3 = imfill(I3,'holes');
% figure;
% imshow(I3)
% SE = strel('disk',8,4);
% I4 = imerode(I3,SE);
I4 = bwareafilt(I3,1);
% figure;
% imshow(I4)
%I4 = I4(:,1:end-13);
%figure;
 %imshow(I4)
[rows, columns, numberOfColorChannels] = size(I4);
r3 = int32(rows/3);
c3 = int32(columns/3);
image1 = I4(1:r3, 1:c3);
image2 = I4(r3+1:2*r3, 1:c3);
image3 = I4(2*r3+1:end, 1:c3);
image4 = I4(1:r3, c3+5:2*c3);
image5 = I4(r3+1:2*r3, c3+5:2*c3);
image6 = I4(2*r3+1:end, c3+5:2*c3);
image7 = I4(1:r3, 2*c3+1:end);
image8 = I4(r3+1:2*r3, 2*c3+1:end);
image9 = I4(2*r3+1:end, 2*c3+1:end);
sum1 = sum(image1(:));
sum2 = sum(image2(:));
sum3 = sum(image3(:));
sum4 = sum(image4(:));
sum5 = sum(image5(:));
sum6 = sum(image6(:));
sum7 = sum(image7(:));
sum8 = sum(image8(:));
sum9 = sum(image9(:));
sum123 = sum1 + sum2 + sum3;
sum456 = sum4 + sum5 + sum6;
sum789 = sum7 + sum8 + sum9;
if(sum123>sum456 &&sum123>sum789)
    disp('Wheelchair starts moving Right');
    
writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D5',0);
   elseif(sum456>sum123 &&sum456>sum789)
        disp('Wheelchair starts moving straight');
      writeDigitalPin(a,'D3',1);
       writeDigitalPin(a,'D5',1);
    
    elseif(sum789>sum456 &&sum789>sum123)
        disp('Wheelchair starts moving left');
        
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D5',1);
end
end
end
