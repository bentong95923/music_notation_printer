function [x_out] = get_power_envelope(x)

N = length(x);
w = (tukeywin(N, 0.25))';
m_lower_lim = floor(-N/30);
m_upper_lim = floor(N/30-1);
E0 = zeros(1, N);

for n = 1:N
    sumTerms = 0;
    for m = m_lower_lim:m_upper_lim
        if m <=0
            continue;
        else
            win_value = w(m);
        end
        if n+m <= 0 || n+m > N
            continue;
        else
            x_value = x(n+m);
        end
        sumTerms = sumTerms + abs(x_value)^2 * win_value;
    end
    E0(n) = sumTerms;
end
% E0 will have be left-shifted with m_upper_lim, need to compensate by
% applying m_upper_lim for getting the dips of position in no of samples.
E0 = 1/N .* E0;
[u,l]=envelope(E0,170,'peaks');
% figure(10)
% plot(l)

% figure(11)
% plot(diff(l),'.')

% figure(12)
[diff_u, diff_l] = envelope(diff(l), 200, 'peaks');
plot(diff_u, '.')

% figure(13)
x_out = [zeros(1,-floor(m_lower_lim*0.75)), diff_u];
% plot(x_out, '.')
% title('Get power envelope output')
end