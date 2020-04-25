function smoothed = gaussianSmooth(image, fits, plotFlag)
% gaussianSmooth3 smooth image by convolving with a series of gaussian
% fits, one for each column. The fit parameters are first smoothed in the x
% direction.

warning('off','curvefit:cfit:subsasgn:coeffsClearingConfBounds');
%% collect parameters from all fits and smooth them using moving average to reduce effect of misfits 
[z,a,b,c] = cellfun(@(f) deal(f.z, f.a1, f.b1, f.c1), fits);
smoothingLength = 11;
mz = savitzkyGolayFilt(z, 1, 0, smoothingLength);
ma = savitzkyGolayFilt(a, 1, 0, smoothingLength);
mb = savitzkyGolayFilt(b, 1, 0, smoothingLength);
mc = savitzkyGolayFilt(c, 1, 0, smoothingLength);

%% create gaussians using smoothed parameters and convoleve each column with them
x=1:size(image, 1);
xCenter = mean([x(1),x(end)]);
for i=1:length(fits)
    y = image(:,i); % get column
    gaussFitCenterd = fits{i};
    gaussFitCenterd.z = 0; % zero background;
    gaussFitCenterd.b1 = xCenter; % move Gaussian to center fit
    gaussFitCenterd.a1 = ma(i); 
    gaussFitCenterd.c1 = mc(i);
    nl = mz(i);
    yGaussFit = gaussFitCenterd(x);
    yGaussFit = yGaussFit./sum(yGaussFit); % normalize Gaussian;
    smoothed(:,i) = conv(y-nl, yGaussFit,'same'); % convolution
end

warning('on','curvefit:cfit:subsasgn:coeffsClearingConfBounds');
%% Plot smoothed gaussian parameters
if( exist('plotFlag','var') && plotFlag)
    figure; imagesc(smoothed);
    figure; 
    subplot(2,2,1); plot(mz); title('mz');
    subplot(2,2,2); plot(ma); title('ma');
    subplot(2,2,3); plot(mb); title('mb');
    subplot(2,2,4); plot(mc); title('mc');
end
