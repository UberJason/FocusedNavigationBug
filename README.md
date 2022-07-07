# FocusedNavigationBug

A bug in iOS 16 beta 3 demonstrating an infinite loop with growing memory usage that occurs with NavigationStack when the array is inside of a StateObject, in a sheet, 
pushing another screen, presenting another sheet, and then dismissing it. I know, it's a lot, just follow the steps.

1. Tap "Sheet" to launch "First Sheet".
2. Tap "Manage Reminders" to push "Detail Screen".
3. Tap "Show" to present "Second Sheet".
4. Tap "Dismiss" to attempt to dismiss the Second Sheet.

Expected: dismisses the second sheet back to Detail Screen.
Actual: application hangs, CPU goes to 100% and memory usage grows infinitely.

<video width="800" controls>
  <source src="https://github.com/UberJason/FocusedNavigationBug/blob/main/FocusedNavigationBug.mov" type="video/mp4">
</video>
