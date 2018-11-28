clear all;
close all;

% cd('E:/MEGA/School/Eric College/Graduate School/9th Semester/Digital Signal Processing/Graduate Project/src');

impulse_response_path = '..\samples\impulse_responses\';
output_path = '..\samples\outputs\sim\';
locations = [
    ["anechoic_chamber"; "Anechoic Chamber"];
    ["erics_apartment"; "Eric\'s Apartment"];
    ["intramural_field"; "Intramural Field"];
    ["simrall_stairwell"; "Simrall Stairwell"];
    ["ssrc_foyer"; "SSRC Foyer"]
];

input_samples_files = [
    ['..\samples\inputs\eric_voice.wav'; '\Audio (Speech).wav'],
    ['..\samples\inputs\prdog3.wav'; '\Audio (Animal).wav'],
    ['..\samples\inputs\Sample_BeeMoved_96kHz24bit_short.wav'; '\Audio (Music).wav']
];

% Note: this is here for compatibility; currently only using Impulse 3 for each location
impulse_response_files = [
    '\Impulse 1.wav';
    '\Impulse 2.wav';
    '\Impulse 3.wav'
];

for i = 1:2:length(locations(:,1))
    for j = 1:2:length(input_samples_files(:,1))
        [h, fs_h] = audioread(strcat(impulse_response_path, locations(i,:), '\Impulse 3.wav'));
        [x, fs_x] = audioread(input_samples_files(j,:));
        x = x(:,1);     % Keep only the left channel
        y = conv(x, h);
        y = y ./ abs(max(abs(y)));
        audiowrite(strcat(output_path, locations(i,:), input_samples_files(j+1,:)), y, fs_x, 'BitsPerSample', 32);
    end
end
