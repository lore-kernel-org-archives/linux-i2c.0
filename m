From: Patrick Williams <alpawi@amazon.com>
Subject: [PATCH 2/2] i2c: pxa: remove unused i2c-slave APIs
Date: Tue, 1 Oct 2019 11:00:00 -0500
Message-ID: <20191001160001.2388-3-alpawi@amazon.com>
References: <20191001160001.2388-1-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001160001.2388-1-alpawi@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Patrick Williams <alpawi@amazon.com>, Patrick Williams <patrick@stwcx.xyz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

With the i2c-pxa driver migrated to the standard i2c-slave
APIs, the custom APIs and structures are no longer needed
or used.  Remove them.

Signed-off-by: Patrick Williams <alpawi@amazon.com>
---
 drivers/i2c/busses/i2c-pxa.c          |  1 -
 include/linux/i2c-pxa.h               | 18 ------------------
 include/linux/platform_data/i2c-pxa.h |  4 ----
 3 files changed, 23 deletions(-)
 delete mode 100644 include/linux/i2c-pxa.h

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index c811646e809f..466e4f681d7a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/i2c-pxa.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/i2c-pxa.h b/include/linux/i2c-pxa.h
deleted file mode 100644
index a897e2b507b6..000000000000
--- a/include/linux/i2c-pxa.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_I2C_ALGO_PXA_H
-#define _LINUX_I2C_ALGO_PXA_H
-
-typedef enum i2c_slave_event_e {
-	I2C_SLAVE_EVENT_START_READ,
-	I2C_SLAVE_EVENT_START_WRITE,
-	I2C_SLAVE_EVENT_STOP
-} i2c_slave_event_t;
-
-struct i2c_slave_client {
-	void *data;
-	void (*event)(void *ptr, i2c_slave_event_t event);
-	int  (*read) (void *ptr);
-	void (*write)(void *ptr, unsigned int val);
-};
-
-#endif /* _LINUX_I2C_ALGO_PXA_H */
diff --git a/include/linux/platform_data/i2c-pxa.h b/include/linux/platform_data/i2c-pxa.h
index cb290092599c..6a9b28399b39 100644
--- a/include/linux/platform_data/i2c-pxa.h
+++ b/include/linux/platform_data/i2c-pxa.h
@@ -55,11 +55,7 @@
  */
 #define I2C_ISR_INIT	0x7FF  /* status register init */
 
-struct i2c_slave_client;
-
 struct i2c_pxa_platform_data {
-	unsigned int		slave_addr;
-	struct i2c_slave_client	*slave;
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
-- 
2.17.2 (Apple Git-113)
