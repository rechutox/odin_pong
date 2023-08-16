package title

import "core:fmt"
import "core:math"
import "core:math/rand"
import "vendor:raylib"
import "../audio"
import "../defs"
import "../utils"

TITLE_STR   :: "~ ODIN PONG ~"
TITLE_SIZE  :: 120
PROMPT_STR  :: "Press [SPACEBAR] to start"
PROMPT_SIZE :: 60

blink_timer : f32 = 0.0

Enter :: proc() {
}

Draw :: proc() {
    raylib.DrawText(defs.VERSION, defs.WINDOW_WIDTH - 60, 20, 20, raylib.GRAY)

    utils.DrawTextCentered(TITLE_STR, defs.WINDOW_WIDTH/2, 140, 120, raylib.WHITE)

    utils.DrawTextCentered("Solo play", defs.WINDOW_WIDTH/3, defs.WINDOW_HEIGHT/2-20, 40, raylib.WHITE)
    utils.DrawTextCentered("Two players", defs.WINDOW_WIDTH/3 * 2, defs.WINDOW_HEIGHT/2-20, 40, raylib.WHITE)
    {
        rect := raylib.Rectangle{ f32(defs.WINDOW_WIDTH/3 * defs.players)-150, f32(defs.WINDOW_HEIGHT/2-40), 300, 80 }
        raylib.DrawRectangleRoundedLines(rect, 0.3, 8, 1.0, raylib.WHITE)
    }

    {
        rect := raylib.Rectangle{ 20, f32(defs.WINDOW_HEIGHT - 120), 180, 100 }
        raylib.DrawRectangleRoundedLines(rect, 0.3, 8, 1.0, raylib.WHITE)
        raylib.DrawText("[A] move up", i32(rect.x + 20), i32(rect.y + 20), 20, raylib.WHITE)
        raylib.DrawText("[Z] move down", i32(rect.x + 20), i32(rect.y + 60), 20, raylib.WHITE)
    }

    if defs.players == 2 {
        rect := raylib.Rectangle{ f32(defs.WINDOW_WIDTH - 200), f32(defs.WINDOW_HEIGHT - 120), 180, 100 }
        raylib.DrawRectangleRoundedLines(rect, 0.3, 8, 1.0, raylib.WHITE)
        raylib.DrawText("[K] move up", i32(rect.x + 20), i32(rect.y + 20), 20, raylib.WHITE)
        raylib.DrawText("[M] move down", i32(rect.x + 20), i32(rect.y + 60), 20, raylib.WHITE)
    }

    blink_timer += raylib.GetFrameTime()
    if blink_timer > 0.5 {
        blink_timer = 0.0
    }
    else if blink_timer > 0.25 {
        utils.DrawTextCentered(PROMPT_STR, defs.WINDOW_WIDTH/2, defs.WINDOW_HEIGHT - 230, 40, raylib.WHITE)
    }
}

Update :: proc() -> defs.GameState {
    if raylib.IsKeyPressed(.SPACE) {
        return .GAME
    }
    if raylib.IsKeyPressed(.LEFT) || raylib.IsKeyPressed(.RIGHT) {
        if defs.players == 1 {
            defs.players = 2
        }
        else {
            defs.players = 1
        }
    }
    return .NONE
}
