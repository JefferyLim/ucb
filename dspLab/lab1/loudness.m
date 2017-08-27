function [ loud ] = loudness( wav, N)
%loudness( wav, N), input an input wav file and a frame size N
%   Returns [loud], a vector that displays the standard deviation of 
%   the wav file for every frame size N. Uses a hopSize of N
%
%   wav - input wav file
%   N - sample size

    %Get the number of frames
    nFrames = floor (length(wav)/N);

    loud(1:nFrames) = 0;

    index = 1:N;
    hopSize = N;
    
    for x = 1:nFrames
        loud(x) = std(wav(index));
        index = index + hopSize;
    end

end