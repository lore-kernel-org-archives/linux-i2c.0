From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/4] i2c-nomadik: documentation fixes
Date: Thu, 23 Sep 2010 09:03:40 +0200
Message-ID: <1285225420-916-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This fixes some kerneldoc and assorted documenatation in the
Nomadik I2C driver without semantic impact.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 73de8ad..a73c057 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 ST-Ericsson
+ * Copyright (C) 2009 ST-Ericsson SA
  * Copyright (C) 2009 STMicroelectronics
  *
  * I2C master mode controller driver, used in Nomadik 8815
@@ -431,7 +431,6 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
-
 	return status;
 }
 
@@ -502,9 +501,9 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 
 /**
  * nmk_i2c_xfer() - I2C transfer function used by kernel framework
- * @i2c_adap 	- Adapter pointer to the controller
- * @msgs[] - Pointer to data to be written.
- * @num_msgs - Number of messages to be executed
+ * @i2c_adap: Adapter pointer to the controller
+ * @msgs: Pointer to data to be written.
+ * @num_msgs: Number of messages to be executed
  *
  * This is the function called by the generic kernel i2c_transfer()
  * or i2c_smbus...() API calls. Note that this code is protected by the
@@ -605,6 +604,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 /**
  * disable_interrupts() - disable the interrupts
  * @dev: private data of controller
+ * @irq: interrupt number
  */
 static int disable_interrupts(struct nmk_i2c_dev *dev, u32 irq)
 {
-- 
1.6.3.3
