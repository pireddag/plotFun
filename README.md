# plotFun
Plot functions with native TeXmacs graphics.

The Scheme functions go in `.TeXmacs/progs/graphics/plotting/` (all lowercase!). I have already placed them in a directory with the right name and nesting, the tree `/graphics/plotting/` needs to be copied to the `prog` directory of TeXmacs.

Load the package plotFun

The `plotFun` command takes one arguments, the name of a file. The file contains the functions to be plotted, the range for each function, general plot options and additional options for each function (color, style, thickness); default options are subsituted for missing options.

The functions and their ranges are expressed as a list of association lists (one association list for each function)
The function is expressed as a lambda in Scheme syntax (associated to the key "function")

example: `(lambda (x) ( - (expt x 2) 2.))`

the range as a list (associated to the key "range")

example: `(-2. 2.)`

Please refer to the example input files `fundefs_07.scm` and `fundefs_08.scm`.

There is a test file and its pdf output (`test_plotting_Scheme_working_07.tm` and `test_plotting_Scheme_working_07.pdf`) in addition to the two input files

## Input

The input syntax (association list) is extremely finicky, an error makes the progam fail and the error messages do not indicate that the input needs to be corrected. It is necessary to improve this part.

## Security

In order to run this macro in TeXmacs it is necessary to set the security level to "Accept all scripts".

**One is then responsible for making sure that his TeXmacs documents are running only safe scripts!** 

Unsafe scripts could delete all the data on your hard drive.

Please see how to change TeXmacs security options in the TeXmacs manual (section 1, "User preferences", of the part "Configuring TeXmacs"). I am not writing it here so that a conscious effort on the part of the user is needed to change the setting.

Since this TeXmacs package executes commands in a user-defined arbitrary file (the one specified in the argument to `plotFun`), it is quite dangerous: you have to ensure that the file contains only safe code. I have tried to mitigate the danger by defining a "safe module" with "safe commands" (see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg00963.html) in the Guile maling list). I do not know how effective the technique is, so please be aware of what you put in the file you use as a macro argument.

The technique is as far as I understand the one suited to the Guile 1 series - for the Guile 2/3 series (future TeXmacs) I have seen that another technique exists, based on the `(ice-9 sandbox)` module; see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg10788.html) in the Guile maling list.

## Desirable features

 * Optional user-selected
     * graph size
         * This probably needs improvement in the placement of numbers and axis labels with shifts and not multiplications
 * Optional user-selected for each plot
     * color
     * line thickness
     * line type
     * number of points
 * User-selectable color lists
 * Exponential notation for large/small numbers
 * Error messages for wrong input
 * Functions in standard notation
     * postpone
 * Plot list of points as well
     * Probably needs code reorganization
 * Multiple panels
     * Probably needs code reorganization
     * Here modularity of Scheme could help



