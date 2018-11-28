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

decimation_adjustment = " - D_256";   % Set to "" for no adjustment  OR " - D_x" where x is the decimation factor
input_samples_files = [
    ['..\samples\inputs\eric_voice.wav'; ['\Audio (Speech)' decimation_adjustment '.wav']],
    ['..\samples\inputs\prdog3.wav'; ['\Audio (Animal)' decimation_adjustment '.wav']],
    ['..\samples\inputs\Sample_BeeMoved_96kHz24bit_short.wav'; ['\Audio (Music)' decimation_adjustment '.wav']]
];

% Note: this is here for compatibility; currently only using Impulse 3 for each location
impulse_response_files = [
    ['\Impulse 1' decimation_adjustment '.wav'];
    ['\Impulse 2' decimation_adjustment '.wav'];
    ['\Impulse 3' decimation_adjustment '.wav']
];

for i = 1:2:length(locations(:,1))
    for j = 1:2:length(input_samples_files(:,1))
        [h, fs_h] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(3,:)));
        [x, fs_x] = audioread(input_samples_files(j,:));
        x = x(:,1);     % Keep only the left channel
        y = conv(x, h);
        y = y ./ abs(max(abs(y)));
        audiowrite(strcat(output_path, locations(i,:), input_samples_files(j+1,:)), y, fs_x, 'BitsPerSample', 32);
    end
end
