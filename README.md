# template-bluenrg

A template for developing for the ST BlueNRG 1/2 Cortex-M0 BLE device.  It uses VSCode, GCC, CMake and the BlueNRG DK to write and build code.  It also uses the Cortex Debug extension with OpenOCD and ST-Link for debug and flashing.

## Requirements
* [VSCode](https://code.visualstudio.com/download)
* VSCode extensions - [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools), [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools), [marus25.cortex-debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)
* [CMake](https://cmake.org/download) (and its dependencies, [Ninja](https://github.com/ninja-build/ninja/releases) in the case of Windows)
* [GCC Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)
* [OpenOCD](http://openocd.org/getting-openocd/)
* [BlueNRG DK](https://www.st.com/en/embedded-software/stsw-bluenrg1-dk.html)
* [ST-Link driver](https://www.st.com/en/development-tools/stsw-link009.html) (Windows Driver)

## Installation
All of the above have excellent installation guides scattered all over the internet.  For the ST tools, in general, it is recommended to __not__ install them in Program Files in Windows.  I use `C:\ST\` - the path is short and easy to type.  I also tend to use `C:\OpenOCD\` for OpenOCD as again the path is shorter.

***MORE TO COME***
