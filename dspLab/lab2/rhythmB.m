function [ B ] = rhythmB(S)
%rhythmB(S) - calculates the rhythm index B
%   S - similarity matrix

    nFrames = (size(S,1));
    B = zeros(1,nFrames);
    
    for l=0:nFrames-1
        for n=1:nFrames-l
            B(l+1) = B(l+1) + (S(n,n+l));
        end
        B(l+1) = B(l+1)/(nFrames-l);
    end

end

