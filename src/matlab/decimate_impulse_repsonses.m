clear all;
close all;

% cd('E:/MEGA/School/Eric College/Graduate School/9th Semester/Digital Signal Processing/Graduate Project/src');

D = 256;

impulse_response_path = '..\samples\impulse_responses\';
locations = [
    ["anechoic_chamber"; "Anechoic Chamber"];
    ["erics_apartment"; "Eric\'s Apartment"];
    ["intramural_field"; "Intramural Field"];
    ["simrall_stairwell"; "Simrall Stairwell"];
    ["ssrc_foyer"; "SSRC Foyer"]
];
impulse_response_files = [
    '\Impulse 1.wav';
    '\Impulse 2.wav';
    '\Impulse 3.wav'
];
impulse_response_decimate_files = [
    strcat('\Impulse 1 - D_', num2str(D), '.wav');
    strcat('\Impulse 2 - D_', num2str(D), '.wav');
    strcat('\Impulse 3 - D_', num2str(D), '.wav');
];

for i = 1:2:length(locations(:,1))
    for j = 1:1:length(impulse_response_files(:,1))
        [h, fs] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(j,:)));
        h_dec = decimate(h, D);
        audiowrite(strcat(impulse_response_path, locations(i,:), impulse_response_decimate_files(j,:)), h_dec, fs, 'BitsPerSample', 32);
    end
end
