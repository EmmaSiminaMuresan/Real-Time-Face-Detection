%% Real-time face detection
%% Mouth
clc; close all;
web = webcam();   % Initialize the webcam
im = snapshot(web);  % Capture a snapshot from the webcam
dete = vision.CascadeObjectDetector('Mouth', 'MergeThreshold', 300);  
% Create a mouth detector object with a high threshold (less false positives)

h = figure; 
imshow(im);  % Display the initial image

while true
    if ~isvalid(h)  % Check if the figure window is still open
        break;  % If closed, exit the loop
    end
    
    im = snapshot(web);  % Capture new frame
    im2 = rgb2gray(im);  % Convert the image to grayscale (required for detection)
    bbox = step(dete, im2);  % Perform mouth detection; returns bounding box coordinates
    
    pic = insertObjectAnnotation(im, 'rectangle', bbox, 'Mouth');  
    % Annotate the detected mouth on the image
    
    imshow(pic);  % Display the annotated image
end

clear('web');  % Release the webcam when done



%% Nose
clc;close all;
web = webcam();
im = snapshot(web);
dete = vision.CascadeObjectDetector('Nose', 'MergeThreshold', 100);
h = figure;
imshow(im);

while true
    if ~isvalid(h) 
        break; 
    end
    im = snapshot(web);
    im2 = rgb2gray(im);
    bbox = step(dete, im2);
    pic = insertObjectAnnotation(im, 'rectangle', bbox, 'Nose');
    imshow(pic);
end

%% Left eye
clc;close all;
web = webcam();
h = figure;
im = snapshot(web);
dete = vision.CascadeObjectDetector('LeftEye', 'MergeThreshold', 400);
imshow(im);

while true
    if ~isvalid(h) 
        break; 
    end
    im = snapshot(web);
    im2 = rgb2gray(im);
    bbox = step(dete, im2);
    pic = insertObjectAnnotation(im, 'rectangle', bbox, 'LeftEye');
    imshow(pic);
end

%% Right eye
clc;close all;
web = webcam();
h = figure;
im = snapshot(web);
dete = vision.CascadeObjectDetector('RightEye', 'MergeThreshold', 280);
imshow(im);

while true
    if ~isvalid(h) 
        break; 
    end
    im = snapshot(web);
    im2 = rgb2gray(im);
    bbox = step(dete, im2);
    pic = insertObjectAnnotation(im, 'rectangle', bbox, 'RightEye');
    imshow(pic);
end


%% Real-time face detection: Combined Mouth, Nose, Left Eye, Right Eye
clc; close all;
web = webcam();
h = figure; 

% Detectors for each part of the face
mouthDetector = vision.CascadeObjectDetector('Mouth', 'MergeThreshold', 300);
noseDetector = vision.CascadeObjectDetector('Nose', 'MergeThreshold', 100);
leftEyeDetector = vision.CascadeObjectDetector('LeftEye', 'MergeThreshold', 400);
rightEyeDetector = vision.CascadeObjectDetector('RightEye', 'MergeThreshold', 280);

while true
    if ~isvalid(h) 
        break;
    end
    
    % Capture image from webcam
    im = snapshot(web);
    im2 = rgb2gray(im);
    
    % Detect each face part
    mouthBbox = step(mouthDetector, im2);
    noseBbox = step(noseDetector, im2);
    leftEyeBbox = step(leftEyeDetector, im2);
    rightEyeBbox = step(rightEyeDetector, im2);
    
    % Annotate the detected parts
    pic = im;  % Start with the original image
    
    if ~isempty(mouthBbox)
        pic = insertObjectAnnotation(pic, 'rectangle', mouthBbox, 'Mouth');
    end
    if ~isempty(noseBbox)
        pic = insertObjectAnnotation(pic, 'rectangle', noseBbox, 'Nose');
    end
    if ~isempty(leftEyeBbox)
        pic = insertObjectAnnotation(pic, 'rectangle', leftEyeBbox, 'Left Eye');
    end
    if ~isempty(rightEyeBbox)
        pic = insertObjectAnnotation(pic, 'rectangle', rightEyeBbox, 'Right Eye');
    end
    
    % Display the annotated image
    imshow(pic);
end

clear('web'); % Clear the webcam object
