%main.m
clc; % clear the command line
clear all; % clear the workspace
%
% system constants
% ---------------
InputFilename = 'S2ofwb.wav'; %change it according to your wave files  
[inspeech, Fs, bits] = wavread(InputFilename); % read the wavefile 
outspeech1 = speechcoder1(inspeech); outspeech2 = speechcoder2(inspeech); 
% display the results
figure(1);
subplot(3,1,1);
plot(inspeech);
grid;
subplot(3,1,2);
plot(outspeech1);
grid;
subplot(3,1,3);
plot(outspeech2);
grid; 
disp('Press a key to play the original sound!');
pause;
soundsc(inspeech, Fs); 
disp('Press a key to play the LPC compressed sound!');pause;
soundsc(outspeech1, Fs); 
disp('Press a key to play the voice-excited LPC compressed sound!');
pause;
soundsc(outspeech2, Fs);
