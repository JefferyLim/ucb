%lab2 workspace
%all work to produce the images and plots for lab1 are contain in this
%workspace

%Load all track names
tracks = dir('audio/*.wav');

N = 512;

for i=1:size(tracks)
    %Read and clip audio
    [wav, fs] = audioread(strcat('audio/', tracks(i).name));
    [clippedWav] = clipAudio(wav, fs, 24);
    
    %obtain the clip size of the audio and the frame length
    clipL = size(clippedWav,1);
    frameL = clipL/N;
    
    figure(1);
    subplot(3,1,1);
    plot(clippedWav);xlabel('Seconds');ylabel('Amplitude');title((tracks(i).name));xlim([0 clipL]);
    
    %Calcuate loudness
    [loud] = loudness(clippedWav,N);
    subplot(3,1,2);
    plot(1:frameL, loud);xlabel('Frames');ylabel('Amplitude');title('Loudness');xlim([0 frameL]);
    
    %Calculate the ZCR
    [zcr] = ZCR(clippedWav, N);
    subplot(3,1,3);
    plot(zcr);xlabel('Frames');ylabel('Rate');title('ZCR');xlim([0 frameL]);
    
    %Save images
    saveImage(tracks(i).name, '-timedomain');

%     w = bartlett(N);
%     w = hann(N);
      w = kaiser(N, 15);
      
%     subplot(2,1,1);
%     plot(w);xlabel('Frames');ylabel('Amplitude');title('Bartlett Window');xlim([0 512]);
% 
%     fs = 1000;
%     T = 1/fs;
%     L = 512;
%     t = (0:L-1)*T;
%     sine = sin(2*pi*t*100);
% 
%     Y = fft(w'.*sine);
%     K = N/2 + 1;
%     Xn = Y(1:K);
%     ff = 0:(fs/L):(fs/2);
%     subplot(2,1,2);
%     plot(ff,abs(Xn));xlabel('Frequency');ylabel('Magnitude');title('FFT of Windowed Sin');

    figure(2);
    
    %Spectogram
    [spectogram] = plotspectrogram(clippedWav, N, w);
    imagesc(log10(spectogram));set(gca,'ydir','normal');title(strcat(tracks(i).name, ': Spectrogram'));color bar; 
    xlabel('Frames');ylabel('Frequency');
    
    saveImage(tracks(i).name, '-specto');
    
    figure(3);
    %Centroid and Spread and Flatness and Flux
    [centroid, spread, SF, Fn] = spectralAnalysis(clippedWav,fs, N, w);
    
    subplot(4,1,1);
    plot(real(centroid));xlabel('Frames');ylabel('Amplitude');title('Spectral Centroid');xlim([0 frameL*2]);
    
    subplot(4,1,2);
    plot(spread);xlabel('Frames');ylabel('Amplitude');title('Spectral Spread');xlim([0 frameL*2]);
    
    subplot(4,1,3);
    plot(SF);xlabel('Frames');ylabel('Amplitude');title('Spectral Flatness');xlim([0 frameL*2]);
    
    subplot(4,1,4);
    plot(Fn);xlabel('Frames');ylabel('Amplitude');title('Spectral Flux');xlim([0 frameL*2]);
    
    saveImage(tracks(i).name, '-spectral');
    
    %Calculating the fbanks and the mfcc
    [Hp] = fbanks(fs, N);
    [mfcc_o] = mfcc(clippedWav, N, w, Hp);
    
    figure(4);
    imagesc(log10(mfcc_o));set(gca,'ydir','normal'); title(strcat(tracks(i).name, ': MFCC')); colorbar
    xlabel('Frames');ylabel('Filter');
    
    saveImage(tracks(i).name, '-mfcc');
    
    [NPCP] = npcp(clippedWav, fs, N, w);
    
    figure(5);
    imagesc(log10(mfcc_o));set(gca,'ydir','normal'); title(strcat(tracks(i).name, ': MFCC')); colorbar
    xlabel('Frames');ylabel('Filter');
end
