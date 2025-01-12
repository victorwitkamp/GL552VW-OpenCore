# OpenCore ASUS GL552GW

Requires DVMT set to 64MB in BIOS

"OCCPU: EIST CFG Lock 1"
    AppleCpuPmCfgLock -> True
    AppleXcpmCfgLock -> True

"OCABC: MAT support is 0"
    EnableWriteUnprotector -> True
    RebuildAppleMemoryMap -> False
    SyncRuntimePermissions -> False

### Status

| Hardware                   | Status                                                      |
| ----------------------     | ------------------------------------------------------------|
| Audio                      | ✅                                                         |
| Battery                    | ✅                                                         |
| CPU                        | ⚠️ Work in progress                                        |
| Display                    | ✅ (Including brightness control)                          |
| Keyboard                   | ✅ (Including Fn keys + Backlight)                         |
| Trackpad                   | ✅ (VoodooI2C using GPIO interrupts)                       |
| Video                      | ✅ (Intel HD 530 / Discrete graphics disabled)             |
| Webcam                     | ⚠️ Work in progress                                        |
| Wi-fi                      | ✅ (AirportItlwm)                                          |
