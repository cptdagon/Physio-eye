%% Track a Face in Scene
%
%% 
% Create System objects for reading and displaying video and for drawing a bounding box of the object. 
videoFileReader = vision.VideoFileReader('20180426_103250.mp4');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
%% 
% Read the first video frame, which contains the object, define the region.
objectFrame = step(videoFileReader);
%objectRegion = [264,122,93,93];
%% 
% As an alternative, you can use the following commands to select the object region using a mouse. The object must occupy the majority of the region. 
 figure; imshow(objectFrame);
 objectRegion=round(getPosition(imrect))
%% 
% Show initial frame with a red bounding box.
objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red'); 
figure;
imshow(objectImage);
title('Red box shows object region');
%% 
% Detect interest points in the object region.
points = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
%% 
% Display the detected points.
pointImage = insertMarker(objectFrame,points.Location,'+','Color','white');
figure;
imshow(pointImage);
title('Detected interest points');
%% 
% Create a tracker object.
tracker = vision.PointTracker('MaxBidirectionalError',2);
%% 
% Initialize the tracker.
initialize(tracker,points.Location,objectFrame);
%% 
% Read, track, display points, and results in each video frame.
while ~isDone(videoFileReader)
      frame = step(videoFileReader);
      [points, validity] = step(tracker,frame);
      x = min(points);
      y = max(points);
      hw = y - x;
      objectregion = [x,hw];
%       out = insertMarker(frame,points(validity, :),'+');
      out = insertShape(frame,'Rectangle',objectregion,'Color','red'); 
      step(videoPlayer,out);
end
%% 
% Release the video reader and player.
release(videoPlayer);
release(videoFileReader);
