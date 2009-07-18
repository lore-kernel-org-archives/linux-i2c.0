From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] blackfin: Clean up duplicate I2C device type definitions
Date: Sat, 18 Jul 2009 16:54:03 +0200
Message-ID: <20090718165403.49a8e3d3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C_BOARD_INFO() already sets .type, no need to set it again.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/cm_bf527.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.31-rc3.orig/arch/blackfin/mach-bf527/boards/cm_bf527.c	2009-06-25 09:32:06.000000000 +0200
+++ linux-2.6.31-rc3/arch/blackfin/mach-bf527/boards/cm_bf527.c	2009-07-18 16:42:04.000000000 +0200
@@ -796,13 +796,11 @@ static struct i2c_board_info __initdata
 #if defined(CONFIG_BFIN_TWI_LCD) || defined(CONFIG_TWI_LCD_MODULE)
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
