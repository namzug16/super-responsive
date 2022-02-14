
<h1 align="center">
Super Responsive
</h1>

---

A responsive library for Flutter that
- is easy to use and easy to read
- makes your app look great on all devices
- makes your app more readable
- makes your app more maintainable

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

Then you will be able to use all our features!!!

### Responsive Value
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
/// breakpoints range -> [600, 1200]
/// our value range -> [100, 500]
/// when screen width == 800 in the range [600, 1200], 
/// this value will be mapped to the range [100, 500]
/// and it will return the value = 233.333
/// all this calculation is made by the [mapValue] function,
/// that can be used by you in any way you want too.

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

###Responsive Widget

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

###ResponsiveText

```dart
...
@override
Widget build(BuildContext context) {
  return ResponsiveText(
    text: "Super Responsive",
    fontSizeRange: Range(20, 30),
    // ! we can also specify new breakpoints for only this widget
    // 
  );
}
...
```