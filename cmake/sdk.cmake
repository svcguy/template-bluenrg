##############################################
# Peripheral Drivers
##############################################
add_library("bluenrg_periph" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_adc.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_dma.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_flash.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_gpio.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_i2c.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_mft.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_pka.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_radio.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_rng.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_rtc.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_spi.c"
            # This is already included in the common component as it's required to build any project
            #${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_sysCtrl.c
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_timer.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_uart.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/BlueNRG1_wdg.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/src/misc.c"
            )

target_include_directories("bluenrg_periph" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            )

target_compile_options("bluenrg_periph" PRIVATE
                        -mcpu=cortex-m0
                        -mfloat-abi=soft
                        -mthumb
                        -std=c99
                        -c
                        -specs=nano.specs
                        -fdata-sections
                        -ffunction-sections
                        -fstack-usage
                        $<$<CONFIG:Debug>:-g>
                        -Wall
                        $<$<CONFIG:Debug>:-Og>
                        $<$<CONFIG:Release>:-Os>
                        )

target_link_options("bluenrg_periph" PRIVATE
                        -nostartfiles
                        -nodefaultlibs
                        -static
                        -Wl,--gc-sections
                        )

#target_link_libraries(${EXECUTABLE} "bluenrg_periph")

##############################################
# HAL
##############################################
add_library("bluenrg_hal" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/clock.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/fifo.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/gp_timer.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/hal_radio.c"
            # This is already included in the common component as it's required to build any project
            #${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/miscutil.c
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/osal.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/radio_ota.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/sleep.c"
            # vtimer functions are already in stack binary?
            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/src/vtimer.c"
            )

target_include_directories("bluenrg_hal" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/inc"
                            "${CMAKE_CURRENT_SOURCE_DIR}/include"
                            )

target_compile_options("bluenrg_hal" PRIVATE
                        -mcpu=cortex-m0
                        -mfloat-abi=soft
                        -mthumb
                        -std=c99
                        -c
                        -specs=nano.specs
                        -fdata-sections
                        -ffunction-sections
                        -fstack-usage
                        $<$<CONFIG:Debug>:-g>
                        -Wall
                        $<$<CONFIG:Debug>:-Og>
                        $<$<CONFIG:Release>:-Os>
                        )
    
target_link_options("bluenrg_hal" PUBLIC
                    -nostartfiles
                    -nodefaultlibs
                    -static
                    -Wl,--gc-sections
                    )

#target_link_libraries(${EXECUTABLE} "bluenrg_hal")

##############################################
# BSP
##############################################
add_library("bluenrg_bsp" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/HTS221_Driver.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/HTS221_Hal.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/LPS25HB.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/LSM6DS3.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_Button.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_Com.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_Config.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_I2C.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_Led.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/src/SDK_EVAL_SPI.c"
            )

target_include_directories("bluenrg_bsp" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/inc"
                            "${CMAKE_CURRENT_SOURCE_DIR}/include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            )

target_compile_options("bluenrg_bsp" PRIVATE
                            -mcpu=cortex-m0
                            -mfloat-abi=soft
                            -mthumb
                            -std=c99
                            -c
                            -specs=nano.specs
                            -fdata-sections
                            -ffunction-sections
                            -fstack-usage
                            $<$<CONFIG:Debug>:-g>
                            -Wall
                            $<$<CONFIG:Debug>:-Og>
                            $<$<CONFIG:Release>:-Os>
                            )
        
target_link_options("bluenrg_bsp" PUBLIC
                        -nostartfiles
                        -nodefaultlibs
                        -static
                        -Wl,--gc-sections
                        )
    
#target_link_libraries(${EXECUTABLE} "bluenrg_bsp")

##############################################
# RTOS
##############################################
add_library("bluenrg_rtos" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/BlueNRG/freertos_lp.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/croutine.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/event_groups.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/list.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/queue.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/stream_buffer.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/tasks.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/timers.c"
            # Cortex-M0 used in BlueNRG does not have an MPU
            #"${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/Common/mpu_wrappers.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/GCC/ARM_CM0/port.c"
            # Select your memory management implementation
            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/MemMang/heap_1.c"
            #"${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/MemMang/heap_2.c"
            #"${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/MemMang/heap_3.c"
            #"${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/MemMang/heap_4.c"
            #"${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/MemMang/heap_5.c"
            )

target_include_directories("bluenrg_rtos" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/BlueNRG"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_RTOS_PATH}/Source/portable/GCC/ARM_CM0"
                            "${CMAKE_CURRENT_SOURCE_DIR}/include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLE_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            )

target_compile_definitions("bluenrg_rtos" PRIVATE
                            -DDEBUG
                            -DSMPS_INDUCTOR=SMPS_INDUCTOR_NONE
                            -DHS_SPEED_XTAL=HS_SPEED_XTAL_16MHZ
                            -DLS_SOURCE=LS_SOURCE_INTERNAL_RO
                            )   

target_compile_options("bluenrg_rtos" PRIVATE
                        -mcpu=cortex-m0
                        -mfloat-abi=soft
                        -mthumb
                        -std=c99
                        -c
                        -specs=nano.specs
                        -fdata-sections
                        -ffunction-sections
                        -fstack-usage
                        $<$<CONFIG:Debug>:-g>
                        -Wall
                        $<$<CONFIG:Debug>:-Og>
                        $<$<CONFIG:Release>:-Os>
                        )

target_link_options("bluenrg_rtos" PRIVATE
                    -nostartfiles
                    -nodefaultlibs
                    -static
                    -Wl,--gc-sections
                    )               

#target_link_libraries(${EXECUTABLE} "bluenrg_rtos")

##############################################
# CRYPTO
##############################################
# Create a dummy file for add_library
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/crypto_dummy.c "")

add_library("bluenrg_crypto" OBJECT
            "${CMAKE_CURRENT_BINARY_DIR}/crypto_dummy.c"
            )

target_include_directories("bluenrg_crypto" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/inc/AES"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/inc/AES/CMAC"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/inc/AES/Common"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/inc/Common"
                            )

#target_link_libraries("bluenrg_crypto" "${BLUENRG_SDK_PATH}/${BLUENRG_CRYPTO_PATH}/libcrypto.a")
#target_link_libraries(${EXECUTABLE} "bluenrg_crypto")

##############################################
# BLE
##############################################
# Create a dummy file for add_library
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/ble_dummy.c "")

add_library("bluenrg_ble" OBJECT
            "${CMAKE_CURRENT_BINARY_DIR}/ble_dummy.c")

target_include_directories("bluenrg_ble" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLE_PATH}/inc"
                            )

#target_link_libraries("bluenrg_ble" "${BLUENRG_SDK_PATH}/${BLUENRG_BLE_PATH}/library/libbluenrg1_stack.a")
#target_link_libraries(${EXECUTABLE} "bluenrg_ble")

##############################################
# BLE APP
##############################################
add_library("bluenrg_ble_app" OBJECT
            "${BLUENRG_SDK_PATH}/${BLUENRG_BLEAPP_PATH}/OTA/src/OTA_btl.c"
            "${BLUENRG_SDK_PATH}/${BLUENRG_BLEAPP_PATH}/Utils/src/ble_utils.c"
            )

target_compile_definitions("bluenrg_ble_app" PUBLIC
                            -DST_OTA_LOWER_APPLICATION
                            )                       

target_include_directories("bluenrg_ble_app" PUBLIC
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLEAPP_PATH}/layers_inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLEAPP_PATH}/OTA/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLEAPP_PATH}/Utils/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BLE_PATH}/inc"
                            "${CMAKE_CURRENT_SOURCE_DIR}/include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_PERIPH_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/CMSIS/Device/ST/BlueNRG1/Include"
                            "${BLUENRG_SDK_PATH}/CMSIS/Include"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_HAL_PATH}/inc"
                            "${BLUENRG_SDK_PATH}/${BLUENRG_BSP_PATH}/inc"
                            )

target_compile_options("bluenrg_ble_app" PRIVATE
                            -mcpu=cortex-m0
                            -mfloat-abi=soft
                            -mthumb
                            -std=c99
                            -c
                            -specs=nano.specs
                            -fdata-sections
                            -ffunction-sections
                            -fstack-usage
                            $<$<CONFIG:Debug>:-g>
                            -Wall
                            $<$<CONFIG:Debug>:-Og>
                            $<$<CONFIG:Release>:-Os>
                            )

#target_link_libraries(${EXECUTABLE} "bluenrg_ble_app")