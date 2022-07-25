%% Read in the file
clearvars;
close all;
[f,fs] = audioread('sample.mp3');

%% Play original file
pOrig = audioplayer(f,fs);
%pOrig.play;

%% Plot both audio channels
% N = size(f,1); % Determine total number of samples in audio file
% figure;
% subplot(2,1,1);
% stem(1:N, f(:,1));
% title('Left Channel');
% subplot(2,1,2);
% stem(1:N, f(:,2));
% title('Right Channel');
N = size(f,1); % Determine total number of samples in audio file
figure;
stem(1:N, f(:,1));
title('Mono Channel');

%% Plot the spectrum
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f(:,1), N) / N; % For normalizing, but not needed for our analysis
y2 = fftshift(y);
figure;
plot(w,abs(y2));


%% Design a bandpass filter that filters out between 700 to 12000 Hz
n = 7;
beginFreq = 700 / (fs/2);
endFreq = 12000 / (fs/2);
[B,A] = butter(n, [beginFreq, endFreq], 'bandpass');

%% Filter the signal
fOut = filter(B, A, f);

%% Construct audioplayer object and play
p = audioplayer(fOut, fs);
p.play;