function [ zcr ] = ZCR( wav, N)
%ZCR(wav, N) calculates the Zero Crossing Rate of the wav file per frame of
%size N

    %Calculate the number of frames that we have
    nFrames = floor(length(wav)/N);

    %Temp to do the summation 
    temp(1:nFrames) = 0;
    for x = 1:nFrames
        for y = 1:N
            temp(x) = temp(x) + abs(sign(wav(1+(x-1)*N+y)) - sign(wav(1+(x-1)*N+y-1)));
        end
    end

    zcr = 1/(2*N) * temp;

end

