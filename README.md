# Auto Input Switch

[![Mod Thumbnail](https://staticdelivery.nexusmods.com/mods/3089/images/194/194-1747544641-1059626819.png)](https://nexusmods.com/bullyscholarshipedition/mods/194)

## Download

| Nexus Mods                                                                                                                                            | Mirror                                                                                                        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| [![Download](https://img.shields.io/badge/Download-NEXUSMODS-yellow?style=for-the-badge)](https://www.nexusmods.com/bullyscholarshipedition/mods/194) | [![Download](https://img.shields.io/badge/Download-MIRROR-blue?style=for-the-badge)](https://sfl.gl/7GnpiudY) |

## Description

Automatically switches input between keyboard and Xbox 360 controller.

Auto Input Switch is a quality-of-life mod for Bully: Scholarship Edition that automatically detects and switches control input between keyboard and Xbox 360 controller. It removes the need to manually change settings, making transitions between devices seamless.

## Important note

Make sure your controller is connected to your PC before launching the game to ensure proper detection.

## API Documentation

For developers looking to integrate with or extend this mod, the API documentation can be found [here](./API.md).

## Changelog

### Version 1.2.0

- feat,refactor: Enable input control switching while in title screen menu

- Now requires `MainMenu.dll` that comes from [Main Menu Overhaul](https://nexusmods.com/bullyscholarshipedition/mods/48) mod to be able to listen for inputs while in title screen menu for the first time (booting the game, not go back to title screen from pause menu)

### Version 1.1.2

- fix: Couldn't switch input while in pause/map menu

### Version 1.1.1

- fix: Can't move with kbm when x360 move manually enabled in the menu

### Version 1.1.0

- fix: `SetInt32 nil` error message
- feat: bullybytes compatibility

### Version 1.0.0

- Initial release
