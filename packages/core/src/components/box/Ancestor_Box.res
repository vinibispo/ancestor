module Make = (Config: Ancestor_Config.T) => {
  module Styles = Ancestor_Styles.Make(Config)
  module Base = Ancestor_Base.Make(Config)

  type columns = [
    | #1
    | #2
    | #3
    | #4
    | #5
    | #6
    | #7
    | #8
    | #9
    | #10
    | #11
    | #12
  ]

  /**
   * Calculate the columns size based on the value provided.
   */
  let basisFromFloat = (value: columns) =>
    (value :> int)
    ->Js.Int.toFloat
    ->(v => v *. 100.0 /. 12.0)
    ->Js.Float.toFixedWithPrecision(~digits=1) ++ "%"

  /**
   * Specific styles for the API.
   */
  let createBox = (~columns=?, ()) => {
    let responsiveStyles = Styles.createResponsiveProp(~prop=columns, column =>
      `flex-basis: ${basisFromFloat(column)};`
    )

    Emotion.rawCss(responsiveStyles)
  }

  @react.component
  let make = (
    // declaration:start
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
    ~flexFlow=?,
    ~gap=?,
    ~p=?,
    ~px=?,
    ~py=?,
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
    ~_focus: option<Styles.Css.t>=?,
    ~_hover: option<Styles.Css.t>=?,
    ~_active: option<Styles.Css.t>=?,
    ~_focusWithin: option<Styles.Css.t>=?,
    ~_focusVisible: option<Styles.Css.t>=?,
    ~_disabled: option<Styles.Css.t>=?,
    ~_before: option<Styles.Css.t>=?,
    ~_after: option<Styles.Css.t>=?,
    ~_even: option<Styles.Css.t>=?,
    ~_odd: option<Styles.Css.t>=?,
    ~_first: option<Styles.Css.t>=?,
    ~_last: option<Styles.Css.t>=?,
    ~_notFirst: option<Styles.Css.t>=?,
    ~_notLast: option<Styles.Css.t>=?,
    // declaration:end
    // Box props
    ~columns: option<Config.breakpoints<columns>>=?,
    // React props
    ~children=?,
    ~dangerouslySetInnerHTML=?,
    ~innerRef=?,
    // DOM Props
    ~className="",
    ~tag: Ancestor_React.tags=#div,
    ~id=?,
    ~onClick=?,
    ~onSubmit=?,
    ~onChange=?,
    ~src=?,
    ~alt=?,
    ~ariaDetails=?,
    ~ariaDisabled=?,
    ~ariaHidden=?,
    ~ariaKeyshortcuts=?,
    ~ariaLabel=?,
    ~ariaRoledescription=?,
    ~ariaExpanded=?,
    ~ariaLevel=?,
    ~ariaModal=?,
    ~ariaMultiline=?,
    ~ariaMultiselectable=?,
    ~ariaPlaceholder=?,
    ~ariaReadonly=?,
    ~ariaRequired=?,
    ~ariaSelected=?,
    ~ariaSort=?,
    ~ariaValuemax=?,
    ~ariaValuemin=?,
    ~ariaValuenow=?,
    ~ariaValuetext=?,
    ~ariaAtomic=?,
    ~ariaBusy=?,
    ~ariaRelevant=?,
    ~ariaGrabbed=?,
    ~ariaActivedescendant=?,
    ~ariaColcount=?,
    ~ariaColindex=?,
    ~ariaColspan=?,
    ~ariaControls=?,
    ~ariaDescribedby=?,
    ~ariaErrormessage=?,
    ~ariaFlowto=?,
    ~ariaLabelledby=?,
    ~ariaOwns=?,
    ~ariaPosinset=?,
    ~ariaRowcount=?,
    ~ariaRowindex=?,
    ~ariaRowspan=?,
    ~ariaSetsize=?,
    ~defaultChecked=?,
    ~defaultValue=?,
    ~accessKey=?,
    ~contentEditable=?,
    ~contextMenu=?,
    ~lang=?,
    ~role=?,
    ~style=?,
    ~spellCheck=?,
    ~tabIndex=?,
    ~title=?,
    ~itemID=?,
    ~itemProp=?,
    ~itemRef=?,
    ~itemScope=?,
    ~itemType=?,
    ~accept=?,
    ~acceptCharset=?,
    ~action=?,
    ~allowFullScreen=?,
    ~async=?,
    ~autoComplete=?,
    ~autoCapitalize=?,
    ~autoFocus=?,
    ~autoPlay=?,
    ~challenge=?,
    ~charSet=?,
    ~checked=?,
    ~cite=?,
    ~crossOrigin=?,
    ~cols=?,
    ~colSpan=?,
    ~content=?,
    ~controls=?,
    ~coords=?,
    ~data=?,
    ~dateTime=?,
    ~default=?,
    ~defer=?,
    ~disabled=?,
    ~download=?,
    ~encType=?,
    ~form=?,
    ~formAction=?,
    ~formTarget=?,
    ~formMethod=?,
    ~headers=?,
    ~high=?,
    ~href=?,
    ~hrefLang=?,
    ~htmlFor=?,
    ~httpEquiv=?,
    ~icon=?,
    ~inputMode=?,
    ~integrity=?,
    ~keyType=?,
    ~kind=?,
    ~label=?,
    ~list=?,
    ~loop=?,
    ~low=?,
    ~manifest=?,
    ~max=?,
    ~maxLength=?,
    ~media=?,
    ~mediaGroup=?,
    ~method=?,
    ~min=?,
    ~minLength=?,
    ~multiple=?,
    ~muted=?,
    ~name=?,
    ~nonce=?,
    ~noValidate=?,
    ~open_=?,
    ~optimum=?,
    ~pattern=?,
    ~placeholder=?,
    ~playsInline=?,
    ~poster=?,
    ~preload=?,
    ~radioGroup=?,
    ~readOnly=?,
    ~rel=?,
    ~required=?,
    ~reversed=?,
    ~rows=?,
    ~rowSpan=?,
    ~sandbox=?,
    ~scope=?,
    ~scoped=?,
    ~scrolling=?,
    ~selected=?,
    ~shape=?,
    ~size=?,
    ~sizes=?,
    ~span=?,
    ~srcDoc=?,
    ~srcLang=?,
    ~srcSet=?,
    ~start=?,
    ~step=?,
    ~summary=?,
    ~target=?,
    ~type_=?,
    ~useMap=?,
    ~value=?,
    ~wrap=?,
    ~onCopy=?,
    ~onCut=?,
    ~onPaste=?,
    ~onCompositionEnd=?,
    ~onCompositionStart=?,
    ~onCompositionUpdate=?,
    ~onKeyDown=?,
    ~onKeyPress=?,
    ~onKeyUp=?,
    ~onFocus=?,
    ~onBlur=?,
    ~onInput=?,
    ~onInvalid=?,
    ~onContextMenu=?,
    ~onDoubleClick=?,
    ~onDrag=?,
    ~onDragEnd=?,
    ~onDragEnter=?,
    ~onDragExit=?,
    ~onDragLeave=?,
    ~onDragOver=?,
    ~onDragStart=?,
    ~onDrop=?,
    ~onMouseDown=?,
    ~onMouseEnter=?,
    ~onMouseLeave=?,
    ~onMouseMove=?,
    ~onMouseOut=?,
    ~onMouseOver=?,
    ~onMouseUp=?,
    ~onSelect=?,
    ~onTouchCancel=?,
    ~onTouchEnd=?,
    ~onTouchMove=?,
    ~onTouchStart=?,
    ~onPointerOver=?,
    ~onPointerEnter=?,
    ~onPointerDown=?,
    ~onPointerMove=?,
    ~onPointerUp=?,
    ~onPointerCancel=?,
    ~onPointerOut=?,
    ~onPointerLeave=?,
    ~onGotPointerCapture=?,
    ~onLostPointerCapture=?,
    ~onScroll=?,
    ~onWheel=?,
    ~onAbort=?,
    ~onCanPlay=?,
    ~onCanPlayThrough=?,
    ~onDurationChange=?,
    ~onEmptied=?,
    ~onEnded=?,
    ~onError=?,
    ~onLoadedData=?,
    ~onLoadedMetadata=?,
    ~onLoadStart=?,
    ~onPause=?,
    ~onPlay=?,
    ~onPlaying=?,
    ~onProgress=?,
    ~onRateChange=?,
    ~onSeeked=?,
    ~onSeeking=?,
    ~onStalled=?,
    ~onSuspend=?,
    ~onTimeUpdate=?,
    ~onVolumeChange=?,
    ~onWaiting=?,
    ~onLoad=?,
    ~onAnimationStart=?,
    ~onAnimationEnd=?,
    ~onAnimationIteration=?,
    ~onTransitionEnd=?,
  ) => {
    <Base
      className={
        let boxClassName = createBox(~columns?, ())
        `${boxClassName} ${className}`
      }
      // forward:start
      ?borderRadius
      ?borderTLRadius
      ?borderTRRadius
      ?borderBLRadius
      ?borderBRRadius
      ?borderStyle
      ?borderColor
      ?borderWidth
      ?borderRightStyle
      ?borderLeftStyle
      ?borderTopStyle
      ?borderBottomStyle
      ?borderRightColor
      ?borderLeftColor
      ?borderTopColor
      ?borderBottomColor
      ?borderRightWidth
      ?borderLeftWidth
      ?borderTopWidth
      ?borderBottomWidth
      ?border
      ?borderRight
      ?borderLeft
      ?borderTop
      ?borderBottom
      ?bgColor
      ?bgSize
      ?bgPosition
      ?bgImage
      ?color
      ?display
      ?justifyContent
      ?flexDirection
      ?alignItems
      ?flexBasis
      ?flexWrap
      ?flexGrow
      ?alignContent
      ?alignSelf
      ?justifySelf
      ?flexFlow
      ?gap
      ?p
      ?px
      ?py
      ?pt
      ?pb
      ?pl
      ?pr
      ?m
      ?mx
      ?my
      ?mt
      ?mb
      ?ml
      ?mr
      ?textAlign
      ?fontFamily
      ?fontWeight
      ?fontSize
      ?letterSpacing
      ?lineHeight
      ?width
      ?height
      ?minW
      ?minH
      ?maxW
      ?maxH
      ?position
      ?top
      ?bottom
      ?left
      ?right
      ?zIndex
      ?boxSizing
      ?overflow
      ?overflowX
      ?overflowY
      ?cursor
      ?visibility
      ?listStyleType
      ?listStylePosition
      ?listStyleImage
      ?listStyle
      ?outlineStyle
      ?outline
      ?textDecorationStyle
      ?textDecorationLine
      ?textDecoration
      ?transform
      ?_focus
      ?_hover
      ?_active
      ?_focusWithin
      ?_focusVisible
      ?_disabled
      ?_before
      ?_after
      ?_even
      ?_odd
      ?_first
      ?_last
      ?_notFirst
      ?_notLast
      // forward:end
      // DOM Props
      tag
      ?id
      ?onSubmit
      ?onClick
      ?onChange
      ?dangerouslySetInnerHTML
      ?src
      ?alt
      ?children
      ?innerRef
      ?ariaDetails
      ?ariaDisabled
      ?ariaHidden
      ?ariaKeyshortcuts
      ?ariaLabel
      ?ariaRoledescription
      ?ariaExpanded
      ?ariaLevel
      ?ariaModal
      ?ariaMultiline
      ?ariaMultiselectable
      ?ariaPlaceholder
      ?ariaReadonly
      ?ariaRequired
      ?ariaSelected
      ?ariaSort
      ?ariaValuemax
      ?ariaValuemin
      ?ariaValuenow
      ?ariaValuetext
      ?ariaAtomic
      ?ariaBusy
      ?ariaRelevant
      ?ariaGrabbed
      ?ariaActivedescendant
      ?ariaColcount
      ?ariaColindex
      ?ariaColspan
      ?ariaControls
      ?ariaDescribedby
      ?ariaErrormessage
      ?ariaFlowto
      ?ariaLabelledby
      ?ariaOwns
      ?ariaPosinset
      ?ariaRowcount
      ?ariaRowindex
      ?ariaRowspan
      ?ariaSetsize
      ?defaultChecked
      ?defaultValue
      ?accessKey
      ?contentEditable
      ?contextMenu
      ?lang
      ?role
      ?style
      ?spellCheck
      ?tabIndex
      ?title
      ?itemID
      ?itemProp
      ?itemRef
      ?itemScope
      ?itemType
      ?accept
      ?acceptCharset
      ?action
      ?allowFullScreen
      ?async
      ?autoComplete
      ?autoCapitalize
      ?autoFocus
      ?autoPlay
      ?challenge
      ?charSet
      ?checked
      ?cite
      ?crossOrigin
      ?cols
      ?colSpan
      ?content
      ?controls
      ?coords
      ?data
      ?dateTime
      ?default
      ?defer
      ?disabled
      ?download
      ?encType
      ?form
      ?formAction
      ?formTarget
      ?formMethod
      ?headers
      ?high
      ?href
      ?hrefLang
      ?htmlFor
      ?httpEquiv
      ?icon
      ?inputMode
      ?integrity
      ?keyType
      ?kind
      ?label
      ?list
      ?loop
      ?low
      ?manifest
      ?max
      ?maxLength
      ?media
      ?mediaGroup
      ?method
      ?min
      ?minLength
      ?multiple
      ?muted
      ?name
      ?nonce
      ?noValidate
      ?open_
      ?optimum
      ?pattern
      ?placeholder
      ?playsInline
      ?poster
      ?preload
      ?radioGroup
      ?readOnly
      ?rel
      ?required
      ?reversed
      ?rows
      ?rowSpan
      ?sandbox
      ?scope
      ?scoped
      ?scrolling
      ?selected
      ?shape
      ?size
      ?sizes
      ?span
      ?srcDoc
      ?srcLang
      ?srcSet
      ?start
      ?step
      ?summary
      ?target
      ?type_
      ?useMap
      ?value
      ?wrap
      ?onCopy
      ?onCut
      ?onPaste
      ?onCompositionEnd
      ?onCompositionStart
      ?onCompositionUpdate
      ?onKeyDown
      ?onKeyPress
      ?onKeyUp
      ?onFocus
      ?onBlur
      ?onInput
      ?onInvalid
      ?onContextMenu
      ?onDoubleClick
      ?onDrag
      ?onDragEnd
      ?onDragEnter
      ?onDragExit
      ?onDragLeave
      ?onDragOver
      ?onDragStart
      ?onDrop
      ?onMouseDown
      ?onMouseEnter
      ?onMouseLeave
      ?onMouseMove
      ?onMouseOut
      ?onMouseOver
      ?onMouseUp
      ?onSelect
      ?onTouchCancel
      ?onTouchEnd
      ?onTouchMove
      ?onTouchStart
      ?onPointerOver
      ?onPointerEnter
      ?onPointerDown
      ?onPointerMove
      ?onPointerUp
      ?onPointerCancel
      ?onPointerOut
      ?onPointerLeave
      ?onGotPointerCapture
      ?onLostPointerCapture
      ?onScroll
      ?onWheel
      ?onAbort
      ?onCanPlay
      ?onCanPlayThrough
      ?onDurationChange
      ?onEmptied
      ?onEnded
      ?onError
      ?onLoadedData
      ?onLoadedMetadata
      ?onLoadStart
      ?onPause
      ?onPlay
      ?onPlaying
      ?onProgress
      ?onRateChange
      ?onSeeked
      ?onSeeking
      ?onStalled
      ?onSuspend
      ?onTimeUpdate
      ?onVolumeChange
      ?onWaiting
      ?onLoad
      ?onAnimationStart
      ?onAnimationEnd
      ?onAnimationIteration
      ?onTransitionEnd
    />
  }
}
