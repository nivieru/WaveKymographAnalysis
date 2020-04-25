function kymAnalysis = kymographAnalysis(name, parent)
% KymographAnalysis run kymograph analysis.
% INPUTS:
%   name (optional) - either of:
%       (1) name of initialized kymograph analysis folder.
%       (2) name of kymogrpah tiff file.
%       (3) empty [] or ommitted, to launch file chooser.
%
%   parent (optional) - if name is (2) or (3), parent folder to create the
%       analysis folder in. If ommited or empty, use current directory.
% OUTPUTS:
%   kymAnalysis - sturct containing parameters and analysis results.

addpath('auxillaryFunctions');
%% If name is not a folder name, initialze analysis folder with parameters.
if exist('name','var') && ~isempty(name) && isfolder(name)
    kymAnalysis.dirName = name;
else
    if ~exist('name', 'var')
        name = [];
    end
    if ~exist('parent', 'var')
        parent = [];
    end
    kymAnalysis.dirName = initializeKymographAnalysis(name, parent);
end

%% Load analysis parameters
kymAnalysis = loadKymographAnalysis(kymAnalysis.dirName);
params = kymAnalysis.params;

%% Load kymograph image and extract ROI
if isfield(kymAnalysis,'imROI')
    imROI = kymAnalysis.imROI;
else
    rkym = readKymograph(params.filename);
    [im_mean, ~] = averageKymograph(rkym, params.frames);
    imROI = im_mean(:,params.rs);
    if params.direction == 2
        imROI = flip(imROI,2);
    end
    figure; imagesc(imROI);
    imwrite(uint8(255 * mat2gray(imROI)), jet(256), fullfile(kymAnalysis.dirName, 'imROI.png'));
    save(fullfile(kymAnalysis.dirName,'imROI'), 'imROI');
end
%% Initial Image preparation - filter (Gaussian blur) in the r direction
fWidth = 7; % Should be odd
fSigma = 2;
x = (-(fWidth-1)/2):((fWidth-1)/2);
f = exp(-(x/fSigma).^2); % Gaussian window
filtROI = imfilter(imROI,f,'replicate');
figure; imagesc(filtROI);
imwrite(uint8(255 * mat2gray(filtROI)), jet(256), fullfile(kymAnalysis.dirName, 'filtROI.png'));

%% Find peaks in filtered image
S = size(filtROI);
for r=1:S(2)
    y = filtROI(:,r);
    if r==1
        prevPeak = params.peakPos;
    else
        prevPeak = results.peakLocs(:,r-1);
    end
    [results.peakLocs(:,r), peakPs(:,r)] = findWavePeaks(y, prevPeak, params.peakPos);
end

%% Smooth filtered image in the t direction using gaussian fits
% Find a Gaussian fit to the fisrt peak in each r
gaussFits = [];
for r=1:S(2)
    y = filtROI(:,r);
    gaussFits{r} = gaussianFit(y,results.peakLocs(1:r), gaussFits);
end
% Apply gaussians
smoothedROI = gaussianSmooth(imROI, gaussFits);
figure; imagesc(smoothedROI)
imwrite(uint8(255 * mat2gray(smoothedROI)), jet(256), fullfile(kymAnalysis.dirName, 'smoothedROI.png'));

%% Find peaks in smoothed image
for r=1:S(2)
    if r==1
        prevPeak = params.peakPos;
    else
        prevPeak = results.peakGaussedLocs(:,r-1);
    end
    results.peakGaussedLocs(:,r) = findWavePeaks(smoothedROI(:,r), prevPeak, params.peakPos);
end

%% Smooth wave positions using moving average ,and caculate inverse velocity
smoothWindowSize = 51; % must be odd number;
results = smoothAndDiffKymResults(results, smoothWindowSize);
%%
save(fullfile(kymAnalysis.dirName,'results'), '-struct', 'results');
%% Prepare output
kymAnalysis.params = params;
kymAnalysis.results = results;
kymAnalysis.gaussFits = gaussFits;
kymAnalysis.imROI = imROI;
kymAnalysis.filtROI = filtROI;
kymAnalysis.smoothedROI = smoothedROI;

%% Plot 
plotKymResults(kymAnalysis)
