function [ spectro ] = plotspectrogram(wav, N, w)
%plotspectrogram(wav,N,w) outputs the spectrogram of the wav file
%   wav - input wav file
%   N - sample size of frames
%   w - window

    %obtain hopSize, FFT samples, and number of total Frames
    index = 1:N;
    hopSize = N/2;
    K = N/2+1;
    nFrames = floor (length(wav)/hopSize - 1);

    spectro = zeros(K,nFrames);
    
    
    for n = 1:nFrames
        %Take the fft of Xn^2 times each sample
        xn = wav(index);
        index = index + hopSize;
        
        Y = abs(fft(w.*xn)).^2;
        Xn = Y(1:K);

        %Take the summation of the coefficients
       for p=1:K

           %The sum of the |Hp(k) time Xn(k)|^2
            spectro(p,n) = spectro(p,n) + abs(Xn(p)).^2;
        end
    end
end

