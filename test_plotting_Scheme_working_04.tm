<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_working_04>>

<\body>
  <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  Tests the version of the plotting software which loads the function
  definitions from a file and uses sandboxed evaluation of the file contents

  <\big-figure>
    <plotFun|/home/giovanni/test/test TeXmacs/2 - Test/Test grafica
    TeXmacs/fundefs_03.scm>

    \;
  <|big-figure>
    Parabola
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
    <associate|auto-2|<tuple|1|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Parabola
      </surround>|<pageref|auto-1>>
    </associate>
  </collection>
</auxiliary>