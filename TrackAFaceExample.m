%% Track a Face in Scene
%
%% 
% Create System objects for reading and displaying video and for drawing a bounding box of the object. 
mov = VideoReader('20180426_103250.mp4');
videoFileReader = vision.VideoFileReader('20180426_103250.mp4');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
numFrames = mov.NumberOfFrames;
frame_rate = mov.FrameRate;
disp(numFrames)
disp(frame_rate)
%% 
% Read the first video frame, which contains the object, define the region.
objectFrame = step(videoFileReader);
%objectRegion = [264,122,93,93];
%% 
% As an alternative, you can use the following commands to select the object region using a mouse. The object must occupy the majority of the region. 
 figure; imshow(objectFrame);
 objectRegion=round(getPosition(imrect));
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

red_mean = zeros(numFrames,1);
green_mean = zeros(numFrames,1);
blue_mean = zeros(numFrames,1);

for k=1:numFrames
    frame = step(videoFileReader);
    [points, validity] = step(tracker,frame);
    x = min(points);
    y = max(points);
    hw = y - x;
    objectregion = [x,hw];
    %       out = insertMarker(frame,points(validity, :),'+');
    out = insertShape(frame,'Rectangle',objectregion,'Color','red'); 
    step(videoPlayer,out);
    %%%
    x1=round(objectregion(1));
    y1=round(objectregion(2));
    x_step1=round(objectregion(3));
    y_step1=round(objectregion(4));
    x_stop1=x1+x_step1; y_stop1=y1+y_step1;
    
    red_ROI = frame(y1:y_stop1,x1:x_stop1,1);
    red_mean(k) = mean(red_ROI(:));
    
    green_ROI = frame(y1:y_stop1,x1:x_stop1,2);
    green_mean(k) = mean(green_ROI(:));
       
    blue_ROI = frame(y1:y_stop1,x1:x_stop1,3);
    blue_mean(k) = mean(blue_ROI(:));
    %%%
end
%% 
% Release the video reader and player.
%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'Raw PPG signals'); 
subplot(3,1,1)

plot(red_mean,'r');
title('Raw, red');

subplot(3,1,2)
plot(green_mean,'g');
title('Raw, green');

subplot(3,1,3)
plot(blue_mean,'b');
title('Raw, blue');

%% Filter raw signals
fc_lp = 4.0; % high cut-off
fc_hp = 0.5; % low cut-off
fs = frame_rate;

Wn = [fc_hp/(fs/2) fc_lp/(fs/2)]; % normalise with respect to Nyquist frequency

[b,a] = butter(5, Wn, 'bandpass'); 

green_filt = filtfilt(b,a,green_mean(:));
red_filt = filtfilt(b,a,red_mean(:));
blue_filt = filtfilt(b,a,blue_mean(:));

%% Plot filtered signals
figure('Name', 'Filtered PPG signals'); 

subplot(3,1,1);
plot(red_filt,'r');
title('Filtered, red');

subplot(3,1,2);
plot(green_filt,'g');
title('Filtered, green');

subplot(3,1,3);
plot(blue_filt,'b');
title('Filtered, blue');

%% Frequency analysis

%Perform FFT 
red_FFT = abs(fft(red_filt));
green_FFT = abs(fft(green_filt));
blue_FFT = abs(fft(blue_filt));

%Construct frequency axis
f_axis = (0:length(green_filt)-1)/vidLength;

%Plot frequency content
figure('Name','FFT of filtered signals'); 

subplot(3,1,1);
plot(f_axis, red_FFT,'r'); 
title('FFT of filtered signal, red');

subplot(3,1,2);
plot(f_axis, green_FFT,'g'); 
title('FFT of filtered signal, green');

subplot(3,1,3);
plot(f_axis, green_FFT,'b'); 
title('FFT of filtered signal, blue');
xlabel('Frequency, Hz')

%% Calculate HR
% Find peak amplitude and its frequency 
[~,position_r]=max(red_FFT);
[~,position_g]=max(green_FFT);
[~,position_b]=max(blue_FFT);

peak_f_red=f_axis(position_r);
peak_f_green=f_axis(position_g);
peak_f_blue=f_axis(position_b);

% Convert Hz into BPM
HR_r=round(peak_f_red*60)
HR_g=round(peak_f_green*60)
HR_b=round(peak_f_blue*60)

%%%%%%%%%%%
release(videoPlayer);
release(videoFileReader);