package game

import "core:math/rand"
import "vendor:raylib"
import "../audio"
import "../defs"
import "../utils"

Update :: proc() -> defs.GameState {
    if gameover {
        if raylib.GetKeyPressed() != raylib.KeyboardKey.KEY_NULL {
            return .TITLE
        }
        return .NONE
    }

    // Player 1 controls
    if raylib.IsKeyDown(raylib.KeyboardKey.A) {
        p1.y -= defs.PAD_SPEED
        if p1.y < 0 {
            p1.y = 0
        }
    }
    if raylib.IsKeyDown(raylib.KeyboardKey.Z) {
        p1.y += defs.PAD_SPEED
        if p1.y + defs.PAD_HEIGHT > defs.WINDOW_HEIGHT {
            p1.y = defs.WINDOW_HEIGHT - defs.PAD_HEIGHT
        }
    }
    // Other player
    if defs.players == 2 {
        // Player 2 controls
        if raylib.IsKeyDown(raylib.KeyboardKey.K) {
            p2.y -= defs.PAD_SPEED
            if p2.y < 0 {
                p2.y = 0
            }
        }
        if raylib.IsKeyDown(raylib.KeyboardKey.M) {
            p2.y += defs.PAD_SPEED
            if p2.y + defs.PAD_HEIGHT > defs.WINDOW_HEIGHT {
                p2.y = defs.WINDOW_HEIGHT - defs.PAD_HEIGHT
            }
        }
    }
    else {
        // Player 2 AI
        if ball.speedX > 0 {
            ai_reaction_timer -= raylib.GetFrameTime()
            if ai_reaction_timer <= 0 {
                dir := ball.y - p2.y
                p2.y += defs.PAD_SPEED * (1 if dir > 0 else -1)
            }
        }
        else {
            if ai_reaction_timer <= 0 {
                ai_reaction_timer = defs.AI_REACTION_TIME + rand.float32_range(-defs.AI_REACTION_DEVIATION, defs.AI_REACTION_DEVIATION)
            }
        }
        if p2.y < 0 {
            p2.y = 0
        }
        if p2.y + defs.PAD_HEIGHT > defs.WINDOW_HEIGHT {
            p2.y = defs.WINDOW_HEIGHT - defs.PAD_HEIGHT
        }
    }

    // Ball update
    ball.x += ball.speedX
    ball.y += ball.speedY
    // Bounce off walls
    if ball.y - defs.BALL_RADIUS < 0 {
        ball.y = defs.BALL_RADIUS
        ball.speedY *= -1
        audio.PlaySFX("boop2")
    }
    if ball.y + defs.BALL_RADIUS > defs.WINDOW_HEIGHT {
        ball.y = defs.WINDOW_HEIGHT - defs.BALL_RADIUS
        ball.speedY *= -1
        audio.PlaySFX("boop2")
    }
    // Bounce off pads and get more speed
    if utils.CircleRectangleIntersect(ball.x, ball.y, defs.BALL_RADIUS, p1.x, p1.y, defs.PAD_WIDTH, defs.PAD_HEIGHT) {
        ball.speedX *= -1
        ball.speedX += 1 if ball.speedX > 0 else -1
        ball.speedY += 1 if ball.speedY > 0 else -1
        ball.x = p1.x + defs.PAD_WIDTH + defs.BALL_RADIUS
        audio.PlaySFX("boop1")
    }
    if utils.CircleRectangleIntersect(ball.x, ball.y, defs.BALL_RADIUS, p2.x, p2.y, defs.PAD_WIDTH, defs.PAD_HEIGHT) {
        ball.speedX *= -1
        ball.speedX += 1 if ball.speedX > 0 else -1
        ball.speedY += 1 if ball.speedY > 0 else -1
        ball.x = p2.x - defs.BALL_RADIUS
        audio.PlaySFX("boop1")
    }
    // Score
    {
        scored := false
        if ball.x - defs.BALL_RADIUS < 0 {
            p2.score += 1
            scored = true
        }
        if ball.x + defs.BALL_RADIUS > defs.WINDOW_WIDTH {
            p1.score += 1
            scored = true
        }
        // Reset position and speed
        if scored {
            ball.x = defs.WINDOW_WIDTH/2
            ball.y = defs.WINDOW_HEIGHT/4 + (rand.int31() % (defs.WINDOW_HEIGHT/2))
            ball.speedX *= -1
            ball.speedY = defs.PAD_SPEED * (1 if ball.speedY > 0 else -1)
            ball.speedX = defs.PAD_SPEED * (1 if ball.speedX > 0 else -1)
            audio.PlaySFX("coin1")
        }
        if p1.score >= defs.SCORE_TO_WIN || p2.score >= defs.SCORE_TO_WIN {
            gameover = true
        }
    }

    return .NONE
}