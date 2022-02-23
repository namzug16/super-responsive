
<h1 align="center">
Super Responsive
</h1>

<p align="center">
<img src="https://github.com/namzug16/super-responsive/raw/master/assets/presentation.png" width="100%" alt="SuperResponsive" />
</p>

---

A responsive library for Flutter that
- is easy to use and easy to read
- makes your app look great on all devices
- makes your app more readable
- makes your app more maintainable

## Index

1. [Getting Started](#getting-started)
    - [Responsive Value](#responsive-value)
    - [Responsive Widget](#responsive-widget)
    - [Responsive Text](#responsive-text)
    - [Responsive Gap](#responsive-gap)
    - [Responsive Layout](#responsive-layout)



## Getting Started

Welcome to [Super Responsive]!!!

Getting started is very easy.

First, wrap your app in a [Super Responsive] widget.
```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperResponsive(
      breakPoints: BreakPoints(
        // you can add up to 6 breakpoints
        // first and second are required!
        first: 1200,
        second: 900,
        third: 600,
      ),
      child: MaterialApp(
        title: 'Super Responsive App',
        initialRoute: '/',
      ),
    );
  }
}
```

### Extensions 

```dart 

// Num extensions

100.max(99) // clamps the value with a maximum value of 99

100.min(1) // clamps the value with a minimum value of 1

100.per(50) // return 50% of 100
// it can also be made like 100*0.5 but giving 
// a value between 0-100 can be better in other cases

// BoxConstraints extensions

constraints.perWidth(50) // return 50% of maxWidth

constraints.perHeight(10) // return 10% of maxHeight

// BuildContext extensions

context.breakpoints // breakpoints from the closest SuperResponsive widget

context.currentBreakpoint // it will retrun the current breakpoint

context.mediaQueryWidth // as in MediaQuery.of(context).size.width

context.mediaQueryHeight // as in MediaQuery.of(context).size.height
      
      ↓
      ↓
      ↓
      ↓
      ↓ More BuildContext extensions
```

### Responsive Value
#### - responsiveValue()
In order to get a responsive design, we should have a responsive value.
This value can be withing any range that we specify, For example:

If we want a container to have a width between 500 and 100, meaning 
the container will have a width of 500 when our screen width will be equal or greater to
our first breakpoint, and it will have a width of 100 when our screen width will be equal 
or less than our last breakpoint (this one is going to be the last break point
we specified).

```dart
...
/// in a more graphical way
/// breakpoints extremes -> [600, 1200]
/// our value's range -> [100, 500]
/// when screen width == 800 in the range of [600, 1200], 
/// this value will be mapped to the range of [100, 500]
/// and it will return the value = 233.333
/// all this calculation is made by the (mapValue) function,
/// that can also be used by you in any way you want to.

@override
Widget build(BuildContext context) {
  return Container(
    width: context.responsiveValue(100, 500),
    height: 300,
    color: Colors.red,
  );
}
...
```
#### - breakpoints.when()
In case you don't want to calculate this value in that way and want to assign 
specific values depending on the current breakpoint, you can use the ```when```
method inside the ```Breakpoints``` class.

```dart
...
@override
Widget build(BuildContext context) {
  return Container(
    // context.breakpoints will return the breakpoints
    // of the closest SuperResponsive widget in the widget tree
    width: context.breakpoints.when(
      // the current screen width
      // you could also use context.whenBreakpoints() which will
      // use as maxWidth the screen width automatically
      maxWidth: context.mediaQueryWidth,
      first: (breakpoint) => breakpoint*0.5, // 50% of the breakpoint
      second: (_) => 300, // 300px
      third: (_) => context.responsiveValue(100, 300), // or a responsive value
      fourth: (_) => 50, // we don't have a fourth breakpoint in our SuperResponsive widget,
      // so it will return the last valid case, in this case third: (_) => context.responsiveValue(100, 300)
    ),
    height: 300,
    color: Colors.red,
  );
}
...
```
#### - customResponsiveValue()
There is also the possibility to use a custom responsive value.
Which will calculate the value based on the new breakpoint range 
that you specify and the value range.
```dart
...
@override
Widget build(BuildContext context) {
  return Container(
    width: context.customReponsiveValue(
    // you can use some of your breakpoints, or any
    // other value that you want
    breakpointsRange: (breakPoints) => 
        Range(breakpoints.second, breakpoints.first),
    valueRange: Range(100, 500),
  ),
    height: 300,
    color: Colors.red,
  );
}
...
```

### Responsive Widget

```dart
...
@override
Widget build(BuildContext context) {
  return ResponsiveWidget(
    // The amount of widgets must be equal to the amount 
    // of breakpoints we have specified in our SuperResponsive widget
    children: [
      WidgetLarge(),
      WidgetMedium(),
      WidgetSmall(),
    ],
    // ! we can also specify new breakpoints for only this widget
    // ! this will override the breakpoints of the SuperResponsive widget
    // ! and the amount of children must be equal to these new breakpoints
    // breakpoints: BreakPoints(
    //   first: 1000,
    //   second: 800,
    //   third: 500,
    // ),
  );
}
...
```

### Responsive Text

```dart
...
@override
Widget build(BuildContext context) {
  return ResponsiveText(
    text: "Super Responsive",
    fontSizeRange: Range(20, 30),
    // ! we can also specify custom breakpoints for only this widget
    // ! this means that the result of the responsive value set 
    // ! for the font size, will be set to the closest value of the
    // ! textBreakpoints. For example, if the value should be
    // ! 17, it will be set to 17 because it is the closest value from the 
    // ! set of textBreakpoints 
    // textBreakpoints: [
    // 30,
    // 15,
    // 20,
    // ]
  );
}
...
```
### Responsive Gap
```dart
...
@override
Widget build(BuildContext context) {
  // ! it'll return a SizedBox square with dimension equal
  // ! to the responsive value of range [100, 300]
  return ResponsiveGap(100, 300);
  
  // ! you can also create an "INVERSE" gap, which will 
  // ! have as a dimension the inverse value. For example,
  // ! if the value is 300 and the range is [100, 300],
  // ! it will have a final value of 100
  return ResponsiveGap(100, 300, reversed: true);
}
...
```

### Responsive Layout

With this widget you will be able to write complex layouts
and make them easier to read, understand and maintain.

The concept is very simple, specify how many layouts you want, the children
that will be available for those layouts , your breakpoints(which most of the time are your SuperResponsive breakpoints)
and then you layouts.

```dart
...
@override
Widget build(BuildContext context) {
  return ResponsiveLayout(
    layoutCount: 3,
    children: [
      Widget0(),
      Widget1(),
      Widget2(),
      Widget3(),
      Widget4(),
    ],
    // ! you can use any breakpoints you want
    breakpoints: (breakpoints) => breakpoints,
    layouts: (child) => [
      // ! Some complex layout with multiple Rows and Columns
      Column(
        children: [
          // ! the function child() will return the child 
          // ! of that specific index => child(0) == Widget0()
          Row(children:[child(1), child(0)]).expanded(),
          // ! .expanded({int flex}) is an extension on Widget
          // ! it can be used if you want to wrap your widget inside 
          // ! an Expanded widget, it has been mainly created to make your
          // ! layout more readable and to be used by Columns or Rows
          Row(children:[child(2), child(2)]).expanded(flex: 2),
          // ! there is also the extension .flexible({int flex, FlexFit fit})
          child(3).flexible(flex: 2),
        ]   
      ),
      // ! some very simple layout
      Row(children:[child(3), child(3)]),
      // ! or just return one of your children
      child(4),
    ]
  );
}
...
```

#### ⚠ Warning !!!!
> DO NOT USE .expanded() and .flexible() on a widget 
> that is already wrapped inside an Expanded or Flexible widget. 
> 
> Doing this will cause unexpected behavior and very ugly errors!!!.

## Roadmap
(a bit empty for the moment)
* Add examples
* Add tests

[super responsive]: https://github.com/namzug16/super-responsive
