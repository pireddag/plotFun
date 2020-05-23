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
    <associate|auto-1|<tuple|1|1|test_plotting_Scheme_plugin.tm>>
    <associate|auto-2|<tuple|2|1|test_plotting_Scheme_plugin.tm>>
    <associate|auto-3|<tuple|3|1|test_plotting_Scheme_plugin.tm>>
    <associate|auto-4|<tuple|3|2|test_plotting_Scheme_plugin.tm>>
    <associate|auto-5|<tuple|5|2|test_plotting_Scheme_plugin.tm>>
    <associate|auto-6|<tuple|6|3|test_plotting_Scheme_plugin.tm>>
    <associate|auto-7|<tuple|1|3|test_plotting_Scheme_plugin.tm>>
    <associate|auto-8|<tuple|2|3|test_plotting_Scheme_plugin.tm>>
    <associate|auto-9|<tuple|3|4|test_plotting_Scheme_plugin.tm>>
    <associate|fig:example1|<tuple|1|3|test_plotting_Scheme_plugin.tm>>
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