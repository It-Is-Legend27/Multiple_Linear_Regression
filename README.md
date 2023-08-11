# Multiple_Linear_Regression
Octave Program that performs multiple linear regression analysis on data from CSV files.

Basic Directions:
- Run the Octave Script
- Select CSV-formatted input file
- Select / Create TXT file for saving results

## CSV Input File
The input file must be CSV-formatted in a similar manner to example1.csv and example2.csv files
in this repository. The input file consists of a header row for the labels of the 1 to N number of
independent variables and the single dependent variables. The rows after are all comma-separated
values following the order of the labels in the header row.

## 2-D and 3-D Graphing
Only data consisting of up to two independent variables can be graphed, but the program
will still perform multiple linear regression analysis and provide the equation of best
fit for the data, regardless. If the data has one independent variable, the equation of
best fit will be graphed on a 2D plot. For data with two indepdendent variables,
the equation of best fit will be plotted on a 3D surface plot, and a 2D contour plot
will also be show.
