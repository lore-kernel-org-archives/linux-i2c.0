From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Documentation: i2c: Fix example in instantiating-devices
Date: Thu,  8 Aug 2013 10:55:11 +0530
Message-ID: <1375939511-7590-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: wsa@the-dreams.de, rob@landley.net, sachin.kamat@linaro.org
List-Id: linux-i2c@vger.kernel.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 Documentation/i2c/instantiating-devices |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
index 2218266..c70e7a7 100644
--- a/Documentation/i2c/instantiating-devices
+++ b/Documentation/i2c/instantiating-devices
@@ -19,7 +19,7 @@ i2c_board_info which is registered by calling i2c_register_board_info().
 
 Example (from omap2 h4):
 
-static struct i2c_board_info __initdata h4_i2c_board_info[] = {
+static struct i2c_board_info h4_i2c_board_info[] __initdata = {
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
 		.irq		= OMAP_GPIO_IRQ(125),
-- 
1.7.9.5

