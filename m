From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] i2c-cht-wc: Add locking to interrupt / smbus_xfer functions
Date: Mon, 14 Aug 2017 22:17:24 +0200
Message-ID: <20170814201726.21045-2-hdegoede@redhat.com>
References: <20170814201726.21045-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdHNURa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:17:30 -0400
In-Reply-To: <20170814201726.21045-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

Although unlikely without locking the smbux_xfer function may miss
the nack flag and further fixes in this patch-set add some more
complex constructions which need protection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index fe5caf70c7fe..09e0df49df6b 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -47,6 +47,7 @@ struct cht_wc_i2c_adap {
 	struct i2c_adapter adapter;
 	wait_queue_head_t wait;
 	struct irq_chip irqchip;
+	struct mutex adap_lock;
 	struct mutex irqchip_lock;
 	struct regmap *regmap;
 	struct irq_domain *irq_domain;
@@ -63,10 +64,13 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 	struct cht_wc_i2c_adap *adap = data;
 	int ret, reg;
 
+	mutex_lock(&adap->adap_lock);
+
 	/* Read IRQs */
 	ret = regmap_read(adap->regmap, CHT_WC_EXTCHGRIRQ, &reg);
 	if (ret) {
 		dev_err(&adap->adapter.dev, "Error reading extchgrirq reg\n");
+		mutex_unlock(&adap->adap_lock);
 		return IRQ_NONE;
 	}
 
@@ -80,6 +84,16 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 	if (ret)
 		dev_err(&adap->adapter.dev, "Error writing extchgrirq reg\n");
 
+	if (reg & CHT_WC_EXTCHGRIRQ_ADAP_IRQMASK) {
+		adap->nack = !!(reg & CHT_WC_EXTCHGRIRQ_NACK_IRQ);
+		adap->done = true;
+	}
+
+	mutex_unlock(&adap->adap_lock);
+
+	if (reg & CHT_WC_EXTCHGRIRQ_ADAP_IRQMASK)
+		wake_up(&adap->wait);
+
 	/*
 	 * Do NOT use handle_nested_irq here, the client irq handler will
 	 * likely want to do i2c transfers and the i2c controller uses this
@@ -96,12 +110,6 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 		local_irq_enable();
 	}
 
-	if (reg & CHT_WC_EXTCHGRIRQ_ADAP_IRQMASK) {
-		adap->nack = !!(reg & CHT_WC_EXTCHGRIRQ_NACK_IRQ);
-		adap->done = true;
-		wake_up(&adap->wait);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -119,8 +127,10 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 	struct cht_wc_i2c_adap *adap = i2c_get_adapdata(_adap);
 	int ret, reg;
 
+	mutex_lock(&adap->adap_lock);
 	adap->nack = false;
 	adap->done = false;
+	mutex_unlock(&adap->adap_lock);
 
 	ret = regmap_write(adap->regmap, CHT_WC_I2C_CLIENT_ADDR, addr);
 	if (ret)
@@ -146,18 +156,18 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 	ret = wait_event_timeout(adap->wait, adap->done, 3 * HZ);
 	if (ret == 0)
 		return -ETIMEDOUT;
-	if (adap->nack)
-		return -EIO;
 
-	if (read_write == I2C_SMBUS_READ) {
+	ret = 0;
+	mutex_lock(&adap->adap_lock);
+	if (adap->nack)
+		ret = -EIO;
+	else if (read_write == I2C_SMBUS_READ) {
 		ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA, &reg);
-		if (ret)
-			return ret;
-
 		data->byte = reg;
 	}
+	mutex_unlock(&adap->adap_lock);
 
-	return 0;
+	return ret;
 }
 
 static const struct i2c_algorithm cht_wc_i2c_adap_algo = {
@@ -241,6 +251,7 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&adap->wait);
+	mutex_init(&adap->adap_lock);
 	mutex_init(&adap->irqchip_lock);
 	adap->irqchip = cht_wc_i2c_irq_chip;
 	adap->regmap = pmic->regmap;
-- 
2.13.4
