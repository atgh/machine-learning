function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCostMulti) and gradient here.
    %

    gradient = X.' * (X * theta - y) / m;
    theta = theta - alpha * gradient;
    cost = computeCostMulti(X, y, theta);

    debugString = sprintf('Iteration #%d\n\tCost: %0.5g,\tGradient:\n', iter, cost);
    disp(debugString);
    disp(gradient);


    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = cost;

end

end