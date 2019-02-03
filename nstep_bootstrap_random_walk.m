%-------------------------------------------------------------------------
% script file: nstep_bootstrap_random_walk.m
% 1/7/19 Ray Duran,engineer,baycool0422@gmail.com
% github repository: https://github/mathFPGAseek/rl
% Example of n-step bootstrap with random walk
% Sutton, "Reinforcement Learning,An Introduction, 2nd ed" pg 144,
% Chapter 7 n-step bootstrapping
% Algo:
% Input a policy pi
% Parameters: step size: alpha(0,1], small epsilon > 0
% A positive integer n.
% Initialize V(s), for all s.
% All store and access operationss for St and Rt can take their index mod
% n+1
%
%  Loop for each epsiode
%   Initialize S0 =\ terminal
%   T <-- inf
%   Loop for t = 0,1,2,...
%       If t < T, then:
%           Take an action according to pi(.|St)
%           Observe and store the next reward as Rt+1 and the next state at
%           St+1
%           If St+1 is terminal, then T<- t +1
%       tau <- t- n + 1( tau is the time whose state's estimate is being
%       updated.
%       If tau >= 0:
%         G <- Sum( from: i = tau+1; to : min( tau+n, T)gamma^(i-tau-1)*Ri
%         If tau + n < T, then: G <- G + gamma^n*V(Stau+n)
%         V(Stau) <- V(Stau) + alpha*[ G - V(Stau)]
%   Until  tau = T-1
%-------------------------------------------------------------------------
clear all;

% Init V(s)
states_num = 21;              % Note States 1 and 21 are terminal
v = rand(1,states_num);

n     =  3;                   % n-steps for TD
gamma = .9;                   % discount rate
alpha = .9;                   % step size
episodes = 10;
state_position = zeros(1,states_num); 
current_state_position  = 11; % Note per Sutton we start at 11 center
t = 0;                        % initial time
tau = 0;
direction = [ -1 +1];
tu = states_num* 10;          % For random walk I multipled by 10 as a guess
                              % for needed timesteps
r        = zeros(1,tu)        % initialize rewards


%debug
%time_steps = 0;
%episode_debug = zeros(1,episodes);


for k = 1 : episodes
    T = 1e6; % in Sutton set to inifinity
    while tau ~= T-1
        if t < T
            action = randi(2,1); % Random left walk or right walk
            current_action = direction(action);
            next_state_position = current_state_position + current_action;
            % observe and store reward
            r(t+1) = 0;
            if (next_state_position == 21 || next_state_position == 1)
                T = t + 1;
            end
        end
        tau = t -n + 1; % update tau
        if tau >= 0
            % Assign G execpt for discounted estimate gamma^n*Vt(St+1)
            upper_limit_summation = min( [tau+n T]);
            lower_limit_summation = tau + 1;
            G = 0;
            for  i = lower_limit_summation:upper_limit_summation 
                G = G + (gamma^(i-tau-1))*r(t);
            end
            if tau + n < T
                G = G + (gamma^n)*V(tau+n);
            end
            V(tau) = V(tau) + alpha*(G - V(tau));      
        end
    % debug display
    debug = 0;
    % update t
    t = t + 1;

    end     
end 