function results = smoothAndDiffKymResults(results, smoothWindowSize)
results.peakLocsSmoothed = savitzkyGolayFilt(results.peakLocs,1,0,smoothWindowSize,[],2);
results.peakSGaussedLocsSmoothed = savitzkyGolayFilt(results.peakGaussedLocs,1,0,smoothWindowSize,[],2);

results.invV = savitzkyGolayFilt(results.peakLocs,1,1,smoothWindowSize,[],2);
results.invGaussedV = savitzkyGolayFilt(results.peakGaussedLocs,1,1,smoothWindowSize,[],2);
results.V = 1./results.invV;
results.GaussedV = 1./results.invGaussedV;
end