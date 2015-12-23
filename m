From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] i2c: designware: retry transfer on transient failure
Date: Wed, 23 Dec 2015 18:43:24 +0200
Message-ID: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:50627 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbbLWQn6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 11:43:58 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rolland Chau <zourongrong@gmail.com>, Baruch Siach <baruch@tkos.co.il>

Set the i2c_adapter retries field to a sensible value. This allows the i2c core
to retry master_xfer() when it returns -EAGAIN. Currently the i2c-designware
driver returns -EAGAIN only on Tx arbitration failure (DW_IC_TX_ARB_LOST).

Reported-by: Rolland Chau <zourongrong@gmail.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/i2c/busses/i2c-designware-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index de7fbbb374cd..f7b34b360dc9 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -860,6 +860,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	snprintf(adap->name, sizeof(adap->name),
 		 "Synopsys DesignWare I2C adapter");
+	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
-- 
2.6.4
