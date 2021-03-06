%speechcoder1.m
%Plain LPC vocoder 
%Main file 
function [ outspeech ] = speechcoder1( inspeech ) 
% Speech Coding using Linear Predictive Coding (LPC)
% The desired order can be selected in the system constants section.
% For the excitation impulse-trains are used. The result does not sound very
% well but with this solution it is possible to achieve a low bitrate!
% Parameters: 
% inspeech : wave data with sampling rate Fs
% (Fs can be changed underneath if necessary)
% Returns:
% outspeech : wave data with sampling rate Fs
% (coded and resynthesized)

% arguments check
% ---------------
if ( nargin ~= 1)
error('argument check failed');
end; 
%
% system constants
% ----------------
Fs = 16000; % sampling rate in Hertz (Hz)
Order = 10; % order of the model used by LPC 
%
% main
% ---- 
% encoded the speech using LPC
[aCoeff, resid, pitch, G, parcor, stream] = proclpc(inspeech, Fs, Order); 
% decode/synthesize speech using LPC and impulse-trains as excitation
outspeech = synlpc(aCoeff, pitch, Fs, G);
