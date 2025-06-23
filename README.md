# Autosize label addon for Godot 4.X
A godot addon that creates a new node AutosizeLabel that adjust its width and height automaticaly to fit its container

![AutosizeLabel Image](/screenshots/AutosizeLabel.webp)
![How it works animation](/screenshots/autosize-label.webp)

## Attribution
* Licensed under [MIT](LICENSE)
* Icon based on Godot Label icon: MIT License / Copyright (c) 2014-present Godot Engine contributors. / Copyright (c) 2007-2014 Juan Linietsky, Ariel Manzur.
* Based on a suggestion by mrussogit https://github.com/godotengine/godot-proposals/issues/7750#issuecomment-2368542261

## How to use
* Install the plugin by downloading and extracting it on the res:// folder
* Enable the plugin by going to: Project > Project Settings... > Plugins > Check the "Enabled" box on the AutosizeLabel plugin
* You can now the Scene Dock or Ctrl+A to add a Node, located at CanvasItem > Control > Label > AutosizeLabel, or by searching this last name
 
## Configuration properties
* **Autosize**: if unchecked, it disables the autoresize property and resets the text to its default size
* **Font Size Min**: The minimun font size, to prevent the text from becoming too small
* **Font Size Max**: The maximum font size, to prevent the text from becoming too large
* **Margin width**: The margin left by the text horizontally, in percentage, from 0% to 100%
* **Margin height**: The margin left by the text vertically, in percentage, from 0% to 100%
* **Default font size**: The font size used when autosize is disabled
