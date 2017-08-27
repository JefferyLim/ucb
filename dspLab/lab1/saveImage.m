function [  ] = saveImage( name, title )
%saveImage(name, title) takes the current open figure and saves the image
%   with name and title

filename_length = size(name);
print(strcat('images/',strcat(name(1:filename_length(2)-4), title)), '-dpng');

end

