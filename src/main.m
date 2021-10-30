% (C) Copyright 2021 CPP LePoulpe developers

% this is the main script to present auditory or visual motion in LePoulpe
% it calls generate sounds (white, pink, brown noise) in a given length and
% cuts the sound array into chunks to play each chunk in a speaker.

% for visual motion it activates LEDs in a given speed, plane (horizontal,
% vertical), and plays them in a given number of repetitions

% if the suer control is needed, please provide that. Otherwise it loops

% through the repetitions with 5s wait time.

pacedByUser = false;

waitForAWhile = 0;


%% prepare sounds to be played
fs = 44100;
saveAsWav = 1;
duration = 0.8;

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
nbRepetition = 2;

waitForSwtich = 1;

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playMotionSound('horizontal', ...
                speakerIdxRightward, ...
                soundArray, ...
                nbRepetition, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playMotionSound('horizontal', ...
                speakerIdxLeftward, ...
                soundArray, ...
                nbRepetition, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playMotionSound('vertical', ...
                speakerIdxDownward, ...
                soundArray, ...
                nbRepetition, ...
                waitForSwtich);

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playMotionSound('vertical', ...
                speakerIdxUpward, ...
                soundArray, ...
                nbRepetition, ...
                waitForSwtich);

 %% play LEDs (visual motion)
speed = .03;
nbRepetition = 1;

pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playVisualMotion('rightward', ...
                 speed, ...
                 2, ...
                 nbRepetition);


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playVisualMotion('leftward', ...
                 speed, ...
                 2, ...
                 nbRepetition)


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playVisualMotion('downward', ...
                 speed, ...
                 1, ...
                 nbRepetition)


pressSpaceForMeOrWait(pacedByUser, waitForAWhile)
playVisualMotion('upward', ...
                 speed, ...
                 1, ...
                 nbRepetition)
