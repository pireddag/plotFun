<TeXmacs|1.99.11>

<style|<tuple|generic|plotFun>>

<\body>
  <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  <\big-figure|<plotFun|(lambda (x) ( - (expt x 2) 2.))|-2.,2.>>
    Parabola
  </big-figure>

  <\big-figure|<plotFun|(lambda (x) (/ 3. (+ 1 (expt (* x 5) 2))))|-2.,2> >
    Gaussian
  </big-figure>

  <\big-figure|<plotFun|(lambda (x) (sin (* 5 x)))|-3.14,3.14>>
    Sinusoid
  </big-figure>

  <\big-figure|<plotFun|(lambda (x) ( - (expt (/ x 100) 2) 2.))|-20.,20.>>
    Parabola with a wider x-range and a smaller y-range
  </big-figure>

  <\big-figure|<plotFun|(lambda (x) ( - (expt (/ x .01) 2) 200.))|-.2,.2>>
    Parabola with a narrow x-range and a large y-range
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
    <associate|auto-1|<tuple|1|1|test_plotting_Scheme.tm>>
    <associate|auto-2|<tuple|2|1|test_plotting_Scheme.tm>>
    <associate|auto-3|<tuple|3|1|test_plotting_Scheme.tm>>
    <associate|auto-4|<tuple|4|2|test_plotting_Scheme.tm>>
    <associate|auto-5|<tuple|5|2|test_plotting_Scheme.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Parabola
      </surround>|<pageref|auto-1>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        Gaussian
      </surround>|<pageref|auto-2>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        Sinusoid
      </surround>|<pageref|auto-3>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|4>|>
        Parabola with a wider x-range and a smaller y-range
      </surround>|<pageref|auto-4>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|5>|>
        Parabola with a narrow x-range and a large y-range
      </surround>|<pageref|auto-5>>
    </associate>
  </collection>
</auxiliary>