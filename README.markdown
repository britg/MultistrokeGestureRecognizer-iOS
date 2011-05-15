# Overview

This is an iOS implementation of the [N Dollar Gesture Recognizer](http://depts.washington.edu/aimgroup/proj/dollar/ndollar.html).

More info [here](http://britg.com/2011/05/14/complex-gesture-recognition-in-ios-part-1-the-research/).

# Detecting Glyphs

A Glyph is a user-defined set of Strokes, which are in turn just an array of points. When a Glyph is initialized, it first permutes through all the possible combinations of Stroke directions/order necessary to recreate itself. It also resamples and resizes itslef into a bounding box. Finally, a Glyph creates unistrokes (Templates) from all the calculated multistrokes.

The Detector collects user input (an array of points) and triggers a comparison of the input against all of the Glyph Templates. Each Template is given a score, and the Template with the highest score is considered the match. The Glyph that the Template belongs to is announced to the Delegate.

# Creating Glyphs

A Glyph can either be defined manually by defining its Strokes and initializing a Glyph with those Strokes. Or, a newly created Glyph can be fed user input and create itself when ready.
