function outSound = makePinkNoise(stimDuration)

% let's start with white noise
outSound = randn(1, stimDuration );

% create q vector for filtering
pinkFilter = zeros(1, length(outSound));
pinkFilter(1) = 1;
for i = 2:length(outSound)
    pinkFilter(i) = (i - 2.5) * pinkFilter(i - 1) / (i - 1);
end

%filter the white noise
outSound = filter(1, pinkFilter, outSound);

% limit amplitude to [-1 to 1] aka normalize again
outSound = outSound/max(outSound);
outSound = outSound/abs(min(outSound));

% apply amp to avoid chirping
outSound =  0.95 .* outSound;

end