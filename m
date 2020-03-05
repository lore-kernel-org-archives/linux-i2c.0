From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] i2c: mux: pca954x: Refactor pca954x_irq_handler()
Date: Thu,  5 Mar 2020 17:53:48 +0200
Message-ID: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCEPxz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Mar 2020 10:53:55 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Refactor pca954x_irq_handler() to:
  - use for_each_set_bit() macro
  - use IRQ_RETVAL() macro

Above change makes code easy to read and understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index a0d926ae3f86..819ff95e64ba 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -327,21 +327,18 @@ static DEVICE_ATTR_RW(idle_state);
 static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
 {
 	struct pca954x *data = dev_id;
-	unsigned int child_irq;
-	int ret, i, handled = 0;
+	unsigned long pending;
+	int ret, i;
 
 	ret = i2c_smbus_read_byte(data->client);
 	if (ret < 0)
 		return IRQ_NONE;
 
-	for (i = 0; i < data->chip->nchans; i++) {
-		if (ret & BIT(PCA954X_IRQ_OFFSET + i)) {
-			child_irq = irq_linear_revmap(data->irq, i);
-			handle_nested_irq(child_irq);
-			handled++;
-		}
-	}
-	return handled ? IRQ_HANDLED : IRQ_NONE;
+	pending = ret >> PCA954X_IRQ_OFFSET;
+	for_each_set_bit(i, &pending, data->chip->nchans)
+		handle_nested_irq(irq_linear_revmap(data->irq, i));
+
+	return IRQ_RETVAL(pending);
 }
 
 static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
-- 
2.25.1
