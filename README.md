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

## Documentation and test files

The documentation (`.tm` and output `.pdf` files) is in the `/plotFun/doc` directory. The file `plotting_with_Scheme_plugin_documentation.tm` contains a description of the input files, examples and a list of desirable features. The input files for the examples are in the `doc` directory as well.
The dile `plotting_with_Scheme_plugin_examples.tm` contains just the examples; its `.pdf` output (`test_plotting_Scheme_working_07.pdf`) is in the top directory.

## Security

I have added the '':secure'' keyword to the Scheme functions, so in order to run this macro in TeXmacs it is not anymore necessary to set the security level to "Accept all scripts"; the security level can be left to "Accept no scripts".

Unsafe scripts could delete all the data on your hard drive. Since this TeXmacs package executes commands in a user-defined arbitrary file (the one specified in the argument to `plotFun`), it is quite dangerous: you have to ensure that the file you specify as argument contains only safe code. I have tried to mitigate the danger by defining a "safe module" with "safe commands" (see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg00963.html) in the Guile mailing list). I do not know how effective the technique is, so **please be aware of what you put in the file you use as a macro argument**.

The technique is as far as I understand the one suited to the Guile 1 series - for the Guile 2/3 series (future TeXmacs) I have seen that another technique exists, based on the `(ice-9 sandbox)` module; see  this [message](https://www.mail-archive.com/guile-user@gnu.org/msg10788.html) in the Guile mailing list.

I have tried to make this program safe: said this
**one is responsible for making sure that his TeXmacs documents are running only safe scripts!** 
