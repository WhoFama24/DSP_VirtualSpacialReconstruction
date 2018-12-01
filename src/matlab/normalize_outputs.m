clear all;
close all;

impulse_response_path = '..\samples\impulse_responses\';
output_path_sim  = '..\samples\outputs\sim\';
output_path_real = '..\samples\outputs\raw\';
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

more off;
for i = 1:2:length(locations(:,1))
    for j = 1:2:length(input_samples_files(:,1))
        [real_output, fs_real] = audioread(strcat(output_path_real, locations(i,:), input_samples_files(j+1,:)));
        real_output_normalized = real_output ./ max(abs(real_output));
        audiowrite(strcat(output_path_real, locations(i,:), input_samples_files(j+1,:)), real_output_normalized, fs_real, 'BitsPerSample', 32);

        [sim_output, fs_sim] = audioread(strcat(output_path_sim, locations(i,:), input_samples_files(j+1,:)));
        sim_output_normalized = sim_output ./ max(abs(sim_output));
        audiowrite(strcat(output_path_sim, locations(i,:), input_samples_files(j+1,:)), sim_output_normalized, fs_sim, 'BitsPerSample', 32);
    end
end
more on;
