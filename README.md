# plotFun
Plot functions with native TeXmacs graphics.

The Scheme functions go in `.TeXmacs/progs/Graphics/Plotting/`

Load the package plotFun

The `plotFun` command takes two arguments: the function, expressed as a lambda in Scheme syntax

example: (lambda (x) ( - (expt x 2) 2.))

the range on which we want the plot, without spaces (the parser is very simple and parses that only).

example: -2.,2.

The placement of the tick labels is done with a rough approximation (needs to be improved).

There is a test file and its pdf output (test_plotting_Scheme.tm and test_plotting_Scheme.pdf)
