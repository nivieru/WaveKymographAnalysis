# WaveKymographAnalysis
MATLAB program to extracts actin wave positions and velocity from kymographs of extract droplets

## Quick Start
to select the kymograph file from dialog run:
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
* ```kymAnalysis = kymographAnalysis([name], [parent])``` - Main analysis function.
* ```dirName = initializeKymographAnalysis([filename], [parent])``` - Start a new analysis. Create folder in current folder or [parent] if provided.
open kymograph [filename], or choose kymogrph from dialog if not provided. Choose ROI and mark waves start points.
* ```kymAnalysis = loadKymographAnalysis([dirName])``` - Load parameters and results from dirName, pick dir from dialog if not provided.
* ```rkym = readKymograph(filename)``` - Read kymograph file.
* ```[im_mean, frames] = averageKymograph(rkym, [frames])``` - Make average kymograph using selected frames.
If frames not provided, display kymograph as movie open dialog. If frames is empty [], use all frames.
* ```[peakLocs, peakPs] = findWavePeaks(y, prevPeak, peakPos)``` - Find wave times in slice y.
* ```gaussFit = gaussianFit(y,peakLocs, gaussFits)``` - Make a time domain Gaussian fit to the first wave in slice y.
* ```smoothedROI = gaussianSmooth(imROI, gaussFits)``` - smooth image imROI by convolving each slice r with time-domain Gaussian from series of fits.
The parameters of the Gaussians are first smoothed in the r-domain.
* ```results = smoothAndDiffKymResults(results, smoothWindowSize)``` - Smooth and differentiate wave tracks and calculate wave velocities.
* ```plotKymResults(kymAnalysis)``` - Plot results.
