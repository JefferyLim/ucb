function [ mfcc_o ] = mfcc( wav, N, w, fBanks )
%mfcc(wav, N, w, fBanks) returns the mfcc coefficient based on the
%filterbanks fBanks and the input wav file
%   wav - input wav file
%   N - number of samples in a frame
%   w - Window
%   fBanks - filter banks

    
    index = 1:N;
    nBanks = 40;
    hopSize = N/2;

    nFrames = floor (length(wav)/hopSize);
    if (mod(nFrames,2) == 0)
        nFrames = nFrames -1;
    end

    % allocate the mel coefficients
    mfcc_o = zeros(nBanks, nFrames);

    % normalize the window
    w = 2*w./sum(w);

    %Hop through the wav and window it and then filter it with the fBanks
    for i=1:nFrames-1,
        X = abs(fft(wav(index).*w,N));
        mfcc_o(:,i) = fBanks * X(1:N/2+1);
        index = index + hopSize;
    end


end

