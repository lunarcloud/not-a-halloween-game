#!/bin/bash


butler push --fix-permissions export/windows/ "samsarette/not-a-halloween-game:win"
butler push --fix-permissions export/macos/not-a-halloween-game.zip "samsarette/not-a-halloween-game:mac"
butler push --fix-permissions export/linux/ "samsarette/not-a-halloween-game:linux"
butler push --fix-permissions export/web/ "samsarette/not-a-halloween-game:web"
