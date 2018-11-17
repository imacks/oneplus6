What is inside bootanimation
============================
This page talks about `bootanimation.zip` inside android phones. Most comes from [https://android.googlesource.com/platform/frameworks/base/+/master/cmds/bootanimation/FORMAT.md](here).

The first line
==============
The first line defines the picture size and fps:

```
WIDTH HEIGHT FPS
```
- WIDTH: animation width in pixels
- HEIGHT: animation height in pixels
- FPS: frames per second

Subsequent lines
================
There can be multiple lines after the first line, each called a `part`:

```
TYPE COUNT PAUSE PATH [#RGBHEX [CLOCK1 [CLOCK2]]]
```
- TYPE: `p` means abort playing if boot compltes, `c` means finish the current loop even when boot completes
- COUNT: 0 means loop till boot completes, otherwise it means how many loops
- PAUSE: number of **FRAMES** to delay after the part ends.
- PATH: the path in the archive where the resources for the part lives
- RGBHEX: background color. optional.
- CLOCK1, CLOCK2: for watches only. the coordinates to draw the time. CLOCK1 is the x coordinate and CLOCK2 is the y coordinate. Coordinates can be positive, negative, or the keyword `c`, which means center.

The resource directories
========================
Each part loads its resources from a directory specified. Each frame is a png file, named `part000.png`, `part001.png`, etc. Make sure every png's resolution matchs what the first line in `desc.txt` says, unless you are using trimming.

Trim
----
You can have a `trim.txt` file in a resource directory. What it does is instruct how a frame is overlayed on the background color:

```
WxH+X+Y
```

For example,

```
713x165+388+914
708x152+388+912
```

The first `WxH` is the size of the png, and the second `X+Y` is the coordinates to draw the png. The PNG is drawn over the background color. You need to specify this for each png in your directory.

Sound
-----
Each part's resource directory can also contain one `audio.wav`, which will play a sound.


Optimization
============
Use `zopflipng -m` to compress the png files.

Consider changing some png to 256 colors.

Do not set compression level when creating the final zip file, since the PNG is already optimized.
