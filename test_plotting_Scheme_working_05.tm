<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_working_05>>

<\body>
  <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  Tests the version of the plotting software which loads the function
  definitions from a file and uses sandboxed evaluation of the file contents.
  Please adjust the file paths in the arguments according to where you place them

  <\big-figure>
    <plotFun|./fundefs_03.scm>

    \;
  <|big-figure>
    Parabola
  </big-figure>

  <\big-figure>
    <plotFun|./fundefs_05.scm>
  <|big-figure>
    Two parabolae, a Gaussian and a sinusoid
  </big-figure>

  <section*|Errors with the sandboxed evaluation of Guile 2.2>

  \;

  \ Backtrace:

  \ \ \ \ \ \ \ \ \ \ \ 5 (apply-smob/1 #\<less\>catch-closure
  556f1209a560\<gtr\>)

  \ \ \ \ \ \ \ \ \ \ \ 4 (apply-smob/1 #\<less\>catch-closure
  556f1763f5a0\<gtr\>)

  \ \ \ \ \ \ \ \ \ \ \ 3 (apply-smob/1 #\<less\>catch-closure
  556f1763f540\<gtr\>)

  In ice-9/eval.scm:

  \ \ \ 191:27 \ 2 (_ #f)

  \ \ \ 223:20 \ 1 (proc #\<less\>directory (guile-user) 556f12139140\<gtr\>)

  In unknown file:

  \ \ \ \ \ \ \ \ \ \ \ 0 (%resolve-variable (7 . plotFun) #\<less\>directory
  (guile-use\<ldots\>\<gtr\>)

  \;

  ERROR: In procedure %resolve-variable:

  Unbound variable: plotFun

  \;

  [3]+ \ Done \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ TEXMACS_PATH=$PWD/TeXmacs
  TeXmacs/bin/texmacs.bin

  \;
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
    <associate|auto-3|<tuple|2|1>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Parabola
      </surround>|<pageref|auto-1>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        Two parabolae, a Gaussian and a sinusoid
      </surround>|<pageref|auto-2>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Errors
      with the sandboxed evaluation of Guile 2.2>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>
