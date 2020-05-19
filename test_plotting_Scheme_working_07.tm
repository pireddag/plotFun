<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_working_07>>

<\body>
  \ <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  Tests the version of the plotting software which loads the function
  definitions from a file and uses sandboxed evaluation of the file contents;
  please adjust the path of the file arguments according to where you put
  them.

  <\big-figure>
    <plotFun|./fundefs_07.scm>
  <|big-figure>
    Two parabolae, a Gaussian and a sinusoid
  </big-figure>

  <\big-figure>
    <plotFun|./fundefs_08.scm>
  <|big-figure>
    A series of straight lines
  </big-figure>

  <\plot-output|<plot-curve|<around*|(|sin x|)>|-2|2>>
    \;
  </plot-output>
</body>

<\initial>
  <\collection>
    <associate|page-screen-margin|false>
    <associate|preamble|false>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-2|<tuple|2|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Two parabolae, a Gaussian and a sinusoid
      </surround>|<pageref|auto-1>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        A series of straight lines
      </surround>|<pageref|auto-2>>
    </associate>
  </collection>
</auxiliary>