/**
 * @file BlueNRG1_conf.h
 * @author 
 * @brief 
 * @version 0.1
 * @date 
 * 
 * @copyright Copyright (c) 2021
 * 
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BlueNRG1_CONF_H
#define BlueNRG1_CONF_H

/* Includes ------------------------------------------------------------------*/
/* Uncomment/Comment the line below to enable/disable peripheral header file inclusion */

#include "BlueNRG1_adc.h"
#include "BlueNRG1_dma.h"
#include "BlueNRG1_flash.h"
#include "BlueNRG1_gpio.h"
#include "BlueNRG1_i2c.h"
#include "BlueNRG1_mft.h"
#include "BlueNRG1_rtc.h"
#include "BlueNRG1_spi.h"
#include "BlueNRG1_sysCtrl.h"
#include "BlueNRG1_uart.h"
#include "BlueNRG1_wdg.h"
#include "misc.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Uncomment the line below to expanse the "assert_param" macro in the 
   Standard Peripheral Library drivers code */

/* Exported macro ------------------------------------------------------------*/
#ifdef  USE_FULL_ASSERT

/**
  * @brief  The assert_param macro is used for function's parameters check.
  * @param  expr: If expr is false, it calls assert_failed function which reports 
  *         the name of the source file and the source line number of the call 
  *         that failed. If expr is true, it returns no value.
  * @retval None
  */
  #define assert_param(expr) ((expr) ? (void)0 : assert_failed((uint8_t *)__FILE__, __LINE__))
/* Exported functions ------------------------------------------------------- */
  void assert_failed(uint8_t* file, uint32_t line);
#else
  #define assert_param(expr) ((void)0)
#endif /* USE_FULL_ASSERT */

#endif /* BlueNRG1_CONF_H */
