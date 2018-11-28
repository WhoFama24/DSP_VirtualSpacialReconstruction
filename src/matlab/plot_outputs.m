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

more off;   # allows printing to console during FOR loop
for i = 1:2:length(locations(:,1))
    figure;
    set(gcf(), 'name', locations(i+1,:));
    subplot_position = 1;

    for j = 1:2:length(input_samples_files(:,1))
        % ----------------
        % Load Samples
        % ----------------

        % Load Impulse Response
        [h, fs_h] = audioread(strcat(impulse_response_path, locations(i,:), impulse_response_files(3,:)));

        % Load Input Sample
        [x, fs_x] = audioread(input_samples_files(j,:));
        x = x(:,1);     % Keep only the left channel

        % Load Real Output Sample
        [real_output, fs_real] = audioread(strcat(output_path_real, locations(i,:), input_samples_files(j+1,:)));
        real_output_normalized = real_output ./ max(abs(real_output));
        real_output_normalized = real_output_normalized.';

        % Calculate Simulate Output Sample
        sim_output = conv(h, x(:,1));
        sim_output_normalized = sim_output ./ max(abs(sim_output));
        sim_output_normalized = sim_output_normalized.';


        % ----------------
        % Peak Alignment
        % ----------------

        % Filter and Peak Detection
        [b,a] = butter(1, 1/1600);
        sim_output_lowpass = filter(b, a, abs(sim_output_normalized));
        real_output_lowpass = filter(b, a, abs(real_output_normalized));
        indx_sim = find(sim_output_lowpass > 0.75*max(sim_output_lowpass), 1);
        indx_real = find(real_output_lowpass > 0.75*max(real_output_lowpass), 1);

        % Perform alignment on highest peak
        % Zero pad to align peaks
        if indx_sim < indx_real
            sim_output_normalized = [zeros(1, indx_real - indx_sim) sim_output_normalized];
        else
            real_output_normalized = [zeros(1, indx_sim - indx_real) real_output_normalized];
        end

        % Truncate to match shortest sample
        if length(sim_output_normalized) < length(real_output_normalized)
            t = [0 : length(sim_output_normalized)-1] / fs_real;
            real_output_normalized = real_output_normalized(1:length(sim_output_normalized));
        else
            t = [0 : length(real_output_normalized)-1] / fs_real;
            sim_output_normalized = sim_output_normalized(1:length(real_output_normalized));
        end

        % ----------------
        % Plot Simulated and Real Samples
        % ----------------
        subplot(length([1:2:length(input_samples_files(:,1))]), 1, subplot_position)
        hold on;
        plot(t, sim_output_normalized, '-b');
        plot(t, real_output_normalized, '-r');
        hold off;
        title(sprintf('Real vs. Simulated Outputs for %s Input', input_samples_files(j+1,2:end-3)));
        xlabel('Sample (n)');
        ylabel('Amplitude');
        legend('Simulated Output', 'Real Ouput');

        subplot_position = subplot_position + 1;
    end
end
more on;
