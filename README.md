# plotFun
Plot functions with native TeXmacs graphics.

Place the files in a subdirectory of the `plugin` by copying the `plotFun` directory into it. You can change the directory name. The plugin will appear in the plugin list of TeXmacs (Document -> Style -> Add package).

Load the package plotFun_plugin

The `plotFun` command takes one arguments, the name of a file. The file contains the functions to be plotted, the range for each function, general plot options and additional options for each function (color, style, thickness, number of points); default options are subsituted for missing options.

The functions and their ranges are expressed as a list of association lists (one association list for each function)
The function is expressed as a lambda in Scheme syntax (associated to the key "function")

example: `(lambda (x) ( - (expt x 2) 2.))`

the range as a list (associated to the key "range")

example: `(-2. 2.)`

Please refer to the example input files `fundefs_07.scm`, `fundefs_08.scm` and `fundefs_09.scm` in the `doc` directory.

## Test files

A test file  (`test_plotting_Scheme_plugin.tm`) together with its input files is in the `doc` directory. The .pdf output (`test_plotting_Scheme_working_07.pdf`) is in the top directory.

## Input

The input syntax (association list) is extremely finicky, an error makes the program fail and the error messages do not indicate that the input needs to be corrected. It is necessary to improve this part.

## Security

I have added the '':secure'' keyword to the Scheme functions, so in order to run this macro in TeXmacs it is not anymore necessary to set the security level to "Accept all scripts"; the security level can be left to "Accept no scripts".

Unsafe scripts could delete all the data on your hard drive. Since this TeXmacs package executes commands in a user-defined arbitrary file (the one specified in the argument to `plotFun`), it is quite dangerous: you have to ensure that the file you specify as argument contains only safe code. I have tried to mitigate the danger by defining a "safe module" with "safe commands" (see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg00963.html) in the Guile mailing list). I do not know how effective the technique is, so **please be aware of what you put in the file you use as a macro argument**.

The technique is as far as I understand the one suited to the Guile 1 series - for the Guile 2/3 series (future TeXmacs) I have seen that another technique exists, based on the `(ice-9 sandbox)` module; see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg10788.html) in the Guile maling list.

I have tried to make this program safe: said this
**one is responsible for making sure that his TeXmacs documents are running only safe scripts!** 

## Desirable features

The features marked with (present) are yet to be refined (result, implementation or both)

 * Optional user-selected
     * graph size (present)
         * This probably needs improvement in the placement of numbers and axis labels with shifts and not multiplications
     * Axes labels (present) (not yet optional, has to be supplied)
     * Graph title (present) (not yet optional, has to be supplied)
 * Optional user-selected for each plot
     * color (present)
     * line thickness (present)
     * line type (present)
     * number of points (present)
 * User-selectable color lists
 * Exponential notation for large/small numbers
 * Error messages for wrong input
     * Optional comments in input file (to strip away line by line)
 * Functions in standard notation
     * postpone
 * Plot list of points as well
     * Probably needs code reorganization
 * Multiple panels
     * Probably needs code reorganization
     * Here modularity of Scheme could help



