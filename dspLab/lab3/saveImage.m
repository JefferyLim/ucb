function [  ] = saveImage( name, title )
%saveImage(name, title) takes the current open figure and saves the image
%   with name and title


print(strcat('images/',strcat(name, title)), '-dpng');

end

