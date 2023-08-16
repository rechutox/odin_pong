package game

import "core:fmt"
import "vendor:raylib"
import "../defs"

Draw :: proc() {
    raylib.DrawText(fmt.ctprintf("%d", p1.score), defs.WINDOW_WIDTH/4, 40, 60, raylib.WHITE)
    raylib.DrawText(fmt.ctprintf("%d", p2.score),  defs.WINDOW_WIDTH/4 * 3, 40, 60, raylib.WHITE)
    raylib.DrawLine(defs.WINDOW_WIDTH/2, 0, defs.WINDOW_WIDTH/2, defs.WINDOW_HEIGHT, raylib.WHITE)
    
    raylib.DrawRectangle(p1.x, p1.y, defs.PAD_WIDTH, defs.PAD_HEIGHT, raylib.WHITE)
    raylib.DrawRectangle(p2.x, p2.y, defs.PAD_WIDTH, defs.PAD_HEIGHT, raylib.WHITE)

    if gameover {
        p := 1 if p1.score > p2.score else 2
        str := fmt.ctprintf("Player %d wins!", p)
        mx := raylib.MeasureText(str, 60)
        x := (defs.WINDOW_WIDTH - mx)/2
        y := defs.WINDOW_HEIGHT/2 - 30
        raylib.DrawRectangle(x - 20, y - 20, mx + 20, 100, raylib.BLACK)

        blink_timer += raylib.GetFrameTime()
        if blink_timer > 0.5 {
            blink_timer = 0.0
        }
        else if blink_timer > 0.25 {
            raylib.DrawText(str, x, y, 60, raylib.WHITE)
        }
    }
    else {
        raylib.DrawCircle(ball.x, ball.y, f32(defs.BALL_RADIUS), raylib.WHITE)
    }
}
