function [ clippedAudio ] = clipAudio( wav, fs, T )
%clipAudio clips T seconds out of the center of the wav file
%   clippedAudio - T second clip from wav
%   wav - Input wav file
%   fs - sampling frequency
%   T - desired seconds to extract

    %wav Length size
    wavL = size(wav,1);

    %Calculating the desired samples
    desiredSamples = T*fs;

    %If wav length is smaller than desired samples, return audio
    if(wavL <= desiredSamples) 
        clippedAudio = wav;
        return;
    end;

    %Go T/2 to the left and to the right of the center 
    startS = floor(size(wav,1)/2-desiredSamples/2);
    endS = startS + desiredSamples;

    %Return clipped audio
    clippedAudio = wav(startS:endS-1);

end

