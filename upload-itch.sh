#!/bin/bash

butler -v push export/windows/ "samsarette/not-a-halloween-game:win"
butler -v push --fix-permissions export/macos/not-a-halloween-game.zip "samsarette/not-a-halloween-game:mac"
butler -v push --fix-permissions export/linux/ "samsarette/not-a-halloween-game:linux"
butler -v push --fix-permissions export/web/ "samsarette/not-a-halloween-game:web"
butler -v push export/android/not-a-halloween-game.apk "samsarette/not-a-halloween-game:android"
