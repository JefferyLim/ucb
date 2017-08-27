function [ AR ] = dynamicRhythmAR(S)
%dynamicRhythmAR(S) - calculates the dynamic changes in the rhythm
%   S - similarity matrix

    nFrames = (size(S,1));
    AR = zeros(20, round((nFrames/20)-1));

    for l=0:19
        for m = 0:(nFrames/20)-1
            for i=1:20
                for j=1:(20-l)
                AR(l+1,m+1) = AR(l+1,m+1) + S(i+m*20,j+m*20)*S(i+m*20,j+m*20+l);
                end
            end
            
            AR(l+1,m+1) = AR(l+1,m+1)/(20*(20-l));
        end
    end


end

