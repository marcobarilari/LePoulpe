% (C) Copyright 2021 CPP LePoulpe developers

% This demo presents auditory or visual motion on LePoulpe.
% It generates sound noises (white, pink, brown noise) in a given length and
% cuts the sound array into chunks to play each chunk in a speaker.
%
% For visual motion it activates LEDs in a given speed, plane (horizontal,
% vertical).

run(fullfile('..', 'initLePoulpe.m'));

pacedByUser = false;

waitForAWhile = 0;

%% set cfg for LEDs
speed = .03;
nbRepetitionLED = 1;

%% set cfg for sounds
fs = 44100;
saveAsWav = 1;
duration = 0.8;
nbRepetitionSound = 2;
waitForSwtich = 1;

% outSound = generateNoise('white', duration, saveAsWav, fs);
outSound = generateNoise('pink', duration, saveAsWav, fs);

nbSpeakers = 31;

% [soundArray] = cutSoundArray(inputSound, inputName, fs, nbSpeakers, saveAsWav);
[soundArray] = cutSoundArray(outSound, 'pinknoise', fs, nbSpeakers, saveAsWav);


% build the speaker arrays for each direction
speakerIdxRightward = generateMotionSpeakerArray('rightward');

speakerIdxLeftward = generateMotionSpeakerArray('leftward');

speakerIdxDownward = generateMotionSpeakerArray('downward');

speakerIdxUpward = generateMotionSpeakerArray('upward');

%% play sounds (auditory motion)
pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playMotionSound('horizontal', ...
                speakerIdxRightward, ...
                soundArray, ...
                nbRepetitionSound, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playMotionSound('horizontal', ...
                speakerIdxLeftward, ...
                soundArray, ...
                nbRepetitionSound, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playMotionSound('vertical', ...
                speakerIdxDownward, ...
                soundArray, ...
                nbRepetitionSound, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playMotionSound('vertical', ...
                speakerIdxUpward, ...
                soundArray, ...
                nbRepetitionSound, ...
                waitForSwtich);

 %% play LEDs (visual motion)

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playVisualMotion('rightward', ...
                 speed, ...
                 2, ...
                 nbRepetitionLED);


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playVisualMotion('leftward', ...
                 speed, ...
                 2, ...
                 nbRepetitionLED)


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playVisualMotion('downward', ...
                 speed, ...
                 1, ...
                 nbRepetitionLED)


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)

playVisualMotion('upward', ...
                 speed, ...
                 1, ...
                 nbRepetitionLED)
