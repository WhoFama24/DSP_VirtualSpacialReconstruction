clear all;
close all;

fs = 24000;
t = 0:1/fs:10;
w = 2*pi*422*t;
audiowrite("LFM_Chirp.wav", cos(cos(w/1500).*w), fs);
[y, fs] = audioread('LFM_Chirp.wav');
% player = audioplayer(y, fs, 24);
