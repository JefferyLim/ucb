%w = bartlett(N);
%w = hann(N);
w = kaiser(N);

subplot(2,1,1);
plot(w);xlabel('Frames');ylabel('Amplitude');title('Kaiser Window');xlim([0 512]);

fs = 1000;
T = 1/fs;
L = 512;
t = (0:L-1)*T;
sine = sin(2*pi*t*100); %100 Hz Sine Wave

%Compute FFT
Y = fft(w'.*sine);
K = N/2 + 1;
Xn = Y(1:K);

ff = 0:(fs/L):(fs/2);

subplot(2,1,2);
plot(ff,abs(Xn));xlabel('Frequency');ylabel('Magnitude');title('FFT of Windowed Sin');
