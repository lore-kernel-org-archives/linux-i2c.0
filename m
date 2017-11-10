From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: ismt: Use %pad specifier for dma_addr_t variables
Date: Fri, 10 Nov 2017 20:33:58 +0200
Message-ID: <20171110183358.86100-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbdKJSeB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Nov 2017 13:34:01 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...which takes care of proper format and size of the value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-ismt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index b51adffa4841..c0d0f34d34f3 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -572,8 +572,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 			return -EIO;
 		}
 
-		dev_dbg(dev, " dma_addr = 0x%016llX\n",
-			(unsigned long long)dma_addr);
+		dev_dbg(dev, " dma_addr = %pad\n", &dma_addr);
 
 		desc->dptr_low = lower_32_bits(dma_addr);
 		desc->dptr_high = upper_32_bits(dma_addr);
-- 
2.14.2
