From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/4] sh: sh7785lcr: add GPIO lookup table for i2c controller reset
Date: Wed,  5 Jul 2017 22:13:55 +1200
Message-ID: <20170705101358.17458-2-chris.packham@alliedtelesis.co.nz>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56628 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdGEKOW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 5 Jul 2017 06:14:22 -0400
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, Rich Felker <dalias@libc.org>

Define the GPIO connected to the PCA9564 using a GPIO lookup table. This
will allow the i2c-pca-platform driver to use the device managed APIs to
lookup the gpio instead of using platform_data.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- use correct API (gpio_add_lookup_table) and compile test.

 arch/sh/boards/board-sh7785lcr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 2c4771ee84cd..caec1ebffb09 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/gpio/machine.h>
 #include <mach/sh7785lcr.h>
 #include <cpu/sh7785.h>
 #include <asm/heartbeat.h>
@@ -243,6 +244,14 @@ static struct resource i2c_resources[] = {
 	},
 };
 
+static struct gpiod_lookup_table i2c_gpio_table = {
+	.dev_id = "i2c.0",
+	.table = {
+		GPIO_LOOKUP("pfc-sh7757", 0, "reset-gpios", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static struct i2c_pca9564_pf_platform_data i2c_platform_data = {
 	.gpio			= 0,
 	.i2c_clock_speed	= I2C_PCA_CON_330kHz,
@@ -283,6 +292,7 @@ static int __init sh7785lcr_devices_setup(void)
 		i2c_device.num_resources = ARRAY_SIZE(i2c_proto_resources);
 	}
 
+	gpiod_add_lookup_table(&i2c_gpio_table);
 	return platform_add_devices(sh7785lcr_devices,
 				    ARRAY_SIZE(sh7785lcr_devices));
 }
-- 
2.13.0
