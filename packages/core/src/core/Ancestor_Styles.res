module Make = (Config: Ancestor_Config.T) => {
  let createBreakpointSize = device => `${device->Config.sizeByBreakpoints->Belt.Int.toString}px`

  let mediaQuery = (current, device: Config.keyOfBreakpoints, styles) =>
    `
    ${current}
    @media (min-width: ${device->createBreakpointSize}) {
      ${styles}
    }
  `

  let filterEmptyValues = values =>
    values->Js.Array2.reduce((values, (breakpointName, breakpointValue)) => {
      switch breakpointValue {
      | None => values
      | Some(breakpointValue) => values->Js.Array2.concat([(breakpointName, breakpointValue)])
      }
    }, [])

  let sortBySize = ((first, _), (second, _)) => {
    Config.sizeByBreakpoints(first) - Config.sizeByBreakpoints(second)
  }

  let mergeStyles = (cssKey, stringify, styles, (breakpointName, breakpointValue)) =>
    mediaQuery(styles, breakpointName, `${cssKey}: ${breakpointValue->stringify};`)

  /**
   * Creates responsive styles for responsive props.
   * It's used to create responsive props in components like Box or Stack.
   * Check out Ancestor_Stack.res to see more.
   */
  let createResponsiveProp = (~prop, ~defaultStyles="", transform) => {
    switch prop {
    | None => defaultStyles
    | Some(values) =>
      values
      ->Config.encode
      ->filterEmptyValues
      ->Js.Array2.sortInPlaceWith(sortBySize)
      ->Js.Array2.reduce((currentStyles, (breakpoint, value)) => {
        mediaQuery(currentStyles, breakpoint, transform(value))
      }, "")
    }
  }

  let createResponsiveValue = (cssKey, maybeCssValues, stringify) =>
    maybeCssValues->Belt.Option.map(values =>
      values
      ->Config.encode
      ->filterEmptyValues
      ->Js.Array2.sortInPlaceWith(sortBySize)
      ->Belt.Array.reduce("", mergeStyles(cssKey, stringify))
    )

  module Css = AncestorCss.Make(
    {
      type breakpoints = Config.keyOfBreakpoints
      let sizeByBreakpoints = Config.sizeByBreakpoints
    },
    {
      type colors = Config.colors
      let colors = Config.colors
    },
    {
      type spacing = Config.spacing
      let spacing = Config.spacing
    },
    {
      type radius = Config.radius
      let radius = Config.radius
    },
    {
      type zIndex = Config.zIndex
      let zIndex = Config.zIndex
    },
  )

  module RulesCmp = Belt.Id.MakeComparable({
    type t = Config.keyOfBreakpoints
    let cmp = (a, b) => Pervasives.compare(a, b)
  })

  let addRule = (mapper, prop, maybeValues) =>
    switch maybeValues {
    | None => mapper
    | Some(values) => values->Config.encode->Js.Array2.reduce((mapper, (breakpoint, maybeValue)) =>
        maybeValue
        ->Belt.Option.map(prop)
        ->Belt.Option.map(v => [v])
        ->Belt.Option.map(rules =>
          switch mapper->Belt.Map.get(breakpoint) {
          | None => mapper->Belt.Map.set(breakpoint, rules)
          | Some(existingRules) => {
              let updatedRules = existingRules->Js.Array2.concat(rules)
              mapper->Belt.Map.set(breakpoint, updatedRules)
            }
          }
        )
        ->Belt.Option.getWithDefault(mapper)
      , mapper)
    }

  let createResponsiveStyles = (
    ~borderRadius=?,
    ~borderTLRadius=?,
    ~borderTRRadius=?,
    ~borderBLRadius=?,
    ~borderBRRadius=?,
    ~borderStyle=?,
    ~borderColor=?,
    ~borderWidth=?,
    ~borderRightStyle=?,
    ~borderLeftStyle=?,
    ~borderTopStyle=?,
    ~borderBottomStyle=?,
    ~borderRightColor=?,
    ~borderLeftColor=?,
    ~borderTopColor=?,
    ~borderBottomColor=?,
    ~borderRightWidth=?,
    ~borderLeftWidth=?,
    ~borderTopWidth=?,
    ~borderBottomWidth=?,
    ~border=?,
    ~borderRight=?,
    ~borderLeft=?,
    ~borderTop=?,
    ~borderBottom=?,
    ~bgColor=?,
    ~bgSize=?,
    ~bgPosition=?,
    ~bgImage=?,
    ~color=?,
    ~display=?,
    ~justifyContent=?,
    ~flexDirection=?,
    ~alignItems=?,
    ~flexBasis=?,
    ~flexWrap=?,
    ~flexGrow=?,
    ~alignContent=?,
    ~alignSelf=?,
    ~justifySelf=?,
    ~flexFlow as _=?,
    ~gap=?,
    ~p=?,
    ~py=?,
    ~px=?,
    ~pt=?,
    ~pb=?,
    ~pl=?,
    ~pr=?,
    ~m=?,
    ~mx=?,
    ~my=?,
    ~mt=?,
    ~mb=?,
    ~ml=?,
    ~mr=?,
    ~textAlign=?,
    ~fontFamily=?,
    ~fontWeight=?,
    ~fontSize=?,
    ~letterSpacing=?,
    ~lineHeight=?,
    ~width=?,
    ~height=?,
    ~minW=?,
    ~minH=?,
    ~maxW=?,
    ~maxH=?,
    ~position=?,
    ~top=?,
    ~bottom=?,
    ~left=?,
    ~right=?,
    ~zIndex=?,
    ~boxSizing=?,
    ~overflow=?,
    ~overflowX=?,
    ~overflowY=?,
    ~cursor=?,
    ~visibility=?,
    ~listStyleType=?,
    ~listStylePosition=?,
    ~listStyleImage=?,
    ~listStyle=?,
    ~outlineStyle=?,
    ~outline=?,
    ~textDecorationStyle=?,
    ~textDecorationLine=?,
    ~textDecoration=?,
    ~transform=?,
    // Support for transition
    ~transition=?,
    ~transitionProperty=?,
    ~transitionDelay=?,
    ~transitionDuration=?,
    ~transitionTimingFunction=?,
    ~transitions=?,
    // Support for pseudo
    ~_hover=?,
    ~_focus=?,
    ~_active=?,
    ~_focusWithin=?,
    ~_focusVisible=?,
    ~_disabled=?,
    ~_before=?,
    ~_after=?,
    ~_even=?,
    ~_odd=?,
    ~_first=?,
    ~_last=?,
    ~_notFirst=?,
    ~_notLast=?,
    (),
  ) => {
    let rules =
      Belt.Map.make(~id=module(RulesCmp))
      ->addRule(Css.color, color)
      ->addRule(Css.backgroundColor, bgColor)
      // Margin
      ->addRule(Css.margin, m)
      ->addRule(Css.marginBottom, my)
      ->addRule(Css.marginTop, my)
      ->addRule(Css.marginRight, mx)
      ->addRule(Css.marginLeft, mx)
      ->addRule(Css.marginTop, mt)
      ->addRule(Css.marginBottom, mb)
      ->addRule(Css.marginRight, mr)
      ->addRule(Css.marginLeft, ml)
      // Padding
      ->addRule(Css.padding, p)
      ->addRule(Css.paddingBottom, py)
      ->addRule(Css.paddingTop, py)
      ->addRule(Css.paddingRight, px)
      ->addRule(Css.paddingLeft, px)
      ->addRule(Css.paddingTop, pt)
      ->addRule(Css.paddingBottom, pb)
      ->addRule(Css.paddingRight, pr)
      ->addRule(Css.paddingLeft, pl)
      ->addRule(Css.zIndex, zIndex)
      // Border Radius
      ->addRule(Css.borderRadius, borderRadius)
      ->addRule(Css.borderTopLeftRadius, borderTLRadius)
      ->addRule(Css.borderTopRightRadius, borderTRRadius)
      ->addRule(Css.borderBottomLeftRadius, borderBLRadius)
      ->addRule(Css.borderBottomRightRadius, borderBRRadius)
      // Border
      ->addRule(Css.borderStyle, borderStyle)
      ->addRule(Css.borderColor, borderColor)
      ->addRule(Css.borderWidth, borderWidth)
      ->addRule(Css.borderRightStyle, borderRightStyle)
      ->addRule(Css.borderLeftStyle, borderLeftStyle)
      ->addRule(Css.borderTopStyle, borderTopStyle)
      ->addRule(Css.borderBottomStyle, borderBottomStyle)
      ->addRule(Css.borderRightColor, borderRightColor)
      ->addRule(Css.borderLeftColor, borderLeftColor)
      ->addRule(Css.borderTopColor, borderTopColor)
      ->addRule(Css.borderBottomColor, borderBottomColor)
      ->addRule(Css.borderRightWidth, borderRightWidth)
      ->addRule(Css.borderLeftWidth, borderLeftWidth)
      ->addRule(Css.borderTopWidth, borderTopWidth)
      ->addRule(Css.borderBottomWidth, borderBottomWidth)
      ->addRule(((size, style, color)) => Css.border(size, style, color), border)
      ->addRule(((size, style, color)) => Css.borderRight(size, style, color), borderRight)
      ->addRule(((size, style, color)) => Css.borderLeft(size, style, color), borderLeft)
      ->addRule(((size, style, color)) => Css.borderTop(size, style, color), borderTop)
      ->addRule(((size, style, color)) => Css.borderBottom(size, style, color), borderBottom)
      ->addRule(Css.backgroundSize, bgSize)
      ->addRule(Css.backgroundPosition, bgPosition)
      ->addRule(Css.backgroundImage, bgImage)
      // Flex
      ->addRule(Css.display, display)
      ->addRule(Css.justifyContent, justifyContent)
      ->addRule(Css.flexDirection, flexDirection)
      ->addRule(Css.alignItems, alignItems)
      ->addRule(Css.flexBasis, flexBasis)
      ->addRule(Css.flexWrap, flexWrap)
      ->addRule(Css.flexGrow, flexGrow)
      ->addRule(Css.alignContent, alignContent)
      ->addRule(Css.alignSelf, alignSelf)
      ->addRule(Css.justifySelf, justifySelf)
      ->addRule(Css.gap, gap)
      // Others
      ->addRule(Css.textAlign, textAlign)
      ->addRule(Css.fontFamily, fontFamily)
      ->addRule(Css.fontWeight, fontWeight)
      ->addRule(Css.fontSize, fontSize)
      ->addRule(Css.letterSpacing, letterSpacing)
      ->addRule(Css.lineHeight, lineHeight)
      ->addRule(Css.width, width)
      ->addRule(Css.height, height)
      ->addRule(Css.minWidth, minW)
      ->addRule(Css.minHeight, minH)
      ->addRule(Css.maxWidth, maxW)
      ->addRule(Css.maxHeight, maxH)
      ->addRule(Css.position, position)
      ->addRule(Css.top, top)
      ->addRule(Css.bottom, bottom)
      ->addRule(Css.left, left)
      ->addRule(Css.right, right)
      ->addRule(Css.boxSizing, boxSizing)
      ->addRule(Css.overflow, overflow)
      ->addRule(Css.overflowX, overflowX)
      ->addRule(Css.overflowY, overflowY)
      ->addRule(Css.cursor, cursor)
      ->addRule(Css.visibility, visibility)
      ->addRule(Css.listStyleType, listStyleType)
      ->addRule(Css.listStylePosition, listStylePosition)
      ->addRule(Css.listStyleImage, listStyleImage)
      ->addRule(((type_, position, image)) => Css.listStyle(type_, position, image), listStyle)
      ->addRule(Css.outlineStyle, outlineStyle)
      ->addRule(((size, style, color)) => Css.outline(size, style, color), outline)
      ->addRule(Css.textDecorationStyle, textDecorationStyle)
      ->addRule(Css.textDecorationLine, textDecorationLine)
      ->addRule(Css.textDecoration, textDecoration)
      ->addRule(Css.transform, transform)

    let parsedRules =
      rules
      ->Belt.Map.toArray
      ->Js.Array2.map(((breakpoint, rules)) => Css.breakpoint(breakpoint, rules))

    Css.style(. parsedRules)
  }

  let merge = styles => styles->Js.Array2.joinWith("")
}
