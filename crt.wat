(module
  (import "env" "getCanvasWidth" (func $getCanvasWidth (result i32)))
  (import "env" "getCanvasHeight" (func $getCanvasHeight (result i32)))
  (import "env" "renderFrame" (func $renderFrame))
  (import "env" "getMouseX" (func $getMouseX (result i32)))
  (import "env" "getMouseY" (func $getMouseY (result i32)))
  (import "env" "getTime" (func $getTime (result i32)))
  (import "env" "getDegaussKey" (func $getDegaussKey (result i32)))
  (import "env" "getSpaceKey" (func $getSpaceKey (result i32)))
  (import "env" "getSmackActive" (func $getSmackActive (result i32)))
  (import "env" "getSmackX" (func $getSmackX (result i32)))
  (import "env" "getSmackY" (func $getSmackY (result i32)))
  (import "env" "getSmackTime" (func $getSmackTime (result i32)))
  (import "env" "getMouseVelocity" (func $getMouseVelocity (result i32)))
  (import "env" "openURL" (func $openURL (param i32 i32)))
  (import "env" "getLastChar" (func $getLastChar (result i32)))
  (import "env" "clearLastChar" (func $clearLastChar))
  (import "env" "getTheme" (func $getTheme (result i32)))
  (import "env" "getMagnetEnabled" (func $getMagnetEnabled (result i32)))
  (import "env" "getSignalPresent" (func $getSignalPresent (result i32)))
  (import "env" "getCableQuality" (func $getCableQuality (result i32)))
  (import "env" "getCableLength" (func $getCableLength (result i32)))
  (import "env" "getActivePort" (func $getActivePort (result i32)))

  (memory (export "memory") 800)

  (global $pixelBufferPtr (mut i32) (i32.const 65536))
  (global $contentBufferPtr (mut i32) (i32.const 800000))
  (global $phosphorBufferPtr (mut i32) (i32.const 1200000))
  (global $externalFramebufferPtr (mut i32) (i32.const 1600000))
  (global $width (mut i32) (i32.const 320))
  (global $height (mut i32) (i32.const 240))
  (global $beamY (mut i32) (i32.const 0))
  (global $beamX (mut i32) (i32.const 0))
  (global $pixelsPerFrame (mut i32) (i32.const 76800))
  (global $linesPerFrame (mut i32) (i32.const 240))
  (global $frameCount (mut i32) (i32.const 0))
  (global $degaussActive (mut i32) (i32.const 0))
  (global $degaussFrame (mut i32) (i32.const 0))
  (global $inputBufferPtr (mut i32) (i32.const 6000))
  (global $inputLen (mut i32) (i32.const 0))
  (global $cursorIsPointer (mut i32) (i32.const 0))
  (global $clickedLink (mut i32) (i32.const 0))
  (global $clickFrame (mut i32) (i32.const 0))
  (global $rollingScanline (mut i32) (i32.const 0))
  (global $caretBlink (mut i32) (i32.const 0))
  (global $warmupFrames (mut i32) (i32.const 0))
  (global $convergenceErrorR (mut i32) (i32.const 2))
  (global $convergenceErrorB (mut i32) (i32.const -2))
  (global $geometricDistortion (mut i32) (i32.const 0))

  (data (i32.const 0)
    "\00\00\00\00\00\00\00\00"
    "\18\18\18\18\18\00\18\00"
    "\36\36\36\00\00\00\00\00"
    "\36\7F\36\36\7F\36\00\00"
    "\0C\3E\03\1E\30\1F\0C\00"
    "\00\63\33\18\0C\66\63\00"
    "\1C\36\1C\6E\3B\33\6E\00"
    "\06\06\03\00\00\00\00\00"
    "\18\0C\06\06\06\0C\18\00"
    "\06\0C\18\18\18\0C\06\00"
    "\00\66\3C\FF\3C\66\00\00"
    "\00\0C\0C\3F\0C\0C\00\00"
    "\00\00\00\00\00\0C\0C\06"
    "\00\00\00\3F\00\00\00\00"
    "\00\00\00\00\00\0C\0C\00"
    "\60\30\18\0C\06\03\01\00"
    "\3E\63\73\7B\6F\67\3E\00"
    "\0C\0E\0C\0C\0C\0C\3F\00"
    "\1E\33\30\1C\06\33\3F\00"
    "\1E\33\30\1C\30\33\1E\00"
    "\38\3C\36\33\7F\30\78\00"
    "\3F\03\1F\30\30\33\1E\00"
    "\1C\06\03\1F\33\33\1E\00"
    "\3F\33\30\18\0C\0C\0C\00"
    "\1E\33\33\1E\33\33\1E\00"
    "\1E\33\33\3E\30\18\0E\00"
    "\00\0C\0C\00\00\0C\0C\00"
    "\00\0C\0C\00\00\0C\0C\06"
    "\18\0C\06\03\06\0C\18\00"
    "\00\00\3F\00\00\3F\00\00"
    "\06\0C\18\30\18\0C\06\00"
    "\1E\33\30\18\0C\00\0C\00"
    "\3E\63\7B\7B\7B\03\1E\00"
    "\0C\1E\33\33\3F\33\33\00"
    "\3F\66\66\3E\66\66\3F\00"
    "\3C\66\03\03\03\66\3C\00"
    "\1F\36\66\66\66\36\1F\00"
    "\7F\46\16\1E\16\46\7F\00"
    "\7F\46\16\1E\16\06\0F\00"
    "\3C\66\03\03\73\66\7C\00"
    "\33\33\33\3F\33\33\33\00"
    "\1E\0C\0C\0C\0C\0C\1E\00"
    "\78\30\30\30\33\33\1E\00"
    "\67\66\36\1E\36\66\67\00"
    "\0F\06\06\06\46\66\7F\00"
    "\63\77\7F\7F\6B\63\63\00"
    "\63\67\6F\7B\73\63\63\00"
    "\1C\36\63\63\63\36\1C\00"
    "\3F\66\66\3E\06\06\0F\00"
    "\1E\33\33\33\3B\1E\38\00"
    "\3F\66\66\3E\36\66\67\00"
    "\1E\33\07\0E\38\33\1E\00"
    "\3F\2D\0C\0C\0C\0C\1E\00"
    "\33\33\33\33\33\33\3F\00"
    "\33\33\33\33\33\1E\0C\00"
    "\63\63\63\6B\7F\77\63\00"
    "\C3\C3\66\3C\66\C3\C3\00"
    "\33\33\33\1E\0C\0C\1E\00"
    "\7F\63\31\18\4C\66\7F\00"
  )

  (func $abs (param $x i32) (result i32)
    local.get $x
    i32.const 0
    i32.lt_s
    if (result i32)
      i32.const 0
      local.get $x
      i32.sub
    else
      local.get $x
    end
  )

  (func $min (param $a i32) (param $b i32) (result i32)
    local.get $a
    local.get $b
    i32.lt_s
    if (result i32)
      local.get $a
    else
      local.get $b
    end
  )

  (func $max (param $a i32) (param $b i32) (result i32)
    local.get $a
    local.get $b
    i32.gt_s
    if (result i32)
      local.get $a
    else
      local.get $b
    end
  )

  (func $sampleExternal (param $x i32) (param $y i32) (param $channel i32) (result i32)
    (local $sampleX i32)
    (local $offset i32)

    local.get $x
    local.set $sampleX

    local.get $channel
    i32.const 0
    i32.eq
    if
      local.get $sampleX
      global.get $convergenceErrorR
      i32.add
      local.set $sampleX
    end

    local.get $channel
    i32.const 2
    i32.eq
    if
      local.get $sampleX
      global.get $convergenceErrorB
      i32.add
      local.set $sampleX
    end

    local.get $sampleX
    i32.const 0
    i32.lt_s
    if
      i32.const 0
      return
    end

    local.get $sampleX
    global.get $width
    i32.ge_s
    if
      i32.const 0
      return
    end

    local.get $y
    i32.const 0
    i32.lt_s
    if
      i32.const 0
      return
    end

    local.get $y
    global.get $height
    i32.ge_s
    if
      i32.const 0
      return
    end

    local.get $y
    global.get $width
    i32.mul
    local.get $sampleX
    i32.add
    i32.const 4
    i32.mul
    global.get $externalFramebufferPtr
    i32.add
    local.get $channel
    i32.add
    i32.load8_u
  )

  (func $putPixel (param $x i32) (param $y i32) (param $r i32) (param $g i32) (param $b i32) (param $a i32)
    (local $offset i32)

    local.get $x
    i32.const 0
    i32.lt_s
    if return end
    local.get $x
    global.get $width
    i32.ge_s
    if return end
    local.get $y
    i32.const 0
    i32.lt_s
    if return end
    local.get $y
    global.get $height
    i32.ge_s
    if return end

    local.get $y
    global.get $width
    i32.mul
    local.get $x
    i32.add
    i32.const 4
    i32.mul
    global.get $contentBufferPtr
    i32.add
    local.set $offset

    local.get $offset
    local.get $r
    i32.store8
    local.get $offset
    i32.const 1
    i32.add
    local.get $g
    i32.store8
    local.get $offset
    i32.const 2
    i32.add
    local.get $b
    i32.store8
    local.get $offset
    i32.const 3
    i32.add
    local.get $a
    i32.store8
  )

  (func $drawChar (param $char i32) (param $x i32) (param $y i32) (param $scale i32)
    (local $fontOffset i32)
    (local $row i32)
    (local $col i32)
    (local $byte i32)
    (local $bit i32)
    (local $px i32)
    (local $py i32)
    (local $sx i32)
    (local $sy i32)

    local.get $char
    i32.const 8
    i32.mul
    local.set $fontOffset

    i32.const 0
    local.set $row

    (block $rowBreak
      (loop $rowLoop
        local.get $row
        i32.const 8
        i32.ge_u
        br_if $rowBreak

        local.get $fontOffset
        local.get $row
        i32.add
        i32.load8_u
        local.set $byte

        i32.const 0
        local.set $col

        (block $colBreak
          (loop $colLoop
            local.get $col
            i32.const 8
            i32.ge_u
            br_if $colBreak

            local.get $byte
            local.get $col
            i32.shr_u
            i32.const 1
            i32.and
            local.set $bit

            local.get $bit
            i32.const 1
            i32.eq
            if
              i32.const 0
              local.set $sy
              (block $syBreak
                (loop $syLoop
                  local.get $sy
                  local.get $scale
                  i32.ge_u
                  br_if $syBreak

                  i32.const 0
                  local.set $sx
                  (block $sxBreak
                    (loop $sxLoop
                      local.get $sx
                      local.get $scale
                      i32.ge_u
                      br_if $sxBreak

                      local.get $x
                      local.get $col
                      local.get $scale
                      i32.mul
                      i32.add
                      local.get $sx
                      i32.add
                      local.set $px

                      local.get $y
                      local.get $row
                      local.get $scale
                      i32.mul
                      i32.add
                      local.get $sy
                      i32.add
                      local.set $py

                      local.get $px
                      local.get $py
                      i32.const 0
                      call $getThemeColor
                      i32.const 1
                      call $getThemeColor
                      i32.const 2
                      call $getThemeColor
                      i32.const 255
                      call $putPixel

                      local.get $sx
                      i32.const 1
                      i32.add
                      local.set $sx
                      br $sxLoop
                    )
                  )

                  local.get $sy
                  i32.const 1
                  i32.add
                  local.set $sy
                  br $syLoop
                )
              )
            end

            local.get $col
            i32.const 1
            i32.add
            local.set $col
            br $colLoop
          )
        )

        local.get $row
        i32.const 1
        i32.add
        local.set $row
        br $rowLoop
      )
    )
  )

  (func $getThemeColor (param $channel i32) (result i32)
    (local $theme i32)
    call $getTheme
    local.set $theme

    local.get $theme
    i32.const 0
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 180
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 200
        else
          i32.const 220
        end
      end
      return
    end

    local.get $theme
    i32.const 1
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 255
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 200
        else
          i32.const 100
        end
      end
      return
    end

    local.get $theme
    i32.const 2
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 0
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 255
        else
          i32.const 0
        end
      end
      return
    end

    local.get $theme
    i32.const 3
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 255
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 255
        else
          i32.const 200
        end
      end
      return
    end

    local.get $channel
    i32.const 0
    i32.eq
    if (result i32)
      i32.const 100
    else
      local.get $channel
      i32.const 1
      i32.eq
      if (result i32)
        i32.const 100
      else
        i32.const 255
      end
    end
  )

  (func $getThemeBgColor (param $channel i32) (result i32)
    (local $theme i32)
    call $getTheme
    local.set $theme

    local.get $theme
    i32.const 0
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 8
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 10
        else
          i32.const 12
        end
      end
      return
    end

    local.get $theme
    i32.const 1
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 0
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 0
        else
          i32.const 255
        end
      end
      return
    end

    local.get $theme
    i32.const 2
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 0
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 8
        else
          i32.const 0
        end
      end
      return
    end

    local.get $theme
    i32.const 3
    i32.eq
    if
      local.get $channel
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 0
      else
        local.get $channel
        i32.const 1
        i32.eq
        if (result i32)
          i32.const 0
        else
          i32.const 168
        end
      end
      return
    end

    local.get $channel
    i32.const 0
    i32.eq
    if (result i32)
      i32.const 0
    else
      local.get $channel
      i32.const 1
      i32.eq
      if (result i32)
        i32.const 0
      else
        i32.const 42
      end
    end
  )

  (func $checkLinkHover (param $mx i32) (param $my i32) (result i32)
    local.get $mx
    i32.const 20
    i32.ge_u
    local.get $mx
    i32.const 116
    i32.le_u
    i32.and
    local.get $my
    i32.const 60
    i32.ge_u
    i32.and
    local.get $my
    i32.const 76
    i32.le_u
    i32.and
    if (result i32)
      i32.const 1
    else
      local.get $mx
      i32.const 20
      i32.ge_u
      local.get $mx
      i32.const 36
      i32.le_u
      i32.and
      local.get $my
      i32.const 90
      i32.ge_u
      i32.and
      local.get $my
      i32.const 106
      i32.le_u
      i32.and
      if (result i32)
        i32.const 2
      else
        i32.const 0
      end
    end
  )

  (func (export "handleClick") (param $mx i32) (param $my i32)
    (local $linkId i32)
    local.get $mx
    local.get $my
    call $checkLinkHover
    local.set $linkId

    local.get $linkId
    i32.const 0
    i32.gt_u
    if
      local.get $linkId
      global.set $clickedLink
      i32.const 0
      global.set $clickFrame
    end

    local.get $linkId
    i32.const 1
    i32.eq
    if
      i32.const 5200
      i32.const 31
      call $openURL
    end

    local.get $linkId
    i32.const 2
    i32.eq
    if
      i32.const 5250
      i32.const 27
      call $openURL
    end
  )

  ;; coffee time
  (func $drawCoffeeCup (param $baseX i32) (param $baseY i32)
    (local $r i32)
    (local $g i32)
    (local $b i32)
    (local $x i32)

    i32.const 0
    call $getThemeColor
    local.set $r
    i32.const 1
    call $getThemeColor
    local.set $g
    i32.const 2
    call $getThemeColor
    local.set $b

    local.get $baseX
    i32.const 4
    i32.add
    local.get $baseY
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 4
    i32.add
    local.get $baseY
    i32.const 1
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 8
    i32.add
    local.get $baseY
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 8
    i32.add
    local.get $baseY
    i32.const 1
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 12
    i32.add
    local.get $baseY
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 12
    i32.add
    local.get $baseY
    i32.const 1
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    i32.const 2
    local.set $x
    (block $topBreak
      (loop $topLoop
        local.get $x
        i32.const 15
        i32.ge_u
        br_if $topBreak
        local.get $baseX
        local.get $x
        i32.add
        local.get $baseY
        i32.const 4
        i32.add
        local.get $r local.get $g local.get $b i32.const 255 call $putPixel
        local.get $x
        i32.const 1
        i32.add
        local.set $x
        br $topLoop
      )
    )

    local.get $baseX
    i32.const 1
    i32.add
    local.get $baseY
    i32.const 5
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 15
    i32.add
    local.get $baseY
    i32.const 5
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    local.get $baseY
    i32.const 6
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 16
    i32.add
    local.get $baseY
    i32.const 6
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 17
    i32.add
    local.get $baseY
    i32.const 6
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    local.get $baseY
    i32.const 7
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 18
    i32.add
    local.get $baseY
    i32.const 7
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    local.get $baseY
    i32.const 8
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 19
    i32.add
    local.get $baseY
    i32.const 8
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    local.get $baseY
    i32.const 9
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 19
    i32.add
    local.get $baseY
    i32.const 9
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    local.get $baseY
    i32.const 10
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 18
    i32.add
    local.get $baseY
    i32.const 10
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 1
    i32.add
    local.get $baseY
    i32.const 11
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 17
    i32.add
    local.get $baseY
    i32.const 11
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 2
    i32.add
    local.get $baseY
    i32.const 12
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 16
    i32.add
    local.get $baseY
    i32.const 12
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 3
    i32.add
    local.get $baseY
    i32.const 13
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 4
    i32.add
    local.get $baseY
    i32.const 13
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 14
    i32.add
    local.get $baseY
    i32.const 13
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 15
    i32.add
    local.get $baseY
    i32.const 13
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel

    local.get $baseX
    i32.const 18
    i32.add
    local.get $baseY
    i32.const 7
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 19
    i32.add
    local.get $baseY
    i32.const 8
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 19
    i32.add
    local.get $baseY
    i32.const 9
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 19
    i32.add
    local.get $baseY
    i32.const 10
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
    local.get $baseX
    i32.const 18
    i32.add
    local.get $baseY
    i32.const 11
    i32.add
    local.get $r local.get $g local.get $b i32.const 255 call $putPixel
  )

  ;; pointy thing render
  (func $drawCursor (param $x i32) (param $y i32)
    (local $row i32)
    (local $col i32)
    (local $byte i32)
    (local $bit i32)
    (local $px i32)
    (local $py i32)
    (local $cursorData i32)

    global.get $cursorIsPointer
    if (result i32)
      i32.const 5100
    else
      i32.const 5000
    end
    local.set $cursorData

    i32.const 0
    local.set $row

    (block $rowBreak
      (loop $rowLoop
        local.get $row
        i32.const 16
        i32.ge_u
        br_if $rowBreak

        local.get $cursorData
        local.get $row
        i32.const 4
        i32.mul
        i32.add
        i32.load8_u
        local.set $byte

        i32.const 0
        local.set $col

        (block $colBreak
          (loop $colLoop
            local.get $col
            i32.const 8
            i32.ge_u
            br_if $colBreak

            local.get $byte
            i32.const 7
            local.get $col
            i32.sub
            i32.shr_u
            i32.const 1
            i32.and
            local.set $bit

            local.get $bit
            i32.const 1
            i32.eq
            if
              local.get $x
              local.get $col
              i32.add
              local.set $px

              local.get $y
              local.get $row
              i32.add
              local.set $py

              local.get $px
              local.get $py
              i32.const 255
              i32.const 255
              i32.const 255
              i32.const 255
              call $putPixel
            end

            local.get $col
            i32.const 1
            i32.add
            local.set $col
            br $colLoop
          )
        )

        local.get $row
        i32.const 1
        i32.add
        local.set $row
        br $rowLoop
      )
    )
  )

  (func $drawText (param $textStart i32) (param $len i32) (param $x i32) (param $y i32) (param $scale i32)
    (local $i i32)
    (local $char i32)
    (local $charWidth i32)

    i32.const 8
    local.get $scale
    i32.mul
    i32.const 1
    i32.add
    local.set $charWidth

    i32.const 0
    local.set $i

    (block $break
      (loop $loop
        local.get $i
        local.get $len
        i32.ge_u
        br_if $break

        local.get $textStart
        local.get $i
        i32.add
        i32.load8_u
        local.set $char

        local.get $char
        i32.const 32
        i32.ge_u
        if
          local.get $char
          i32.const 32
          i32.sub
          local.get $x
          local.get $i
          local.get $charWidth
          i32.mul
          i32.add
          local.get $y
          local.get $scale
          call $drawChar
        end

        local.get $i
        i32.const 1
        i32.add
        local.set $i
        br $loop
      )
    )
  )

  (data (i32.const 4096) "HUDSONGRAEME\\")
  (data (i32.const 4200) "Software Electron Beam Renderer")
  (data (i32.const 4300) "Press D - Degauss    SPACE - VSync Fail    Click - Smack")
  (data (i32.const 4450) "Move mouse fast for interference")

  (data (i32.const 5000)
    "\80\00\00\00"
    "\c0\00\00\00"
    "\e0\00\00\00"
    "\f0\00\00\00"
    "\f8\00\00\00"
    "\fc\00\00\00"
    "\fe\00\00\00"
    "\ff\00\00\00"
    "\ff\80\00\00"
    "\fc\00\00\00"
    "\dc\00\00\00"
    "\8e\00\00\00"
    "\0e\00\00\00"
    "\07\00\00\00"
    "\07\00\00\00"
    "\02\00\00\00"
  )

  (data (i32.const 5100)
    "\00\00\00\00"
    "\0c\00\00\00"
    "\1a\00\00\00"
    "\1a\00\00\00"
    "\1a\00\00\00"
    "\1b\80\00\00"
    "\1b\6c\00\00"
    "\db\6c\00\00"
    "\da\48\00\00"
    "\6a\48\00\00"
    "\0c\48\00\00"
    "\00\48\00\00"
    "\00\70\00\00"
    "\00\00\00\00"
    "\00\00\00\00"
    "\00\00\00\00"
  )

  (data (i32.const 5200) "https://github.com/hudsongraeme")
  (data (i32.const 5250) "https://x.com/hudsongrae_me")
  (data (i32.const 5400) "Press 1-5 for themes  Type anything  Click links")
  (data (i32.const 5500) "GITHUB")
  (data (i32.const 5510) "X")
  (data (i32.const 5600) "$$$$$$$$$$$$[[[$$$$$$$$$$$$$$$$$$$$$$$$[]$}[[]$)?$$$$$$$$$$$$$$$$$$$$$$][[$[[[$[[[-$$$$$$$$$$$$$$$$$$$$$?[]$][[{$[[$$$$$$$$$$$$$$$$$$$$$$][[$}[]$][[{$$$$$$$$$$$$$$$$$$$$$[[[$}[[{$}[[t$$$$$$$$$$$$$$$$$$$$${[[$}[}$[[{$$$$$$$$$$$$$$$$$$$$$QJUJUUUUJUUUC0$$$$$$$$$$$$$$$$OUUUU\\:tUcrt|)1{{1)|txzUUUUUUUY$$$$$$$$$$UUUYj[I;::::::::::::::::::::::::;l}rUUUY$$$$$$$YUt:::::;:!)u0qmOQQLQQQLLLQ0Yj{l:;::::;jU&$$$$$$$YUY|r0wwm0QLLLLLLLLLLLLLLLLLLLLLLLQQU/tUUX$UUUL$$$$YUj/XUUUC00QLLQQLLLLLLLLLLQQLLLLCJUUYz[/UUUUYYUUUJ$$$JUn}}__[)tnXUUUUUUUUUUUUUUznt1[_fUU$$$UUU$$$Uc}}?nU$$$$UU$$$UY{}{~UU$$$$UU$$$UUr{}_fUU$$$$UUU$$$UY{}}YU$$$$UUU$$$$UUz{}]cUL$$$JUUU$$$$$JUn{}?]($$YUUUU$$$$$$CUv{}?~cUUUUUUUUC$$$$$$$$QUY(}}~[UU$$$$$$$$$$UUUUUUUUX)}?+XUUUUUUUUb$$$$$0UUUzn/||||||fz|{1[~-fUYf||||||\\rcUUUU$$$UYffft||||||||||/XUUUUUUUUUUUUUUX/||||||||||||||nUY$$UUYujffffft/||||||||||||||||||||||||||||||||\\jcUU$$$$UUUUUXurjjfffffffffffftttttttffffjjjrncUUUUUU$$$$$$$$JUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUz$$$$$$")
  (data (i32.const 7000) "HELP")
  (data (i32.const 7010) "CLS")
  (data (i32.const 7020) "VER")
  (data (i32.const 7030) "TIME")
  (data (i32.const 7040) "DIR")
  (data (i32.const 7050) ">")
  (data (i32.const 7052) "_")
  (data (i32.const 7100) "NO SIGNAL")

  (func $processCommand
    (local $i i32)
    (local $match i32)

    global.get $inputLen
    i32.const 4
    i32.eq
    if
      i32.const 1
      local.set $match
      i32.const 0
      local.set $i
      (block $helpBreak
        (loop $helpLoop
          local.get $i
          i32.const 4
          i32.ge_u
          br_if $helpBreak
          global.get $inputBufferPtr
          local.get $i
          i32.add
          i32.load8_u
          i32.const 7000
          local.get $i
          i32.add
          i32.load8_u
          i32.ne
          if
            i32.const 0
            local.set $match
            br $helpBreak
          end
          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $helpLoop
        )
      )
      local.get $match
      if
        i32.const 1
        global.set $degaussActive
        i32.const 0
        global.set $degaussFrame
      end

      i32.const 1
      local.set $match
      i32.const 0
      local.set $i
      (block $timeBreak
        (loop $timeLoop
          local.get $i
          i32.const 4
          i32.ge_u
          br_if $timeBreak
          global.get $inputBufferPtr
          local.get $i
          i32.add
          i32.load8_u
          i32.const 7030
          local.get $i
          i32.add
          i32.load8_u
          i32.ne
          if
            i32.const 0
            local.set $match
            br $timeBreak
          end
          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $timeLoop
        )
      )
    end

    global.get $inputLen
    i32.const 3
    i32.eq
    if
      i32.const 1
      local.set $match
      i32.const 0
      local.set $i
      (block $clsBreak
        (loop $clsLoop
          local.get $i
          i32.const 3
          i32.ge_u
          br_if $clsBreak
          global.get $inputBufferPtr
          local.get $i
          i32.add
          i32.load8_u
          i32.const 7010
          local.get $i
          i32.add
          i32.load8_u
          i32.ne
          if
            i32.const 0
            local.set $match
            br $clsBreak
          end
          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $clsLoop
        )
      )
      local.get $match
      if
        i32.const 1
        global.set $degaussActive
        i32.const 0
        global.set $degaussFrame
      end

      i32.const 1
      local.set $match
      i32.const 0
      local.set $i
      (block $verBreak
        (loop $verLoop
          local.get $i
          i32.const 3
          i32.ge_u
          br_if $verBreak
          global.get $inputBufferPtr
          local.get $i
          i32.add
          i32.load8_u
          i32.const 7020
          local.get $i
          i32.add
          i32.load8_u
          i32.ne
          if
            i32.const 0
            local.set $match
            br $verBreak
          end
          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $verLoop
        )
      )

      i32.const 1
      local.set $match
      i32.const 0
      local.set $i
      (block $dirBreak
        (loop $dirLoop
          local.get $i
          i32.const 3
          i32.ge_u
          br_if $dirBreak
          global.get $inputBufferPtr
          local.get $i
          i32.add
          i32.load8_u
          i32.const 7040
          local.get $i
          i32.add
          i32.load8_u
          i32.ne
          if
            i32.const 0
            local.set $match
            br $dirBreak
          end
          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $dirLoop
        )
      )
    end

    i32.const 0
    global.set $inputLen
  )

  (func (export "init")
    call $getCanvasWidth
    i32.const 320
    i32.lt_u
    if
      call $getCanvasWidth
      global.set $width
    else
      i32.const 320
      global.set $width
    end

    call $getCanvasHeight
    i32.const 240
    i32.lt_u
    if
      call $getCanvasHeight
      global.set $height
    else
      i32.const 240
      global.set $height
    end
  )

  (func (export "getPixelBuffer") (result i32)
    global.get $pixelBufferPtr
  )

  (func (export "getExternalFramebuffer") (result i32)
    global.get $externalFramebufferPtr
  )

  ;; adjust the refresh rate
  (func (export "setHz") (param $hz i32)
    local.get $hz
    i32.const 1280
    i32.mul
    global.set $pixelsPerFrame

    local.get $hz
    i32.const 4
    i32.mul
    global.set $linesPerFrame
  )

  ;; sick fx
  (func (export "checkDegauss")
    call $getDegaussKey
    if
      i32.const 1
      global.set $degaussActive
      i32.const 0
      global.set $degaussFrame
    end
  )

  (func (export "resetScanline")
    (local $i i32)
    (local $max i32)

    i32.const 0
    global.set $beamY
    i32.const 0
    global.set $beamX

    global.get $width
    global.get $height
    i32.mul
    i32.const 4
    i32.mul
    local.set $max

    i32.const 0
    local.set $i

    (block $break
      (loop $loop
        local.get $i
        local.get $max
        i32.ge_u
        br_if $break

        global.get $pixelBufferPtr
        local.get $i
        i32.add
        i32.const 0
        i32.store8

        global.get $contentBufferPtr
        local.get $i
        i32.add
        i32.const 0
        i32.store8

        global.get $phosphorBufferPtr
        local.get $i
        i32.add
        i32.const 0
        i32.store8

        local.get $i
        i32.const 1
        i32.add
        local.set $i
        br $loop
      )
    )
  )

  (func (export "render")
    (local $x i32)
    (local $y i32)
    (local $pixelIndex i32)
    (local $beamPixel i32)
    (local $offset i32)
    (local $contentOffset i32)
    (local $phosphorOffset i32)
    (local $r i32)
    (local $g i32)
    (local $b i32)
    (local $mx i32)
    (local $my i32)
    (local $char i32)
    (local $temp i32)

    global.get $frameCount
    i32.const 1
    i32.add
    global.set $frameCount

    global.get $rollingScanline
    i32.const 1
    i32.add
    i32.const 240
    i32.rem_u
    global.set $rollingScanline

    global.get $warmupFrames
    i32.const 1800
    i32.lt_u
    if
      global.get $warmupFrames
      i32.const 1
      i32.add
      global.set $warmupFrames

      i32.const 2
      global.get $warmupFrames
      i32.const 900
      i32.div_u
      i32.sub
      global.set $convergenceErrorR

      i32.const -2
      global.get $warmupFrames
      i32.const 1200
      i32.div_u
      i32.add
      global.set $convergenceErrorB
    end

    call $getMouseX
    local.set $mx
    call $getMouseY
    local.set $my

    global.get $degaussActive
    if
      global.get $degaussFrame
      i32.const 1
      i32.add
      global.set $degaussFrame

      global.get $degaussFrame
      i32.const 120
      i32.gt_u
      if
        i32.const 0
        global.set $degaussActive
      end
    end

    i32.const 0
    call $getThemeBgColor
    local.set $r
    i32.const 1
    call $getThemeBgColor
    local.set $g
    i32.const 2
    call $getThemeBgColor
    local.set $b

    i32.const 0
    local.set $pixelIndex
    (block $bgBreak
      (loop $bgLoop
        local.get $pixelIndex
        i32.const 76800
        i32.ge_u
        br_if $bgBreak

        local.get $pixelIndex
        i32.const 4
        i32.mul
        global.get $contentBufferPtr
        i32.add
        local.set $offset

        local.get $offset
        local.get $r
        i32.store8
        local.get $offset
        i32.const 1
        i32.add
        local.get $g
        i32.store8
        local.get $offset
        i32.const 2
        i32.add
        local.get $b
        i32.store8
        local.get $offset
        i32.const 3
        i32.add
        i32.const 255
        i32.store8

        local.get $pixelIndex
        i32.const 1
        i32.add
        local.set $pixelIndex
        br $bgLoop
      )
    )

    call $getSignalPresent
    if
      i32.const 0
      local.set $pixelIndex
      (block $extBreak
        (loop $extLoop
          local.get $pixelIndex
          i32.const 76800
          i32.ge_u
          br_if $extBreak

          local.get $pixelIndex
          global.get $width
          i32.rem_u
          local.set $x

          local.get $pixelIndex
          global.get $width
          i32.div_u
          local.set $y

          local.get $x
          i32.const 160
          i32.sub
          local.set $temp

          local.get $y
          i32.const 120
          i32.sub
          local.set $offset

          local.get $temp
          local.get $temp
          i32.mul
          local.get $offset
          local.get $offset
          i32.mul
          i32.add
          global.get $geometricDistortion
          i32.mul
          i32.const 40000
          i32.div_s
          local.set $offset

          local.get $x
          local.get $offset
          local.get $temp
          i32.mul
          i32.const 160
          i32.div_s
          i32.add
          local.set $x

          local.get $y
          i32.const 120
          i32.sub
          local.set $temp

          local.get $y
          local.get $offset
          local.get $temp
          i32.mul
          i32.const 120
          i32.div_s
          i32.add
          local.set $y

          local.get $x
          local.get $y
          i32.const 0
          call $sampleExternal
          local.set $r

          local.get $x
          local.get $y
          i32.const 1
          call $sampleExternal
          local.set $g

          local.get $x
          local.get $y
          i32.const 2
          call $sampleExternal
          local.set $b

          call $getCableQuality
          i32.const 80
          i32.lt_u
          if
            local.get $pixelIndex
            i32.const 17
            i32.mul
            global.get $frameCount
            i32.add
            i32.const 255
            i32.rem_u
            i32.const 100
            call $getCableQuality
            i32.sub
            i32.mul
            i32.const 50
            i32.div_u
            local.set $offset

            local.get $offset
            local.get $r
            i32.add
            i32.const 0
            call $max
            i32.const 255
            call $min
            local.set $r

            local.get $offset
            local.get $g
            i32.add
            i32.const 0
            call $max
            i32.const 255
            call $min
            local.set $g

            local.get $offset
            local.get $b
            i32.add
            i32.const 0
            call $max
            i32.const 255
            call $min
            local.set $b
          end

          local.get $pixelIndex
          i32.const 0
          i32.gt_u
          if
            call $getCableQuality
            i32.const 70
            i32.lt_u
            if
              local.get $pixelIndex
              i32.const 1
              i32.sub
              i32.const 4
              i32.mul
              global.get $externalFramebufferPtr
              i32.add
              local.set $offset

              local.get $r
              local.get $offset
              i32.load8_u
              i32.add
              i32.const 2
              i32.div_u
              local.set $r

              local.get $g
              local.get $offset
              i32.const 1
              i32.add
              i32.load8_u
              i32.add
              i32.const 2
              i32.div_u
              local.set $g

              local.get $b
              local.get $offset
              i32.const 2
              i32.add
              i32.load8_u
              i32.add
              i32.const 2
              i32.div_u
              local.set $b
            end
          end

          call $getActivePort
          i32.const 1
          i32.eq
          if
            local.get $y
            i32.const 3
            i32.rem_u
            i32.const 0
            i32.eq
            if
              call $getCableLength
              i32.const 15
              i32.gt_u
              if
                local.get $g
                i32.const 2
                i32.sub
                i32.const 0
                call $max
                local.set $g

                local.get $r
                local.get $x
                i32.const 2
                i32.rem_u
                i32.sub
                i32.const 0
                call $max
                local.set $r

                local.get $b
                local.get $x
                i32.const 2
                i32.rem_u
                i32.add
                i32.const 255
                call $min
                local.set $b
              end
            end
          end

          local.get $pixelIndex
          global.get $width
          i32.rem_u
          local.set $temp

          local.get $temp
          i32.const 8
          i32.lt_s
          if
            i32.const 0
            local.set $r
            i32.const 0
            local.set $g
            i32.const 0
            local.set $b
          end

          local.get $temp
          i32.const 312
          i32.gt_s
          if
            i32.const 0
            local.set $r
            i32.const 0
            local.set $g
            i32.const 0
            local.set $b
          end

          local.get $pixelIndex
          global.get $width
          i32.div_u
          local.set $temp

          local.get $temp
          i32.const 6
          i32.lt_s
          if
            i32.const 0
            local.set $r
            i32.const 0
            local.set $g
            i32.const 0
            local.set $b
          end

          local.get $temp
          i32.const 234
          i32.gt_s
          if
            i32.const 0
            local.set $r
            i32.const 0
            local.set $g
            i32.const 0
            local.set $b
          end

          local.get $x
          local.get $y
          local.get $r
          local.get $g
          local.get $b
          i32.const 255
          call $putPixel

          local.get $pixelIndex
          i32.const 1
          i32.add
          local.set $pixelIndex
          br $extLoop
        )
      )
    else
      i32.const 7100
      i32.const 9
      i32.const 120
      i32.const 110
      i32.const 2
      call $drawText
    end

    i32.const 4096
    i32.const 13
    i32.const 20
    i32.const 20
    i32.const 2
    call $drawText

    i32.const 110
    i32.const 36
    call $drawCoffeeCup

    global.get $clickedLink
    i32.const 1
    i32.eq
    global.get $clickFrame
    i32.const 10
    i32.lt_u
    i32.and
    if
      global.get $clickFrame
      i32.const 1
      i32.add
      global.set $clickFrame
    else
      global.get $clickedLink
      i32.const 1
      i32.eq
      if
        i32.const 0
        global.set $clickedLink
      end
      i32.const 5500
      i32.const 6
      i32.const 20
      i32.const 60
      i32.const 2
      call $drawText
      i32.const 0
      call $getThemeColor
      local.set $r
      i32.const 1
      call $getThemeColor
      local.set $g
      i32.const 2
      call $getThemeColor
      local.set $b
      i32.const 20
      local.set $x
      (block $underlineBreak
        (loop $underlineLoop
          local.get $x
          i32.const 116
          i32.gt_u
          br_if $underlineBreak
          local.get $x
          i32.const 76
          local.get $r
          local.get $g
          local.get $b
          i32.const 255
          call $putPixel
          local.get $x
          i32.const 1
          i32.add
          local.set $x
          br $underlineLoop
        )
      )
    end

    global.get $clickedLink
    i32.const 2
    i32.eq
    global.get $clickFrame
    i32.const 10
    i32.lt_u
    i32.and
    if
      global.get $clickFrame
      i32.const 1
      i32.add
      global.set $clickFrame
    else
      global.get $clickedLink
      i32.const 2
      i32.eq
      if
        i32.const 0
        global.set $clickedLink
      end
      i32.const 5510
      i32.const 1
      i32.const 20
      i32.const 90
      i32.const 2
      call $drawText
      i32.const 0
      call $getThemeColor
      local.set $r
      i32.const 1
      call $getThemeColor
      local.set $g
      i32.const 2
      call $getThemeColor
      local.set $b
      i32.const 20
      local.set $x
      (block $underlineBreak2
        (loop $underlineLoop2
          local.get $x
          i32.const 36
          i32.gt_u
          br_if $underlineBreak2
          local.get $x
          i32.const 106
          local.get $r
          local.get $g
          local.get $b
          i32.const 255
          call $putPixel
          local.get $x
          i32.const 1
          i32.add
          local.set $x
          br $underlineLoop2
        )
      )
    end

    local.get $mx
    local.get $my
    call $checkLinkHover
    i32.const 0
    i32.gt_u
    if
      i32.const 1
      global.set $cursorIsPointer
    else
      i32.const 0
      global.set $cursorIsPointer
    end

    i32.const 7050
    i32.const 1
    i32.const 5
    i32.const 225
    i32.const 1
    call $drawText

    global.get $inputBufferPtr
    global.get $inputLen
    i32.const 13
    i32.const 225
    i32.const 1
    call $drawText

    global.get $frameCount
    i32.const 30
    i32.rem_u
    i32.const 15
    i32.lt_u
    if
      i32.const 7052
      i32.const 1
      i32.const 13
      global.get $inputLen
      i32.const 8
      i32.mul
      i32.add
      i32.const 225
      i32.const 1
      call $drawText
    end

    global.get $beamX
    global.get $beamY
    i32.const 240
    i32.const 255
    i32.const 255
    i32.const 200
    call $putPixel

    local.get $mx
    local.get $my
    call $drawCursor

    call $getLastChar
    local.set $char
    local.get $char
    i32.const 0
    i32.gt_u
    if
      local.get $char
      i32.const 13
      i32.eq
      if
        call $processCommand
        call $clearLastChar
      else
        local.get $char
        i32.const 8
        i32.eq
        if
          global.get $inputLen
          i32.const 0
          i32.gt_u
          if
            global.get $inputLen
            i32.const 1
            i32.sub
            global.set $inputLen
          end
          call $clearLastChar
        else
          global.get $inputLen
          i32.const 100
          i32.lt_u
          if
            global.get $inputBufferPtr
            global.get $inputLen
            i32.add
            local.get $char
            i32.store8

            global.get $inputLen
            i32.const 1
            i32.add
            global.set $inputLen

            call $clearLastChar
          end
        end
      end
    end

    ;; screen glow fades away slowly
    i32.const 0
    local.set $pixelIndex
    (block $decayBreak
      (loop $decayLoop
        local.get $pixelIndex
        i32.const 76800
        i32.ge_u
        br_if $decayBreak

        local.get $pixelIndex
        i32.const 4
        i32.mul
        global.get $phosphorBufferPtr
        i32.add
        local.set $phosphorOffset

        local.get $phosphorOffset
        local.get $phosphorOffset
        i32.load8_u
        i32.const 95
        i32.mul
        i32.const 100
        i32.div_u
        i32.store8

        local.get $phosphorOffset
        i32.const 1
        i32.add
        local.tee $offset
        local.get $offset
        i32.load8_u
        i32.const 95
        i32.mul
        i32.const 100
        i32.div_u
        i32.store8

        local.get $phosphorOffset
        i32.const 2
        i32.add
        local.tee $offset
        local.get $offset
        i32.load8_u
        i32.const 95
        i32.mul
        i32.const 100
        i32.div_u
        i32.store8

        local.get $pixelIndex
        i32.const 1
        i32.add
        local.set $pixelIndex
        br $decayLoop
      )
    )

    global.get $beamY
    global.get $width
    i32.mul
    global.get $beamX
    i32.add
    local.set $beamPixel

    ;; we got that beam
    i32.const 0
    local.set $pixelIndex
    (block $beamBreak
      (loop $beamLoop
        local.get $pixelIndex
        global.get $pixelsPerFrame
        i32.ge_u
        br_if $beamBreak

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        local.tee $offset
        i32.const 76800
        i32.ge_u
        br_if $beamBreak

        local.get $offset
        i32.const 4
        i32.mul
        local.set $offset

        local.get $offset
        global.get $contentBufferPtr
        i32.add
        local.set $contentOffset

        local.get $offset
        global.get $phosphorBufferPtr
        i32.add
        local.set $phosphorOffset

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        global.get $width
        i32.div_u
        local.tee $y

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        global.get $width
        i32.rem_u
        local.tee $x

        local.get $mx
        i32.const 30
        i32.lt_u
        if (result i32)
          local.get $x
          local.get $y
          i32.const 120
          i32.sub
          call $abs
          i32.const 20
          i32.div_u
          i32.sub
        else
          local.get $mx
          i32.const 290
          i32.gt_u
          if (result i32)
            local.get $x
            local.get $y
            i32.const 120
            i32.sub
            call $abs
            i32.const 20
            i32.div_u
            i32.add
          else
            local.get $x
          end
        end
        local.tee $x

        local.get $y
        global.get $rollingScanline
        i32.sub
        call $abs
        i32.const 3
        i32.lt_u
        if (result i32)
          local.get $x
          global.get $frameCount
          i32.const 3
          i32.rem_u
          i32.const 2
          i32.sub
          i32.add
        else
          local.get $x
        end
        local.set $x

        ;; wobbly screen
        call $getSpaceKey
        if
          local.get $x
          global.get $frameCount
          i32.const 7
          i32.rem_u
          i32.const 3
          i32.sub
          local.get $y
          i32.const 13
          i32.rem_u
          i32.mul
          i32.add
          local.set $x

          local.get $y
          global.get $frameCount
          i32.const 11
          i32.rem_u
          i32.const 5
          i32.sub
          i32.add
          local.set $y

          local.get $y
          i32.const 40
          i32.rem_u
          i32.const 2
          i32.lt_u
          if
            local.get $x
            global.get $frameCount
            i32.const 17
            i32.rem_u
            i32.const 60
            i32.sub
            i32.add
            local.set $x
          end
        end

        local.get $x
        i32.const 0
        i32.lt_s
        if
          local.get $x
          i32.const 320
          i32.add
          local.set $x
        end
        local.get $x
        i32.const 320
        i32.ge_s
        if
          local.get $x
          i32.const 320
          i32.sub
          local.set $x
        end

        local.get $y
        i32.const 0
        i32.lt_s
        if
          local.get $y
          i32.const 240
          i32.add
          local.set $y
        end
        local.get $y
        i32.const 240
        i32.ge_s
        if
          local.get $y
          i32.const 240
          i32.sub
          local.set $y
        end

        ;; magnet goes brrr
        call $getMagnetEnabled
        if
          local.get $x
          local.get $mx
          i32.sub
          local.set $x
          local.get $y
          local.get $my
          i32.sub
          local.set $y

          local.get $x
          local.get $x
          i32.mul
          local.get $y
          local.get $y
          i32.mul
          i32.add
          local.tee $offset
          i32.const 1600
          i32.lt_u
          if
            local.get $x
            i32.const 8
            i32.div_s
            local.get $beamPixel
            local.get $pixelIndex
            i32.add
            i32.add
            local.set $offset

            local.get $offset
            i32.const 0
            i32.ge_s
            local.get $offset
            i32.const 76800
            i32.lt_u
            i32.and
            if
              local.get $offset
              i32.const 4
              i32.mul
              global.get $contentBufferPtr
              i32.add
              local.set $contentOffset
            else
              local.get $beamPixel
              local.get $pixelIndex
              i32.add
              i32.const 4
              i32.mul
              global.get $contentBufferPtr
              i32.add
              local.set $contentOffset
            end
          else
            local.get $beamPixel
            local.get $pixelIndex
            i32.add
            i32.const 4
            i32.mul
            global.get $contentBufferPtr
            i32.add
            local.set $contentOffset
          end
        else
          local.get $y
          i32.const 320
          i32.mul
          local.get $x
          i32.add
          i32.const 4
          i32.mul
          global.get $contentBufferPtr
          i32.add
          local.set $contentOffset
        end

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        i32.const 4
        i32.mul
        local.set $offset

        local.get $contentOffset
        i32.load8_u
        local.set $r
        local.get $contentOffset
        i32.const 1
        i32.add
        i32.load8_u
        local.set $g
        local.get $contentOffset
        i32.const 2
        i32.add
        i32.load8_u
        local.set $b

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        global.get $width
        i32.div_u
        global.get $rollingScanline
        i32.sub
        call $abs
        i32.const 2
        i32.lt_u
        if
          local.get $r
          i32.const 40
          i32.add
          i32.const 255
          call $min
          local.set $r
          local.get $g
          i32.const 40
          i32.add
          i32.const 255
          call $min
          local.set $g
          local.get $b
          i32.const 40
          i32.add
          i32.const 255
          call $min
          local.set $b
        end

        local.get $beamPixel
        local.get $pixelIndex
        i32.add
        i32.const 2
        i32.rem_u
        i32.const 0
        i32.eq
        if
          local.get $r
          i32.const 250
          i32.mul
          i32.const 256
          i32.div_u
          local.set $r
          local.get $g
          i32.const 250
          i32.mul
          i32.const 256
          i32.div_u
          local.set $g
          local.get $b
          i32.const 250
          i32.mul
          i32.const 256
          i32.div_u
          local.set $b
        end

        local.get $r
        local.get $g
        i32.add
        local.get $b
        i32.add
        i32.const 150
        i32.gt_u
        if
          local.get $offset
          i32.const 4
          i32.sub
          i32.const 0
          i32.ge_s
          if
            local.get $offset
            i32.const 4
            i32.sub
            global.get $phosphorBufferPtr
            i32.add
            local.tee $x
            local.get $x
            i32.load8_u
            local.get $r
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 1
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $g
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 2
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $b
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
          end

          local.get $offset
          i32.const 4
          i32.add
          i32.const 307200
          i32.lt_u
          if
            local.get $offset
            i32.const 4
            i32.add
            global.get $phosphorBufferPtr
            i32.add
            local.tee $x
            local.get $x
            i32.load8_u
            local.get $r
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 1
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $g
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 2
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $b
            i32.const 4
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
          end

          local.get $offset
          i32.const 1280
          i32.sub
          i32.const 0
          i32.ge_s
          if
            local.get $offset
            i32.const 1280
            i32.sub
            global.get $phosphorBufferPtr
            i32.add
            local.tee $x
            local.get $x
            i32.load8_u
            local.get $r
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 1
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $g
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 2
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $b
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
          end

          local.get $offset
          i32.const 1280
          i32.add
          i32.const 307200
          i32.lt_u
          if
            local.get $offset
            i32.const 1280
            i32.add
            global.get $phosphorBufferPtr
            i32.add
            local.tee $x
            local.get $x
            i32.load8_u
            local.get $r
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 1
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $g
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
            local.get $x
            i32.const 2
            i32.add
            local.tee $y
            local.get $y
            i32.load8_u
            local.get $b
            i32.const 5
            i32.div_u
            i32.add
            i32.const 255
            call $min
            i32.store8
          end
        end

        local.get $phosphorOffset
        local.get $r
        local.get $r
        i32.const 10
        i32.gt_u
        if (result i32)
          i32.const 1
        else
          i32.const 0
        end
        i32.sub
        i32.store8
        local.get $phosphorOffset
        i32.const 1
        i32.add
        local.get $g
        i32.store8
        local.get $phosphorOffset
        i32.const 2
        i32.add
        local.get $b
        local.get $b
        i32.const 10
        i32.gt_u
        if (result i32)
          i32.const 1
        else
          i32.const 0
        end
        i32.add
        i32.const 255
        call $min
        i32.store8
        local.get $phosphorOffset
        i32.const 3
        i32.add
        i32.const 255
        i32.store8

        local.get $pixelIndex
        i32.const 1
        i32.add
        local.set $pixelIndex
        br $beamLoop
      )
    )

    i32.const 0
    local.set $pixelIndex
    (block $copyBreak
      (loop $copyLoop
        local.get $pixelIndex
        i32.const 76800
        i32.ge_u
        br_if $copyBreak

        local.get $pixelIndex
        i32.const 4
        i32.mul
        local.set $offset

        local.get $offset
        global.get $pixelBufferPtr
        i32.add
        local.set $x

        local.get $offset
        global.get $phosphorBufferPtr
        i32.add
        local.set $y

        local.get $x
        local.get $y
        i32.load
        i32.store

        local.get $pixelIndex
        i32.const 1
        i32.add
        local.set $pixelIndex
        br $copyLoop
      )
    )

    global.get $beamX
    global.get $pixelsPerFrame
    i32.add
    local.set $x

    local.get $x
    global.get $width
    i32.ge_u
    if
      global.get $beamY
      global.get $linesPerFrame
      i32.add
      local.set $y

      local.get $y
      global.get $height
      i32.ge_u
      if
        i32.const 0
        global.set $beamY
        i32.const 0
        global.set $beamX
      else
        local.get $y
        global.set $beamY
        i32.const 0
        global.set $beamX
      end
    else
      local.get $x
      global.set $beamX
    end

    call $renderFrame
  )
)
