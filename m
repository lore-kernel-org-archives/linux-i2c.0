From: Ben Gardner <gardner.ben@gmail.com>
Subject: [PATCH] i2c: designware: must wait for enable
Date: Wed, 14 Feb 2018 09:29:52 -0600
Message-ID: <1518622192-19700-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:45662 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031179AbeBNPaB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Feb 2018 10:30:01 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Ben Gardner <gardner.ben@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>, "linux-stable #4 . 13+" <stable@vger.kernel.org>

One I2C bus on my Atom E3845 board has been broken since 4.9.
It has two devices, both declared by ACPI and with built-in drivers.

There are two back-to-back transactions originating from the kernel, one
targeting each device. The first transaction works, the second one locks
up the I2C controller. The controller never recovers.

These kernel logs show up whenever an I2C transaction is attempted after
this failure.
i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready

Waiting for the I2C controller status to indicate that it is enabled
before programming it fixes the issue.

I have tested this patch on 4.14 and 4.15.

Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only if necessary")
Cc: linux-stable <stable@vger.kernel.org> #4.13+
Cc: José Roberto de Souza <jose.souza@intel.com>
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
