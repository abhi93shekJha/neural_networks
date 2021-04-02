# Neural networks learning
<h2> Hand written digit recognition </h2>

We have 3 layers in this neural network. </br>

1st layer - input layer (400 * 1) </br>
2nd layer - hidden layer (25 hidden units) </br>
3rd layer - Output labels (Total 10) (0, 1, 2, 3, 4, 5, 6, 7, 8, 9) 0 is used for 10 for simplicity. </br>

   <img src="hidden_layer.PNG" alt="alt text" width="350" height="250">


Training data:</br>
data1.mat:  </br>
X = 5000 * 200 matrix.</br>
200 columns corresponds to 20 * 20 matrix (which are 400 floating point numbers, for each pixel)</br>
            
output: y = 5000 rows vector containing output values from 0-9. This output is corresponding to each row from input. </br>           
We already have tarined parameters in, weights.mat, </br>
Theta1 (Dimension 25 * 401)</br>
Theta2 (Dimention 10 * 26)</br>
         
<img src="dataset.PNG" alt="alt text" width="350" height="250"> 


STEPS INVOLVED IN THIS PROJECT:</br>


1. nnCostFunction.m -- using Feedforward to calculate cost function. First without regularization, then with regularization.</br>
   <img src="costFun.PNG" alt="alt text" width="500" height="100"></br>
2. Backpropagation implementation with below steps:   </br>
   (i) Sigmoid of a function -- 1/(1+pow(e,-z)) , where z is the given input.</br>
   (ii) Randomly initializing parameter Theta in the range [-0.12 0.12]  </br>  
3. Backpropagation steps:</br>
   -- We will do a forward pass to compute activations (a) for every layer including Output layer. </br>
   
   
   
   
   
   
   
   
   
   
   

