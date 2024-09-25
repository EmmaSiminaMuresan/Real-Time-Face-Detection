# Real-Time Face Detection

This project demonstrates real-time face and facial feature detection using a webcam. The program utilizes MATLAB's `vision.CascadeObjectDetector` to detect and annotate key facial features such as the mouth, nose, left eye, and right eye.

## Features

The project is divided into several modules, each focusing on detecting and displaying different facial features in real time:

- **Mouth Detection**: Detects and annotates the mouth in the video feed.
- **Nose Detection**: Detects and annotates the nose in the video feed.
- **Left Eye Detection**: Detects and annotates the left eye in the video feed.
- **Right Eye Detection**: Detects and annotates the right eye in the video feed.
- **Combined Detection**: Simultaneously detects and annotates the mouth, nose, left eye, and right eye in real time.

## How It Works

The project uses the webcam to continuously capture frames in real time. Each module utilizes a specific object detector with appropriate threshold settings for feature detection. The detected features are annotated in the captured frames and displayed on the screen. The program will keep detecting and updating the display until the user closes the window.

## Dependencies

Ensure you have the following installed:

- MATLAB
- Image Processing Toolbox
- Computer Vision Toolbox

These libraries are necessary for webcam input and facial feature detection.

## Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/real-time-facial-feature-detection.git

2. Open MATLAB.

3. Run the desired script for detecting specific facial features, or run the combined script for detecting all features at once.

- For Mouth Detection:

   ```bash
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

- For Nose Detection:

  ```bash
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

- For Left Eye Detection:

  ```bash
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

- For Right Eye Detection:

  ```bash
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

- For Combined Detection (Mouth, Nose, Left Eye, Right Eye):

  ```bash 
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

## Customization
You can tweak the `MergeThreshold` for each detector to adjust sensitivity and reduce false positives:

  ```matlab
  dete = vision.CascadeObjectDetector('Feature', 'MergeThreshold', <value>);

