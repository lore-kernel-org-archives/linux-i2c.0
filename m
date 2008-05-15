From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Clean up Blackfin BF527 I2C device declarations
Date: Thu, 15 May 2008 14:58:23 +0200
Message-ID: <20080515145823.07af7819@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C_BOARD_INFO() now sets the type field so no need to set it
separatetly.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/ezkit.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.26-rc2.orig/arch/blackfin/mach-bf527/boards/ezkit.c	2008-05-12 08:22:03.000000000 +0200
+++ linux-2.6.26-rc2/arch/blackfin/mach-bf527/boards/ezkit.c	2008-05-15 14:53:00.000000000 +0200
@@ -799,13 +799,11 @@ static struct i2c_board_info __initdata 
 #if defined(CONFIG_TWI_LCD) || defined(CONFIG_TWI_LCD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_lcd", 0x22),
-		.type = "pcf8574_lcd",
 	},
 #endif
 #if defined(CONFIG_TWI_KEYPAD) || defined(CONFIG_TWI_KEYPAD_MODULE)
 	{
 		I2C_BOARD_INFO("pcf8574_keypad", 0x27),
-		.type = "pcf8574_keypad",
 		.irq = IRQ_PF8,
 	},
 #endif


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
