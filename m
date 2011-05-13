From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/14] mach-ux500: set proper I2C platform data from MOP500s
Date: Fri, 13 May 2011 12:31:13 +0200
Message-ID: <1305282673-20963-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This specifies the new per-platform timeout per I2C bus and
switches the I2C buses to fast mode, and increase the FIFO
depth to 8 for reads and writes.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-ux500/board-mop500.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 6e1907fa..bb26f40 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -204,7 +204,7 @@ static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	},
 };
 
-#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
+#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, t_out, _sm)	\
 static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	/*				\
 	 * slave data setup time, which is	\
@@ -219,19 +219,21 @@ static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	.rft		= _rft,		\
 	/* std. mode operation */	\
 	.clk_freq	= clk,		\
+	/* Slave response timeout(ms) */\
+	.timeout	= t_out,	\
 	.sm		= _sm,		\
 }
 
 /*
  * The board uses 4 i2c controllers, initialize all of
  * them with slave data setup time of 250 ns,
- * Tx & Rx FIFO threshold values as 1 and standard
+ * Tx & Rx FIFO threshold values as 8 and standard
  * mode of operation
  */
-U8500_I2C_CONTROLLER(0, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
-U8500_I2C_CONTROLLER(1, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
-U8500_I2C_CONTROLLER(2,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
-U8500_I2C_CONTROLLER(3,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(2,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(3,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
 
 static void __init mop500_i2c_init(void)
 {
-- 
1.7.5.1
