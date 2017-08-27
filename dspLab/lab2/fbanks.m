function [ Hp ] = fbanks( fs, N )
%fbanks( fs, N) returns 40 filter banks based on the Mel frequency bands. \
%   fs - sampling frequency
%   N - frame size

    nbanks = 40; %% Number of Mel frequency bands
    % linear frequencies
    linFrq = 20:fs/2;
    % mel frequencies
    melFrq = log ( 1 + linFrq/700) *1127.01048;
    % equispaced mel indices
    melIdx = linspace(1,max(melFrq),nbanks+2);
    % From mel index to linear frequency
    melIdx2Frq = zeros (1,nbanks+2);
    % melIdx2Frq (p) = \Omega_p

    for i=1:nbanks+2
        [val indx] = min(abs(melFrq - melIdx(i)));
        melIdx2Frq(i) = linFrq(indx);
    end

    Hp = zeros(nbanks, N/2+1);
    %Create a linear freq spacing in order to fit the necessary freq inputs
    linearFreq = linspace(0,fs/2,N/2+1);

    %Based on the algorithm provided in the pdf
    for i = 1:nbanks
        for j = 1:N/2+1
            if(linearFreq(j) >= melIdx2Frq(i) && linearFreq(j) < melIdx2Frq(i+1))
                Hp(i,j) = 2/(melIdx2Frq(i+2) - melIdx2Frq(i))...
                            *(linearFreq(j)-melIdx2Frq(i))...
                             /(melIdx2Frq(i+1) - melIdx2Frq(i));
            elseif(linearFreq(j) >= melIdx2Frq(i+1) && linearFreq(j) < melIdx2Frq(i+2))
                Hp(i,j) = 2/(melIdx2Frq(i+2) - melIdx2Frq(i))...
                            *(melIdx2Frq(i+2)-linearFreq(j))...
                            /(melIdx2Frq(i+2) - melIdx2Frq(i+1));
            end
        end
    end

    %     plot filter banks
    %     figure; set(gca,'fontsize',14);
    %     semilogx(linearFreq,Hp');title('Filter Banks');
    %     axis([0 melIdx2Frq(nbanks+2) 0 max(Hp(:))])
    %     xlabel('Frequency');

end

