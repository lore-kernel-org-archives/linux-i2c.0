From: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] MIPS: register hwmon on SWARM
Date: Thu, 18 Aug 2011 19:46:25 -0400
Message-ID: <1313711185-3677-1-git-send-email-mattst88@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/mips/sibyte/swarm/swarm-i2c.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sibyte/swarm/swarm-i2c.c b/arch/mips/sibyte/swarm/swarm-i2c.c
index 0625050..a6e417f 100644
--- a/arch/mips/sibyte/swarm/swarm-i2c.c
+++ b/arch/mips/sibyte/swarm/swarm-i2c.c
@@ -13,6 +13,11 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 
+static struct i2c_board_info swarm_i2c_info0[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm90", 0x2a),
+	},
+};
 
 static struct i2c_board_info swarm_i2c_info1[] __initdata = {
 	{
@@ -24,6 +29,8 @@ static int __init swarm_i2c_init(void)
 {
 	int err;
 
+	err = i2c_register_board_info(0, swarm_i2c_info0,
+				      ARRAY_SIZE(swarm_i2c_info0));
 	err = i2c_register_board_info(1, swarm_i2c_info1,
 				      ARRAY_SIZE(swarm_i2c_info1));
 	if (err < 0)
-- 
1.7.3.4
