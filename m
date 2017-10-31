From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/15] i2c: thunderx: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:37 +0200
Message-ID: <20171031142149.32512-3-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41879 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbdJaOWX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:23 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index df0976f4432a..61866646ae8e 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -149,8 +149,7 @@ static int thunder_i2c_smbus_setup(struct octeon_i2c *i2c,
 
 static void thunder_i2c_smbus_remove(struct octeon_i2c *i2c)
 {
-	if (i2c->ara)
-		i2c_unregister_device(i2c->ara);
+	i2c_unregister_device(i2c->ara);
 }
 
 static int thunder_i2c_probe_pci(struct pci_dev *pdev,
-- 
2.14.2
