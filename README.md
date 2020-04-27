# WaveKymographAnalysis
MATLAB program to extracts actin wave positions and velocity from kymographs of extract droplets

## Cloning
Clone this repo to your local machine using `git clone https://github.com/nivieru/WaveKymographAnalysis.git`

## Quick Start
To select the kymograph file from dialog run:
```
kym = kymographAnalysis
```
The output folder will be created in the current directory.
Alternatively, to create the output folder in the directory parentDir, run:
```
kym = kymographAnalysis([], parentDir)
```

To pick a file from the command line, run:
```
kym = kymographAnalysis(kymographFileName)
```
or:
```
kym = kymographAnalysis(kymographFileName, parentDirName)
```

To rerun a previous analysis using the parameters, run:
```
kym = kymographAnalysis(AnalysisDirName)
```
Notice that it will overwrite the previous results!

## Functions
* `kymographAnalysis([name], [parent])` - Main analysis function.
* `initializeKymographAnalysis([filename], [parent])` - Start a new analysis. Create folder in current folder or `parent` if provided.
Open kymograph `filename`, or choose kymogrph from dialog if not provided. Choose ROI and mark waves start points.
* `readKymograph(filename)` - Read kymograph file.
* `averageKymograph(rkym, [frames])` - Make average kymograph from selected `frames.`
If `frames` not provided, display kymograph video and choose frames from dialog. If `frames` is empty `[]`, use all kymogrpah frames.
* `ROIKymograph(im_mean)` - Select ROI on averaged kymograph image
* `getPeakStart(imRoi)` - Mark waves start points on ROI image.
* `loadKymographAnalysis([dirName])` - Load parameters and results from folder `dirName`, pick folder from dialog if not provided.
* `findWavePeaks(y, prevPeak, peakPos)` - Find wave peak times in r-slice `y`.
* `gaussianFit(y,peakLocs, gaussFits)` - Make a time domain Gaussian fit to the first wave in r-slice `y`.
* `gaussianSmooth(imROI, gaussFits)` - Smooth image `imROI` by convolving each r-slice with time-domain Gaussian from series of fits.
The parameters of the Gaussians are first smoothed in the r-domain.
* `smoothAndDiffKymResults(results, smoothWindowSize)` - Smooth and differentiate wave tracks and calculate wave velocities.
* `plotKymResults(kymAnalysis)` - Plot results.
