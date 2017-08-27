function [NPCP] = npcp(wav, fs, N, w)

    %Constants
    f0 = 27.5; %Hz

    %index and hopSize
    index = 1:N;
    K = N/2 + 1;
    hopSize = N/2; %50% overlap

    sLength = size(wav, 1);

    %Calculate the number of frames required
    frames = floor (sLength/hopSize);
    if (mod(frames,2) == 0)
        frames = frames - 1;
    end

    %Generate the PCP and NPCP matrices
    PCP = zeros(12, frames);

    %For each frame of the song
    for n= 1:frames-1

        %Window and FFT
        Y= fft(wav(index).*w, N);
        Xn = Y(1:K);

        %Step 1
        %Find the peaks of the FFT and their locations
        [~, locs] = findpeaks(abs(Xn), 'MinPeakHeight', .5e-8);

        %locations of the peaks normalized to frequency in Hz
        f = locs*fs/N; %Hz

        %Step 2
        %Calculate all the sm values
        sm = round(12 * log10(f/f0)/log10(2));

        %Calculate the c (+1 so its from 1 to 12
        c = mod(sm, 12) + 1;
        %Step 3
        for i = 1:12
            for k = 1:size(f)
                %If the tone matches
                if(c(k) == i)
                    %Calcuate the r value for the weight
                    r = (12 * log10(f(k)/f0)/log10(2)) - sm(k);

                    weight = 0;
                    if(abs(r) < 1)
                        weight = cos(pi*r/2)^2;
                    end;

                    PCP(i,n) = PCP(i, n) + weight * abs(Xn(locs(k))).^2;            
                end
            end
        end
        index = index + hopSize;
    end 
        %Normalize with the maximum value
        NPCP = PCP/max(max(PCP));
return