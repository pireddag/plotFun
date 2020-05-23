<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_plugin|compact-list>>

<\body>
  \ \ <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  <with|ornament-shape|classic|<\framed>
    Tests the version of the plotting software which loads the function
    definitions from a file and uses sandboxed evaluation of the file
    contents; please adjust the path of the file arguments according to where
    you put them.
  </framed>>

  <\table-of-contents|toc>
    <vspace*|1fn><with|font-series|bold|math-font-series|bold|1<space|2spc>Syntax>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-1><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|2<space|2spc>Test
    files> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-2><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|3<space|2spc>Input>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-3><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|4<space|2spc>Security>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-4><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|5<space|2spc>Desirable
    features> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-5><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|6<space|2spc>Examples>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-6><vspace|0.5fn>
  </table-of-contents>

  <section|Syntax>

  The <code*|plotFun> command takes one arguments, the name of a file. The
  file contains the functions to be plotted, the range for each function,
  general plot options and additional options for each function (color,
  style, thickness, number of points); default options are substituted for
  missing options.

  The functions and their ranges are expressed as a list of association lists
  (one association list for each function)

  The function is expressed as a lambda in Scheme syntax (associated to the
  key <code*|"function">)

  example: <code*|(lambda (x) ( - (expt x 2) 2.))>

  the range as a list (associated to the key <code*|"range">)

  example: <code*|(-2. 2.)>

  Please refer to the example input files <code*|fundefs_07.scm>,
  <code*|fundefs_08.scm> and <code*|fundefs_09.scm> in the <code*|doc>
  directory.

  <section|Test files>

  A test file \ (<code*|`plotting_with_Scheme_plugin_examples.tm`>) together
  with its input files is in the <code*|/doc> directory. Its .pdf output
  (<code*|`plotting_with_Scheme_plugin_examples.pdf`>) is both in the
  <code*|/doc> and in the top directory.

  <section|Input>

  In the input file an association list (and only that) must be present.

  The association list contains the following keys

  <\itemize>
    <item><code*|"xLabel"> (string)

    <\itemize>
      <item>test
    </itemize>

    <item><code*|"yLabel"> (string)

    <item><code*|"title"> (string)

    <item><code*|"sizeX"> (double) [optional, default 9]

    <item><code*|"sizeY"> (double) [optional, default 6]

    <item><code*|"plotsList"> (list of association lists, see below)
  </itemize>

  The value of the entry with the key "plotsList" is the list of plots, which
  is a list of association lists. Each element of the list corresponds to one
  function; in each element (association list) there are the following keys:

  <\itemize>
    <item><code*|"function"> (a lambda expression)

    <item><code*|"range"> (a list of two doubles)

    <item><code*|"nPoints"> (positive integer) [optional, default 101]

    <item><code*|"color"> (either a name or an HTML code) [optional, defaults
    to the color list]

    <item><code*|"line-width"> (string containing a number and units)
    [optional, default <code*|"1.5ln">]

    <item><code*|"dash-style"> (string containing ones and zeros) [optional,
    default <code*|"11111">]
  </itemize>

  Please see test input files (in directory <code*|plotFun/doc>) for
  examples.

  <\framed>
    <\remark*>
      The input syntax (association list) is extremely finicky, an error
      makes the program fail and the error messages do not indicate that the
      input needs to be corrected. It is necessary to improve this part.
    </remark*>
  </framed>

  Possibly I will either change the syntax of the input file so that it is
  easier to type or will write a parser that will notify the user about
  incorrect syntax.

  <section|Security>

  I have added the <code*|:secure> keyword to the Scheme functions, so in
  order to run this macro in TeXmacs it is not anymore necessary to set the
  security level to "Accept all scripts"; the security level can be left to
  "Accept no scripts".

  Unsafe scripts could delete all the data on your hard drive. Since this
  TeXmacs package executes commands in a user-defined arbitrary file (the one
  specified in the argument to <code*|plotFun>), it is quite dangerous: you
  have to ensure that the file you specify as argument contains only safe
  code. I have tried to mitigate the danger by defining a "safe module" with
  "safe commands" (see \ this <hlink|message|https://www.mail-archive.com/guile-user@gnu.org/msg00963.html>
  in the Guile mailing list). I do not know how effective the technique is,
  so <strong|please be aware of what you put in the file you use as a macro
  argument>.

  The technique is as far as I understand the one suited to the Guile 1
  series - for the Guile 2/3 series (future <TeXmacs>) I have seen that
  another technique exists, based on the <code*|(ice-9 sandbox)> module; see
  this <hlink|message|https://www.mail-archive.com/guile-user@gnu.org/msg10788.html>
  in the Guile mailing list.

  I have tried to make this program safe: this said, <strong|one is
  responsible for making sure that his TeXmacs documents are running only
  safe scripts!>

  <section|Desirable features>

  The features marked with (present) are yet to be refined (result,
  implementation or both)

  <\itemize>
    <item> Optional user-selected

    <\itemize>
      <item> graph size (present)

      <\itemize>
        <item> This probably needs improvement in the placement of numbers
        and axis labels with shifts and not multiplications
      </itemize>

      <item> Axes labels (present) (not yet optional, has to be supplied)

      <item> Graph title (present) (not yet optional, has to be supplied)
    </itemize>

    <item> Optional user-selected for each plot

    <\itemize>
      <item> color (present)

      <item> line thickness (present)

      <item> line type (present)

      <item> number of points (present)
    </itemize>

    <item> User-selectable color lists

    <item> Exponential notation for large/small numbers

    <item> Error messages for wrong input

    <\itemize>
      <item> Optional comments in input file (to strip away line by line)
    </itemize>

    <item> Functions in standard notation

    <\itemize>
      <item> postpone
    </itemize>
  </itemize>

  <section|Examples>

  <\big-figure>
    <plotFun|./fundefs_07.scm>
  <|big-figure>
    Two parabolae, a Gaussian and a sinusoid. Line style, color and width
    have default values, and the size of the plot has the default value
    too.<label|fig:example1>
  </big-figure>

  <\big-figure>
    <plotFun|./fundefs_08.scm>
  <|big-figure>
    A series of straight lines. For some of them we choose style, color and
    width. The size of the plot is set by the user.
  </big-figure>

  <\big-figure>
    <plotFun|./fundefs_09.scm>\ 
  <|big-figure>
    The same functions of figure <reference|fig:example1> plotted with less
    points (default is 101) in a larger size.
  </big-figure>
</body>

<\initial>
  <\collection>
    <associate|page-medium|papyrus>
    <associate|page-screen-margin|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|1>>
    <associate|auto-3|<tuple|3|1>>
    <associate|auto-4|<tuple|4|2>>
    <associate|auto-5|<tuple|5|3>>
    <associate|auto-6|<tuple|6|3>>
    <associate|auto-7|<tuple|1|3>>
    <associate|auto-8|<tuple|2|4>>
    <associate|auto-9|<tuple|3|4>>
    <associate|fig:example1|<tuple|1|3>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Two parabolae, a Gaussian and a sinusoid. Line style, color and width
        have default values, and the size of the plot has the default value
        too.
      </surround>|<pageref|auto-7>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        A series of straight lines. For some of them we choose style, color
        and width. The size of the plot is set by the user.
      </surround>|<pageref|auto-8>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        The same functions of figure <reference|fig:example1> plotted with
        less points (default is 101) in a larger size.
      </surround>|<pageref|auto-9>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Syntax>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Test
      files> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Input>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Security>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Desirable
      features> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|6<space|2spc>Examples>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>