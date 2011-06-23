# Overview

This is an iOS implementation of the [N Dollar Gesture Recognizer](http://depts.washington.edu/aimgroup/proj/dollar/ndollar.html).

More info [here](http://britg.com/2011/05/14/complex-gesture-recognition-in-ios-part-1-the-research/).

# N Dollar Recognizer

View the javascript implementation [here](http://depts.washington.edu/aimgroup/proj/dollar/ndollar.html)

Anthony, L. and Wobbrock, J.O. (2010). A lightweight multistroke recognizer for user interface prototypes. Proceedings of Graphics Interface (GI '10). Ottawa, Ontario (May 31-June 2, 2010). Toronto, Ontario: Canadian Information Processing Society, pp. 245-252.

# Detecting Glyphs

A Glyph is a user-defined set of Strokes, which are in turn just an array of points. When a Glyph is initialized, it first permutes through all the possible combinations of Stroke directions/order necessary to recreate itself. It also resamples and resizes itslef into a bounding box. Finally, a Glyph creates unistrokes (Templates) from all the calculated multistrokes.

The Detector collects user input (an array of points) and triggers a comparison of the input against all of the Glyph Templates. Each Template is given a score, and the Template with the highest score is considered the match. The Glyph that the Template belongs to is announced to the Delegate.

# Creating Glyphs

A Glyph can either be defined manually by defining its Strokes and initializing a Glyph with those Strokes. Or, a newly created Glyph can be fed user input and create itself when ready.

# License

Copyright (c) 2011 Brit Gardner

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
