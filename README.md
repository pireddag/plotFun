# plotFun
Plot functions with native TeXmacs graphics.

The Scheme functions go in `.TeXmacs/progs/graphics/plotting/` (all lowercase!). I have already placed them in a directory with the right name and nesting, the tree `/graphics/plotting/` needs to be copied to the `prog` directory of TeXmacs.

Load the package plotFun

The `plotFun` command takes two arguments: the function, expressed as a lambda in Scheme syntax

example: (lambda (x) ( - (expt x 2) 2.))

the range on which we want the plot, without spaces (the parser is very simple and parses that only).

example: -2.,2.

There is a test file and its pdf output (test_plotting_Scheme.tm and test_plotting_Scheme.pdf)

## Security

In order to run this macro in TeXmacs it is necessary to set the security level to "Accept all scripts".
**One is then responsible for making sure that his TeXmacs documents are running only safe scripts!** 
Unsafe scripts could delete all the data on your hard drive.
Please see how to change TeXmacs security options in the TeXmacs manual (section 1, "User preferences", of the part "Configuring TeXmacs"). I am not writing it here so that a conscious effort on the part of the user is needed to change the setting.



