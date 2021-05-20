/**
 * @file BlueNRG1_it.h
 * @author 
 * @brief 
 * @version 0.1
 * @date 
 * 
 * @copyright Copyright (c) 2021
 * 
 */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef BlueNRG1_IT_H
#define BlueNRG1_IT_H

/* Includes ------------------------------------------------------------------*/
#include "bluenrg_x_device.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

void NMI_Handler(void);
void HardFault_Handler(void);
void SVC_Handler(void);
void SysTick_Handler(void);

#endif /* BlueNRG1_IT_H */
