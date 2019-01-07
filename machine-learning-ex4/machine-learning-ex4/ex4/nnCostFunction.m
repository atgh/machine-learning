function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

for i=1:m
    A1i = X(i, :).';
    Z2i = Theta1 * [1; A1i];
    A2i = sigmoid(Z2i); 
    Z3i = Theta2 * [1; A2i];
    A3i = sigmoid(Z3i);
    Hi = A3i;
    
    Yi = zeros(num_labels, 1);
    Yi(y(i),1) = 1;
    for k = 1:num_labels
        Hik = Hi(k);
        Yik = Yi(k);
        J = J - Yik * log(Hik)- (1 - Yik) * log(1 - Hik);
    end

%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

    Delta3i = A3i - Yi;
    Delta2i = (Theta2.' * Delta3i) .* sigmoidGradient([1; Z2i]); 
    Delta2i = Delta2i(2:end, :);
    
    Theta2_grad = Theta2_grad + Delta3i * [1; A2i].';
    Theta1_grad = Theta1_grad + Delta2i * [1; A1i].';  
end

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

J = (1.0/m) * J;
Theta2_grad = (1.0/m) * Theta2_grad;
Theta1_grad = (1.0/m) * Theta1_grad;

J_reg = lambda/(2*m) * (sum(sum(Theta1(:, 2:end) .^ 2)) + sum(sum(Theta2(:, 2:end) .^ 2)));
J = J + J_reg;
Theta2_grad_reg = (lambda/m) * Theta2(:, 2:end);
Theta2_grad = Theta2_grad + [zeros(size(Theta2_grad,1), 1), Theta2_grad_reg];
Theta1_grad_reg = (lambda/m) * Theta1(:, 2:end);
Theta1_grad = Theta1_grad + [zeros(size(Theta1_grad,1), 1), Theta1_grad_reg];

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end