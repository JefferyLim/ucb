%Load the speech file
load('lab3speech.mat');

%Conduct a DCT
basis = dct(x);

%Look for values below a certain threshold
y2 = find(abs(basis) < .0004);
pointsTakenOut = size(y2,1) 

%Set those values to 0
basis(y2) = zeros(size(y2));

%Inverse DCT
z = idct(basis);

figure(1);
subplot(1,2,1);
plot(x);
title('Original Signal');
subplot(1,2,2);
plot(z);
title('Reconstructed Signal');

%Calculate the error
error = norm(x - z)/norm(x);
energy = 1 - error
