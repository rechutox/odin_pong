package utils

import "core:math"

CircleRectangleIntersect :: proc(cx, cy, r, rx, ry, rw, rh : i32) -> bool {
    // Find the closest point to the circle within the rectangle
    closestX := math.clamp(cx, rx, rx + rw)
    closestY := math.clamp(cy, ry, ry + rh)
    // Calculate the distance between the circle's center and the closest point
    distanceX := cx - closestX
    distanceY := cy - closestY
    // Check if the distance is less than the circle's radius
    distanceSquared := distanceX * distanceX + distanceY * distanceY
    return distanceSquared <= r * r
}