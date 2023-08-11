% Multiple Linear Regression
% Angel Badillo
% 08/07/2023

X = 0;
y = 0;

% Implementation of Multiple Linear Regression using Moore–Penrose inverse
function [coefficients, predictions] = multiple_linear_regression(X, y)

    % Add a column of ones to the X matrix for the intercept term
    X_with_intercept = [ones(rows(X), 1), X];

    % Calculate the coefficients using least squares
    coefficients = pinv(X_with_intercept' * X_with_intercept) * ...
    X_with_intercept' * y;

    % Calculate predictions using the fitted model
    predictions = X_with_intercept * coefficients;
endfunction

% Clear screen
clc

h = helpdlg("You will be prompted to select an input file.\n\n\
Then, you will be prompted to select or create an output file.\n\n\
All output will be printed to output file.", ...
"Multiple Linear Regression Calculator");

uiwait(h);

% Prompt for input file
[infile, infilepath] = uigetfile({"*.csv", "Comma Separate Value"}, "Select Input File")

% Read data, separates headers from numerical data
filedata = importdata([infilepath,infile], ',', 1);

% Prompt for output file
[outfile, outfilepath] = uiputfile({"*.txt", "Text Document"},"Save Output File");
ofid = fopen([outfilepath,outfile], 'w');

% Store headers
headers = filedata.colheaders;

% Matrix with columns of X0 to Xm values
X = filedata.data(:,1:end-1);

% Vector with column of Y values
y = filedata.data(:,end);

[a, y_pred] = multiple_linear_regression(X,y);

%-------------Heading------------------------------------------------------------
fdisp(ofid, "Multiple Linear Regression");
fdisp(ofid, "===================================================================\
=====");
%--------------------------------------------------------------------------------

%------------Print Coefficients--------------------------------------------------

fdisp(ofid, "Coefficients");
fdisp(ofid, "___________________________________________________________________\
_____");

for i=1:length(a)
  fprintf(ofid, "a_%d = %.5f\n",i-1, a(i));
endfor

fdisp(ofid, "===================================================================\
=====");
%--------------------------------------------------------------------------------

%-------------Prints Linear Equation---------------------------------------------

fdisp(ofid, "Linear Equation");
fdisp(ofid, "___________________________________________________________________\
_____");

fstr = sprintf("%s =", headers{length(a)});

for i=1:rows(a)
  fstr = sprintf("%s %.5f", fstr, a(i));
  if(i > 1)
    fstr = sprintf("%s%s", fstr, headers{i-1});
  endif

  if(i+1 <= rows(a))
  fstr = sprintf("%s +", fstr);
  endif
endfor

fdisp(ofid, fstr)
fdisp(ofid, "===================================================================\
=====");
%--------------------------------------------------------------------------------

%-------------Prints Estimates Y_values------------------------------------------
fprintf(ofid, "%s-values      Predicted %s-values\n", headers{length(a)},...
headers{length(a)});

fdisp(ofid, "___________________________________________________________________\
_____");
fdisp(ofid, [y y_pred]);
fdisp(ofid, "===================================================================\
=====");
%--------------------------------------------------------------------------------

fclose(ofid);

%-------------2D & 3D Graphing---------------------------------------------------
if(columns(X) == 1)
  figure(1);
  plot(X', y', "markerfacecolor", 'y', 'dr', X', y_pred')
  xlabel(headers(1));
  ylabel(headers(2));
  title(fstr);
  grid on
  legend('Data Points', "Model")
  set(gca, "linewidth", 2, "fontsize", 20)
elseif(columns(X) == 2)
% Define coefficients a0, a1, and a2
a0 = a(1);
a1 = a(2);
a2 = a(3);

% Samples for independent variables
x1 = X(:,1)';
x2 = X(:,2)';

% Create a grid of points for x1 and x2
[X1, X2] = meshgrid(x1, x2);

% Calculate the corresponding y values using the function z = a0 + a1*x1 + a2*x2
Y = a0 + a1.*X1 + a2.*X2

% Create a 3D surface plot
figure(1);
hold on;
plot3(x1,x2,y',"markerfacecolor", "y",'dr');
surf(X1, X2, Y);
hold off;
xlabel(headers(1));
ylabel(headers(2));
zlabel(headers(3));
title(fstr);
grid on;
legend("Data points", "Model");
set(gca, "linewidth", 2, "fontsize", 20);

% Create a contour plot
figure(2);
contourf(X1, X2, Y);
colorbar;
xlabel(headers(1));
ylabel(headers(2));
title(fstr);
grid on;
set(gca, "linewidth", 2, "fontsize", 20)
endif
%--------------------------------------------------------------------------------


