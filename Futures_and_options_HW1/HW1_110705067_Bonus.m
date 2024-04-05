clear;

% Parameters
S0 = 50;
K = 52;
r = 0.05;
q = 0;
sigma = 0.3;
T = 2;
ExerciseType = 'e'; % 'a' for American option, 'e' for European option
OptionType = 'p'; % 'p' for put option, 'c' for call option

% Time steps
NT_values = [6, 12, 52];

% Plot settings
figure;

for i = 1:length(NT_values)
    NT = NT_values(i);

    % Compute terminal stock prices and probabilities
    [terminal_prices, probabilities] = TerminalPricesAndProbabilities(S0, r, q, sigma, T, NT);

    % Plot the terminal stock price distribution with dots and line
    subplot(1, length(NT_values), i);
    stem(terminal_prices, probabilities, 'Marker', 'o', 'LineStyle', 'none', 'Color', [0.8, 0.2, 0.2]);
    hold on;
    plot(terminal_prices, probabilities, 'LineWidth', 1.5, 'Color', [0.2, 0.8, 0.2]);

    title(['Terminal Distribution (', num2str(NT), ' time steps)']);
    xlabel('Terminal Stock Price');
    ylabel('Probability');
    legend('Probability (Dot Plot)', 'Probability (Line Plot)');
    hold off;
end

function [terminal_prices, probabilities] = TerminalPricesAndProbabilities(S0, r, q, sigma, T, NT)
    dt = T / NT;
    u = exp(sigma * sqrt(dt));
    d = 1 / u;
    a = exp((r - q) * dt);
    p = (a - d) / (u - d);

    % Initialize arrays
    terminal_prices = zeros(1, NT + 1);
    probabilities = zeros(1, NT + 1);

    % Compute terminal stock prices and probabilities
    for j = 0:NT
        terminal_prices(j + 1) = S0 * (u^j) * (d^(NT - j));
        probabilities(j + 1) = nchoosek(NT, j) * (p^j) * ((1 - p)^(NT - j));
    end
end

