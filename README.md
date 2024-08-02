# project-deck

## Naming Conventions
### Methods and Functions
Use `snake_case` for naming methods and functions.
```gdscript
func process_input(event):
    pass

func _ready():
    pass
func do_something():
```

### Variables
Use `snake_case` for naming Variables.
```gdscript
var player_speed = 10
var enemy_count = 5
```

### Constants
Use `SCREAMING_SNAKE_CASE` for naming Constants.
```gdscript
const MAX_HEALTH = 100
const GRAVITY = 9.8
```

### Classes
Use `PascalCase` for naming Constants.
```gdscript
class_name Player
class_name EnemyBoss
```

### Signals
Use `snake_case` for naming Signals.
```gdscript
signal player_died
signal score_updated
```

### Enums
Use `PascalCase` for the enum name and `SCREAMING_SNAKE_CASE` for the values.
```gdscript
enum PlayerState {
    IDLE,
    RUNNING,
    JUMPING
}
```

## File Naming Conventions
### Scenes
Use `snake_case` and descriptive names for scene files.
```gdscript
player_scene.tscn
main_menu.tscn
enemy_boss_scene.tscn
```

### Scripts
Use `snake_case` and match the script name to the scene or class it is attached if needed.
```gdscript
player.gd
main_menu.gd
enemy_boss.gd
```

### Resources
Use `snake_case` and descriptive names for resource files (e.g., textures, audio, etc.).
```gdscript
player_texture.png
background_music.ogg
enemy_sprite_sheet.png
```

### Folders/Directories
Use `snake_case` to organize your project structure.
```gdscript
scenes/
scripts/
assets/
audio/
```
