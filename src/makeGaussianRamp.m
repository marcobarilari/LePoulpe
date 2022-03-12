% (C) Copyright 2022 CPP LePoulpe developers

function gaussianRamp = makeGaussianRamp(bellLength)

bellLenghtOneTail = bellLength / 2;

STD = (bellLenghtOneTail / 10) * 4;

MEAN = 0;

x = -bellLenghtOneTail:1:bellLenghtOneTail;

gaussianRamp = (1 / ( STD * sqrt(2 * pi))) * exp(-0.5 * ((x - MEAN) / STD) .^ 2);

gaussianRamp = gaussianRamp / max(gaussianRamp);

% figure(2)

% plot(gaussianRamp);

end