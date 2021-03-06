%speechcoder2.m 
%8.4 Voice-excited LPC vocoder 
%8.4.1 Main File
 
function [ outspeech ] = speechcoder2( inspeech )
% Speech Coding using Linear Predictive Coding (LPC)
% The desired order can be selected in the system constants section.
% For the excitation the residual signal is used. In order to decrease the
% bitrate, the residual signal is discrete cosine transformed and then 
% compressed. This means only the first 50 coefficients of the DCT are kept.
% While most of the energy of the signal is stored there, we don��t lose a lot
% of information.
% Parameters: 
% inspeech : wave data with sampling rate Fs
% (Fs can be changed underneath if necessary)
% Returns:
% outspeech : wave data with sampling rate Fs
% (coded and resynthesized)

%
% arguments check
% ---------------
if ( nargin ~= 1)
error(��argument check failed��);
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
% perform a discrete cosine transform on the residual
resid = dct(resid);
[a,b] = size(resid);
% only use the first 50 DCT-coefficients this can be done
% because most of the energy of the signal is conserved in these coeffs
resid = [ resid(1:50,:); zeros(430,b) ]; 
% quantize the data
resid = uencode(resid,4);
resid = udecode(resid,4); 
% perform an inverse DCT
resid = idct(resid); 
% add some noise to the signal to make it sound better
noise = [ zeros(50,b); 0.01*randn(430,b) ];
resid = resid + noise; 
% decode/synthesize speech using LPC and the compressed residual as excitation
outspeech = synlpc2(aCoeff, resid, Fs, G);
