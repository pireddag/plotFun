<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_working_08>>

<\body>
  \ \ <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  Tests the version of the plotting software which loads the function
  definitions from a file and uses sandboxed evaluation of the file contents;
  please adjust the path of the file arguments according to where you put
  them.

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
    <plotFun|./fundefs_09.scm>
  <|big-figure>
    The same functions of figure <reference|fig:example1> plotted with less
    points (default is 101) in a larger size.
  </big-figure>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
    <associate|preamble|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|1>>
    <associate|auto-3|<tuple|3|2>>
    <associate|fig:example1|<tuple|1|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Two parabolae, a Gaussian and a sinusoid. Line style, color and width
        have default values, and the size of the plot has the default value
        too.
      </surround>|<pageref|auto-1>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        A series of straight lines. For some of them we choose style, color
        and width. The size of the plot is set by the user.
      </surround>|<pageref|auto-2>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        The same functions of figure <reference|fig:example1> plotted with
        less points (default is 101) in a larger size.
      </surround>|<pageref|auto-3>>
    </associate>
  </collection>
</auxiliary>
