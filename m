From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] i2c-cht-wc: Ack read irqs after reading the data register
Date: Mon, 14 Aug 2017 22:17:25 +0200
Message-ID: <20170814201726.21045-3-hdegoede@redhat.com>
References: <20170814201726.21045-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdHNURb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:17:31 -0400
In-Reply-To: <20170814201726.21045-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

Testing has shown that writing 1 to clear the read-complete irq does
not work until the data register has been read first.

This commit fixes the driver to read the data register first, halving the
amount of interrupts in most cases since we mostly read on this i2c bus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 09e0df49df6b..11f7e516f1b1 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -55,7 +55,8 @@ struct cht_wc_i2c_adap {
 	int client_irq;
 	u8 irq_mask;
 	u8 old_irq_mask;
-	bool nack;
+	int read_data;
+	bool io_error;
 	bool done;
 };
 
@@ -76,6 +77,11 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 
 	reg &= ~adap->irq_mask;
 
+	/* Reads must be acked after reading the received data. */
+	ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA, &adap->read_data);
+	if (ret)
+		adap->io_error = true;
+
 	/*
 	 * Immediately ack IRQs, so that if new IRQs arrives while we're
 	 * handling the previous ones our irq will re-trigger when we're done.
@@ -85,7 +91,7 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 		dev_err(&adap->adapter.dev, "Error writing extchgrirq reg\n");
 
 	if (reg & CHT_WC_EXTCHGRIRQ_ADAP_IRQMASK) {
-		adap->nack = !!(reg & CHT_WC_EXTCHGRIRQ_NACK_IRQ);
+		adap->io_error |= !!(reg & CHT_WC_EXTCHGRIRQ_NACK_IRQ);
 		adap->done = true;
 	}
 
@@ -125,10 +131,10 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 				      union i2c_smbus_data *data)
 {
 	struct cht_wc_i2c_adap *adap = i2c_get_adapdata(_adap);
-	int ret, reg;
+	int ret;
 
 	mutex_lock(&adap->adap_lock);
-	adap->nack = false;
+	adap->io_error = false;
 	adap->done = false;
 	mutex_unlock(&adap->adap_lock);
 
@@ -159,12 +165,10 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 
 	ret = 0;
 	mutex_lock(&adap->adap_lock);
-	if (adap->nack)
+	if (adap->io_error)
 		ret = -EIO;
-	else if (read_write == I2C_SMBUS_READ) {
-		ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA, &reg);
-		data->byte = reg;
-	}
+	else if (read_write == I2C_SMBUS_READ)
+		data->byte = adap->read_data;
 	mutex_unlock(&adap->adap_lock);
 
 	return ret;
@@ -238,7 +242,7 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 		.addr = 0x6b,
 		.properties = bq24190_props,
 	};
-	int ret, irq;
+	int ret, reg, irq;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -264,6 +268,11 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 
 	/* Clear and activate i2c-adapter interrupts, disable client IRQ */
 	adap->old_irq_mask = adap->irq_mask = ~CHT_WC_EXTCHGRIRQ_ADAP_IRQMASK;
+
+	ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA, &reg);
+	if (ret)
+		return ret;
+
 	ret = regmap_write(adap->regmap, CHT_WC_EXTCHGRIRQ, ~adap->irq_mask);
 	if (ret)
 		return ret;
-- 
2.13.4
