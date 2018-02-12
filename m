From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH] i2c: designware: Fix failure on baytrail
Date: Mon, 12 Feb 2018 09:52:44 -0600
Message-ID: <1518450764-6652-1-git-send-email-gardner.ben@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37519 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeBLPxN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Feb 2018 10:53:13 -0500
Received: by mail-it0-f68.google.com with SMTP id d10so1093528itj.2
        for <linux-i2c@vger.kernel.org>; Mon, 12 Feb 2018 07:53:12 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Ben Gardner <gardner.ben@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

The I2C driver for my Atom E3845 board has been broken since 4.9.
My board has two I2C devices on a bus that are declared via ACPI.
At startup, both drivers attempt to access the devices at the same time,
resulting in two back-to-back I2C transactions initiated by the kernel.
The second transaction fails.

The root issue is that the I2C port takes a while to enable and somewhere
along the way, the 'enable-and-wait' approach to enabling the adapter
was changed to 'enable'.
That caused the driver and hardware to get out of sync and fail.

These kernel logs show up whenever an I2C transaction is attempted after
this failure.
i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready

The driver is unable to recover the bus at this point, but that is a
separate issue.

This patch has been tested on 4.9.

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index b403fa5..980e5a1 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -509,7 +509,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
-- 
2.7.4
