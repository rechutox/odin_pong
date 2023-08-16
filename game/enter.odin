package game

import "../defs"

Enter :: proc() {
    p1.x = 40
    p1.y = (defs.WINDOW_HEIGHT - defs.PAD_HEIGHT) / 2
    p1.score = 0

    p2.x = defs.WINDOW_WIDTH - defs.PAD_WIDTH - 40
    p2.y = (defs.WINDOW_HEIGHT - defs.PAD_HEIGHT) / 2
    p2.score = 0

    ball = defs.Ball{ defs.WINDOW_WIDTH/2, defs.WINDOW_HEIGHT/2, defs.PAD_SPEED, defs.PAD_SPEED }
    gameover = false

    blink_timer = 0.0
    ai_reaction_timer = 0.0
}