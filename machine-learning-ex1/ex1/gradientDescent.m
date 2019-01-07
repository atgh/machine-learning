function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
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
    %       of the cost function (computeCost) and gradient here.
    %
    
    %gradient = zeros(length(theta), 1);
    %for i = 1:m
    %    gradient = gradient + (X(i,:) * theta - y(i, 1)) * transpose(X(i, 1));
    %end
    %gradient = gradient / m;
    %theta = theta - alpha*gradient;
    
    gradient = transpose(X) * (X * theta - y) / m;
    theta = theta - alpha * gradient;
    cost = computeCost(X, y, theta);

    debugString = sprintf('Iteration #%d\n\tCost: %0.5g,\tGradient:\n', iter, cost);
    disp(debugString);
    disp(gradient);
    
 
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = cost;

end

end
