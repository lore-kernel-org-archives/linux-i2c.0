From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: octeon: Add workaround for broken irqs on CN3860
Date: Wed, 27 Apr 2016 11:44:39 +0200
Message-ID: <1461750279-23654-1-git-send-email-jglauber@cavium.com>
References: <20160426211759.GD4587@katana>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36640 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbcD0JpI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 05:45:08 -0400
In-Reply-To: <20160426211759.GD4587@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

From: David Daney <david.daney@cavium.com>

CN3860 does not interrupt the CPU when the i2c status changes. If
we get a timeout, and see the status has in fact changed, we know we
have this problem, and drop back to polling.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 53 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 3144fe9..5b32a02 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -121,6 +121,8 @@ struct octeon_i2c {
 	void __iomem *twsi_base;
 	struct device *dev;
 	bool hlc_enabled;
+	bool broken_irq_mode;
+	bool broken_irq_check;
 	void (*int_enable)(struct octeon_i2c *);
 	void (*int_disable)(struct octeon_i2c *);
 	void (*hlc_int_enable)(struct octeon_i2c *);
@@ -376,10 +378,32 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	long time_left;
 	bool first = 1;
 
+	/*
+	 * Some chip revisions don't assert the irq in the interrupt
+	 * controller. So we must poll for the IFLG change.
+	 */
+	if (i2c->broken_irq_mode) {
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_test_iflg(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			usleep_range(I2C_OCTEON_EVENT_WAIT / 2, I2C_OCTEON_EVENT_WAIT);
+
+		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
 				       i2c->adap.timeout);
 	i2c->int_disable(i2c);
+
+	if (i2c->broken_irq_check && !time_left &&
+	    octeon_i2c_test_iflg(i2c)) {
+		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
+		i2c->broken_irq_mode = true;
+		return 0;
+	}
+
 	if (!time_left)
 		return -ETIMEDOUT;
 
@@ -493,15 +517,37 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 	bool first = 1;
 	int time_left;
 
+	/*
+	 * Some cn38xx boards don't assert the irq in the interrupt
+	 * controller. So we must poll for the valid bit change.
+	 */
+	if (i2c->broken_irq_mode) {
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_hlc_test_valid(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			usleep_range(I2C_OCTEON_EVENT_WAIT / 2, I2C_OCTEON_EVENT_WAIT);
+
+		return octeon_i2c_hlc_test_valid(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->hlc_int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue,
 				       octeon_i2c_hlc_test_ready(i2c, &first),
 				       i2c->adap.timeout);
 	i2c->hlc_int_disable(i2c);
-	if (!time_left) {
+	if (!time_left)
 		octeon_i2c_hlc_int_clear(i2c);
-		return -ETIMEDOUT;
+
+	if (i2c->broken_irq_check && !time_left &&
+	    octeon_i2c_hlc_test_valid(i2c)) {
+		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
+		i2c->broken_irq_mode = true;
+		return 0;
 	}
+
+	if (!time_left)
+		return -ETIMEDOUT;
 	return 0;
 }
 
@@ -1136,6 +1182,9 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX))
+		i2c->broken_irq_check = true;
+
 	result = octeon_i2c_init_lowlevel(i2c);
 	if (result) {
 		dev_err(i2c->dev, "init low level failed\n");
-- 
1.9.1
