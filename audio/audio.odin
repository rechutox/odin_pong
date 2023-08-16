package audio

import "core:fmt"
import "vendor:raylib"

AudioResource :: struct {
    sfx: map[string]raylib.Sound,
    bgm: map[string]raylib.Music,
}

resources: AudioResource
currentBGM: raylib.Music

Init :: proc() {
    resources.sfx = make(map[string]raylib.Sound)
    resources.bgm = make(map[string]raylib.Music)
}

LoadSFX :: proc(key: string, file_path: cstring) {
    sfx := raylib.LoadSound(file_path)
    resources.sfx[key] = sfx
}

LoadBGM :: proc(key: string, file_path: cstring) {
    bgm := raylib.LoadMusicStream(file_path)
    resources.bgm[key] = bgm
}

PlaySFX :: proc(key: string) {
    sfx, ok := resources.sfx[key]
    if ok {
        raylib.PlaySound(sfx)
    }
}

PlayBGM :: proc(key: string) {
    bgm, ok := resources.bgm[key]
    if ok {
        raylib.StopMusicStream(currentBGM)
        currentBGM = bgm
        raylib.PlayMusicStream(bgm)
        fmt.println("Now playing: ", key)
    }
    else {
        fmt.println("Bgm not found: ", key)
    }
}

Update :: proc() {
    raylib.UpdateMusicStream(currentBGM)
}

Unload :: proc() {
    for key, sfx in resources.sfx {
        raylib.UnloadSound(sfx)
    }
    for key, bgm in resources.bgm {
        raylib.UnloadMusicStream(bgm)
    }
}