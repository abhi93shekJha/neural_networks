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
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

   X = [ones(size(X,1),1) X];
 
   a1s = sigmoid(Theta1 * X');
   a1s = [ones(1, size(a1s,2)) ; a1s];
   a2s = sigmoid(Theta2 * a1s);
   [value index] = max(a2s);
   hx = index;
   
   yy = y';
   yy(yy!=1) = 0;
   yy(yy==1) = 1;
   Y = yy;
   for i=2:num_labels,
      yy = y';
      yy(yy!=i) = 0;
      yy(yy==i) = 1;
      Y = [Y;yy];
 
    end; 
	% fprintf("%f", size(Y, 1))
   
%                 k
%  J = (1/m)sum sum (-ylog(h(x))-(1-y)(log(1-h(x)))
%                i=1     

  J = -(1/m) * sum(sum((Y.*log(a2s)) + ((1-Y).*log(1-a2s))));

  t1 = Theta1;
  t1(:,1) = [];
  t2 = Theta2;
  t2(:,1) = [];
   
  reg = lambda/(2*m) * ((sum(sum(t1.^2)) + sum(sum(t2.^2))));
  J = J + reg; 

Delta1 = zeros(size(Theta1));
Delta2 = zeros(size(Theta2));

for i=1:m, 
    a1 = X(i,:);
    a1 = a1';
	z2 = Theta1 * a1;
    a2 = sigmoid(z2);
    a2 = [1;a2];
	zOut = Theta2 * a2;
    aOut = sigmoid(zOut);

    delta3 = aOut - Y(:,i);
    delta2 = (Theta2' * delta3) .* [1;sigmoidGradient(z2)];
    delta2 = delta2(2:end);

    Delta1 = Delta1 + delta2 * a1';
    Delta2 = Delta2 + delta3 * a2';

end;

   Theta1_grad = (1/m) * Delta1;
   Theta2_grad = (1/m) * Delta2;
   
   Theta1_grad_temp = Theta1_grad + (lambda/m) * Theta1;
   Theta1_grad_temp(:,1) = Theta1_grad(:,1);
   Theta1_grad = Theta1_grad_temp;   
   
   Theta2_grad_temp = Theta2_grad + (lambda/m) * Theta2;
   Theta2_grad_temp(:,1) = Theta2_grad(:,1);
   Theta2_grad = Theta2_grad_temp;
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
