From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/3] MIPS: Octeon: Register some devices on the I2C bus.
Date: Thu,  7 Jan 2010 11:54:21 -0800
Message-ID: <1262894061-32613-3-git-send-email-ddaney@caviumnetworks.com>
References: <4B463B1F.6000404@caviumnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B463B1F.6000404-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: rade.bozic.ext-OYasijW0DpE@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
CC: Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>
---
 arch/mips/cavium-octeon/octeon-platform.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index f2c0602..d8f8129 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -165,6 +166,18 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
+static struct i2c_board_info __initdata octeon_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68),
+	},
+};
+
+static int __init octeon_i2c_devices_init(void)
+{
+	return i2c_register_board_info(0, octeon_i2c_devices,
+				       ARRAY_SIZE(octeon_i2c_devices));
+}
+arch_initcall(octeon_i2c_devices_init);
 
 #define OCTEON_I2C_IO_BASE 0x1180000001000ull
 #define OCTEON_I2C_IO_UNIT_OFFSET 0x200
-- 
1.6.0.6
