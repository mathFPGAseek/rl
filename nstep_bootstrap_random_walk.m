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
v = rand(1,20);
%x = 10; 
%y = 7;
%epsilon = .1;      % for greedy policy
%alpha = .5;        % step size
gamma = .9;        % discount rate
%q = zeros(7,10,9); % action-state space
%q(4,8,:) = 0;      % terminal value zero; Note coordinate from upperleft
episodes = 10;
states_num = 21;    % Note States 1 and 21 are terminal
state_position = zeros(1,states_num); 
current_state_position  = 11; % Note per Sutton we start at 11 center
t = 0; % initial time
direction = [ -1 +1];


%debug
%time_steps = 0;
%episode_debug = zeros(1,episodes);


for n = 1 : episodes
    T = 1e6; % in Sutton set to inifinity
    while tau ~= T-1
        if t < T
            action = randi(2,1); % Random left walk or right walk
            current_action = direction(action);
            next_state_position = current_state_position + current_action;
            % observe and store reward
            r = 0;
            if (next_state_position == 21 || next_state_position == 1)
                T = t + 1;
            end
        tau = t -n + 1;
        if tau > 0
            % Assign G execpt for discounted estimate gamma^n*Vt(St+1)
            upper_limit_summation = min( [tau+n T]);
            lower_limit_summation = tau + 1;
            G = 0;
            for  i = lower_limit_summation:upper_limit_summation 
                G = G + gamma^(i-tau-1)*% What do I use for Ri??
            
            
            
            
        
        
        
    end
     
end 