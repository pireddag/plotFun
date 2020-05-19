<TeXmacs|1.99.12>

<style|<tuple|generic|old-dots|plotFun_working_06>>

<\body>
  \ <doc-data|<doc-title|Plotting functions with <TeXmacs> graphics and
  Scheme>>

  Tests the version of the plotting software which loads the function
  definitions from a file and uses sandboxed evaluation of the file contents;
  please adjust the path of the file arguments according to where you put
  them.

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

  <\big-figure>
    <plotFun|./fundefs_06.scm>
  <|big-figure>
    A series of straight lines
  </big-figure>

  <with|gr-mode|<tuple|edit|line>|gr-frame|<tuple|scale|1cm|<tuple|0.5gw|0.5gh>>|gr-geometry|<tuple|geometry|1par|0.6par>|gr-color|#007f00|<graphics||<line|<point|-5.90654|2.58847>|<point|2.19089826696653|-0.466744939806853>|<point|4.22059796269348|0.986076200555629>>|<with|color|#007f00|<line|<point|-5.79971|-0.85132>|<point|-1.41983066543194|-1.79139105701812>>>>>

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
    <associate|auto-3|<tuple|3|?>>
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

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        A series of straight lines
      </surround>|<pageref|auto-3>>
    </associate>
  </collection>
</auxiliary>