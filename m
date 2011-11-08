From: Nikolaus Voss <n.voss@weinmann.de>
Subject: [PATCH v11 4/4] G45 TWI: remove open drain setting for twi function
 gpios
Date: Tue, 8 Nov 2011 12:11:03 +0100
Message-ID: <b56adb1bfd2c2188d759ee9cbd5f38208e561667.1346225321.git.n.voss@weinmann.de>
References: <cover.1346225321.git.n.voss@weinmann.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1346225321.git.n.voss@weinmann.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: nicolas.ferre@atmel.com, ben-linux@fluff.org, balbi@ti.com, h.feurstein@gmail.com, rmallon@gmail.com, adrian.yanes@aalto.fi, ludovic.desroches@atmel.com, carsten.behling@garz-fricke.com
List-Id: linux-i2c@vger.kernel.org

The G45 datasheets explicitly states that setting the open drain property
on peripheral function gpios is not allowed. (How about other A91 chips?)

Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index eec5eb6..2134663 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -686,18 +686,12 @@ void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, in
 	/* pins used for TWI interface */
 	if (i2c_id == 0) {
 		at91_set_A_periph(AT91_PIN_PA20, 0);		/* TWD */
-		at91_set_multi_drive(AT91_PIN_PA20, 1);
-
 		at91_set_A_periph(AT91_PIN_PA21, 0);		/* TWCK */
-		at91_set_multi_drive(AT91_PIN_PA21, 1);
 
 		platform_device_register(&at91sam9g45_twi0_device);
 	} else {
 		at91_set_A_periph(AT91_PIN_PB10, 0);		/* TWD */
-		at91_set_multi_drive(AT91_PIN_PB10, 1);
-
 		at91_set_A_periph(AT91_PIN_PB11, 0);		/* TWCK */
-		at91_set_multi_drive(AT91_PIN_PB11, 1);
 
 		platform_device_register(&at91sam9g45_twi1_device);
 	}
-- 
1.7.9.5
