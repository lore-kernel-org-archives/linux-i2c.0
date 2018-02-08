From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH] i2c: designware: Fix failure on baytrail
Date: Thu,  8 Feb 2018 12:12:49 -0600
Message-ID: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:42763 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHSNB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Feb 2018 13:13:01 -0500
Received: by mail-io0-f195.google.com with SMTP id g14so566399iob.9
        for <linux-i2c@vger.kernel.org>; Thu, 08 Feb 2018 10:13:01 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Ben Gardner <gardner.ben@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

The I2C driver for my Atom E3845 board has been broken since 4.9.

These kernel logs show up whenever am I2C transaction is attempted.
i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready

The root issue is that the I2C port takes a while to enable and somewhere
along the way, the 'enable-and-wait' approach to enabling the adapter
was changed to 'enable'.
That caused the driver and hardware to get out of sync and fail.

I have tested this patch on 4.14 and 4.15.

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index ae69188..55926ef 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -209,7 +209,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-- 
2.7.4
