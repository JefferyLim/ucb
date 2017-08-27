function [ centroid, spread, SF, Fn ] = spectralAnalysis( wav ,fs, N,w)
%spectralAnalysis (wav, N, w) takes the input wav and does spectral
%analysis and produces the centroid, spread, flatness, and flux of the wav
%file
%   wav - input wav file
%   N - frame size
%   w - window
    index = 1:N;
    hopSize = N/2;
    K = N/2+1;
    nFrames = floor (length(wav)/hopSize - 1);

    %centroid and spread
    centroid(1:nFrames) = 0;
    spread(1:nFrames) = 0;

    %summation and the product for flatness
    PI = zeros(1,nFrames);
    SUM = PI;

    Fn = zeros(1, nFrames);

    Xhatn = zeros(nFrames, K);

    for n = 1:nFrames
        %Take the fft of the window times each sample
        xn = wav(index);
        index = index + hopSize;
        Y = (fft(w.*xn));
        Xn = abs(Y(1:K));

        %Xhatn from the PDF
        Xhatn(n,:) = (Xn)./sum(Xn);

        %Calculate the product and the means for flatness
        PI(n) = prod(abs(Xn(:)));
        SUM(n) = mean(abs(Xn(:)));

        %temporary variable for calculating the centroid
        for k = 1:K
            temp(k) = k * Xhatn(n,k);
        end

        centroid(n) = mean(temp);
        spread(n) = std(Xhatn(n,:));
    end

    %Calculating the flatness of the signal
    SF = (PI(:).^(1/K))./SUM(:);

    %Calculating the flux of the signal
    for n = 1:nFrames-1
        Fn(n) = sum((Xhatn(n+1,:)-Xhatn(n,:)).^2);
    end

end
