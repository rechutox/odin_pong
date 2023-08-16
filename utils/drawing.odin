package utils

import "vendor:raylib"

DrawTextCentered :: proc(text: cstring, x: i32, y: i32, font_size: i32, color: raylib.Color) {
    ts := raylib.MeasureText(text, font_size)
    raylib.DrawText(text, x - ts/2, y, font_size, color)
}