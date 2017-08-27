function [ AR ] = rhythmAR( S )
%rhythmAR(S) - calculates the rhythm index AR
%   S - similarity matrix

    nFrames = (size(S,1));
    AR = zeros(1,nFrames);

    for l=0:nFrames-1
        for i=1:nFrames
            for j=1:nFrames-l
                AR(l+1) = AR(l+1) + S(i,j)*S(i,j+l);
            end
        end 
        AR(l+1) = AR(l+1)/(nFrames*(nFrames-l));
    end


end

