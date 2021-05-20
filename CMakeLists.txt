cmake_minimum_required(VERSION 3.13)

# Toolchain File - No changes needed
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/gcc.cmake)

# BlueNRG SDK Path Setup - Change to your SDK location
if(NOT BLUENRG_SDK_PATH)
    if(WIN32)
       set(BLUENRG_SDK_PATH "C:/Users/svcgu/ST/BlueNRG-1_2-DK-3.2.1/Library")
       message(STATUS "No BLUENRG_SDK_PATH specified, using default: " ${BLUENRG_SDK_PATH})
    endif()
endif()

# Set the components to be included in the build
#   Options are:
#   bluenrg_periph  - low layer peripheral drivers
#   bluenrg_hal     - HAL functions (fifo, osal, vtimer, etc)
#   bluenrg_sdk     - BSP functions (LEDS, buttons, etc)
#   bluenrg_rtos    - FreeRTOS
#   bluenrg_crypto  - crypto library
#   bluenrg_ble     - BlueNRG BLE stack
#   bluenrg_ble_app - upper level BLE utils and OTA updates
set(BLUENRG_COMPONENTS
    "bluenrg_periph"
    "bluenrg_hal"
    )

# Set the folder names for the SDK in case they change in the future
set(BLUENRG_PERIPH_PATH         "BlueNRG1_Periph_Driver")
set(BLUENRG_HAL_PATH            "hal")
set(BLUENRG_BSP_PATH            "SDK_Eval_BlueNRG1")
set(BLUENRG_RTOS_PATH           "FreeRTOS")
set(BLUENRG_CRYPTO_PATH         "cryptolib")
set(BLUENRG_BLE_PATH            "Bluetooth_LE")
set(BLUENRG_BLEAPP_PATH         "BLE_Application")
set(BLUENRG_BLEAPP_CENTRAL_PATH "Profile_Central")

# Define your project name and version here
project(bluenrg-cmake-vscode-template
        VERSION "0.1"
        LANGUAGES C ASM)       

##############################################
# Main Project Executable
##############################################
set(EXECUTABLE ${CMAKE_PROJECT_NAME}.elf)

add_executable(${EXECUTABLE}
                "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c"
                # This is the interrupt handler file
                "${CMAKE_CURRENT_SOURCE_DIR}/src/BlueNRG1_it.c"
                # This is the startup file
                "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Source/system_bluenrg1.c"
                # These two are required by the startup file
                "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/miscutil.c"
                "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_sysCtrl.c"
                )

target_include_directories(${EXECUTABLE} PUBLIC
                            "${CMAKE_CURRENT_SOURCE_DIR}/include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            )

target_compile_definitions(${EXECUTABLE} PUBLIC
                            -DDEBUG
                            -DBLUENRG2_DEVICE
                            -DSMPS_INDUCTOR=SMPS_INDUCTOR_10uH
                            -DHS_SPEED_XTAL=HS_SPEED_XTAL_32MHZ
                            -DLS_SOURCE=LS_SOURCE_EXTERNAL_32KHZ
                            -DUSE_FULL_ASSERT
                            )

target_compile_options(${EXECUTABLE} PUBLIC
                        -mcpu=cortex-m0
                        -mfloat-abi=soft
                        -mthumb
                        -std=c99
                        -c
                        -MD
                        -specs=nano.specs
                        -fdata-sections
                        -ffunction-sections
                        -fstack-usage
                        $<$<CONFIG:Debug>:-g>
                        -Wall
                        # Disable warning on SDK miscutil.c
                        -Wno-address-of-packed-member
                        $<$<CONFIG:Debug>:-Og>
                        $<$<CONFIG:Release>:-Os>
                        )

target_link_options(${EXECUTABLE} PUBLIC
                    -T${CMAKE_CURRENT_SOURCE_DIR}/ld/BlueNRG2.ld
                    -nostartfiles
                    -nodefaultlibs
                    -static
                    -specs=nano.specs
                    -Wl,--gc-sections
                    -Wl,--defsym=malloc_getpagesize_P=0x80
                    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
                    -Wl,--cref
                    -Wl,--print-memory-usage
                    -Wl,--start-group
                    -lc
                    -lm
                    -Wl,--end-group
                    )

##############################################
# Assembly code
##############################################

# Assembly code is handled in this way because the context_switch.s
#   file should have a .S extension because it needs the C preprocessor
#   but has a .s extension instead
add_library("bluenrg_asm" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/context_switch.s"
            )

target_include_directories("bluenrg_asm" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            )

target_compile_options("bluenrg_asm" PRIVATE
                        -mcpu=cortex-m0
                        -mthumb
                        -ggdb
                        -g
                        -x assembler-with-cpp)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/sdk.cmake)

target_link_libraries(${EXECUTABLE} ${BLUENRG_COMPONENTS} "bluenrg_asm")

##############################################
# Build Stage
##############################################
add_custom_command(TARGET ${EXECUTABLE}
                    POST_BUILD
                    COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE}
                    )

add_custom_command(TARGET ${EXECUTABLE}
                    POST_BUILD
                    COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${CMAKE_PROJECT_NAME}.hex
                    COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${CMAKE_PROJECT_NAME}.bin
                    )