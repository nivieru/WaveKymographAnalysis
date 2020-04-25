function plotKymResults(kymAnalysis)
figure; imagesc(kymAnalysis.imROI); hold on;
plot(kymAnalysis.results.peakLocs');
plot(kymAnalysis.results.peakLocsSmoothed');
title('raw data');

figure; imagesc(kymAnalysis.imROI); hold on;
plot(kymAnalysis.results.peakGaussedLocs');
plot(kymAnalysis.results.peakSGaussedLocsSmoothed');
title('gaussed smoothed data');

figure; plot(kymAnalysis.results.invV');
title('invV');
figure; plot(kymAnalysis.results.invGaussedV');
title('invGaussedV');

figure; plot(kymAnalysis.results.V');
ylim([-40,0]);
title('V');
figure; plot(kymAnalysis.results.GaussedV');
ylim([-40,0]);
title('GaussedV');
