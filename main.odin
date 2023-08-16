package main

import "core:fmt"
import "core:math"
import "core:math/rand"
import "vendor:raylib"
import "defs"
import "audio"
import "title"
import "game"

game_state: defs.GameState

main :: proc() {
    raylib.InitWindow(defs.WINDOW_WIDTH, defs.WINDOW_HEIGHT, "Odin Pong " + defs.VERSION)
    raylib.SetTargetFPS(defs.TARGET_FPS)
    raylib.InitAudioDevice()

    audio.Init()
    audio.LoadSFX("boop1", "./assets/boop_01.wav")
    audio.LoadSFX("boop2", "./assets/boop_02.wav")
    audio.LoadSFX("coin1", "./assets/coin_01.wav")
    audio.LoadBGM("bgm",   "./assets/little-slimex27s-adventure-151007.ogg")
    audio.PlayBGM("bgm")

    ChangeState(.TITLE)

    for !raylib.WindowShouldClose() {
        audio.Update()
        Update()

        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.BLACK)
        Draw()
        raylib.EndDrawing()
    }

    audio.Unload()
    raylib.CloseAudioDevice()
    raylib.CloseWindow()
}

Update :: proc() {
    new_state: defs.GameState = .NONE

    switch game_state {
    case .TITLE:
        new_state = title.Update()
    case .GAME:
        new_state = game.Update()
    case .NONE:
    }

    if new_state != .NONE {
        ChangeState(new_state)
    }
}

Draw :: proc() {
    switch game_state {
    case .TITLE:
        title.Draw()
    case .GAME:
        game.Draw()
    case .NONE:
    }
}


ChangeState :: proc(state: defs.GameState) {
    switch state {
    case .TITLE:
        title.Enter()
    case .GAME:
        game.Enter()
    case .NONE:
    }
    game_state = state
}