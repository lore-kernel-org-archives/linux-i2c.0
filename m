From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v5 09/14] i2c: octeon: Add workaround for broken irqs on CN3860
Date: Thu, 31 Mar 2016 12:28:22 +0200
Message-ID: <54a5b7938c04a2ebae22fef090c231bf80be90f5.1459352583.git.jglauber@cavium.com>
References: <cover.1459327368.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36755 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbcCaK2v (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Mar 2016 06:28:51 -0400
In-Reply-To: <cover.1459327368.git.jglauber@cavium.com>
In-Reply-To: <cover.1459352583.git.jglauber@cavium.com>
References: <cover.1459352583.git.jglauber@cavium.com>
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
 drivers/i2c/busses/i2c-octeon.c | 55 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index cc1fe51..9621b66 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -119,6 +119,8 @@ struct octeon_i2c {
 	void __iomem *twsi_base;
 	struct device *dev;
 	bool hlc_enabled;
+	bool broken_irq_mode;
+	bool broken_irq_check;
 	void (*int_en)(struct octeon_i2c *);
 	void (*int_dis)(struct octeon_i2c *);
 	void (*hlc_int_en)(struct octeon_i2c *);
@@ -375,10 +377,33 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	long time_left;
 	int first = 1;
 
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some chip revisions seem to not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_test_iflg(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_test_iflg(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->int_en(i2c);
 	time_left = wait_event_timeout(i2c->queue, poll_iflg(i2c, &first),
 				       i2c->adap.timeout);
 	i2c->int_dis(i2c);
+
+	if (time_left <= 0 && i2c->broken_irq_check &&
+	    octeon_i2c_test_iflg(i2c)) {
+		dev_err(i2c->dev,
+			"broken irq connection detected, switching to polling mode.\n");
+		i2c->broken_irq_mode = true;
+		return 0;
+	}
 	if (!time_left) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
@@ -512,17 +537,40 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
 	int time_left;
 
+	if (i2c->broken_irq_mode) {
+		/*
+		 * Some cn38xx boards did not assert the irq in
+		 * the interrupt controller.  So we must poll for the
+		 * IFLG change.
+		 */
+		u64 end = get_jiffies_64() + i2c->adap.timeout;
+
+		while (!octeon_i2c_hlc_test_ready(i2c) &&
+		       time_before64(get_jiffies_64(), end))
+			udelay(50);
+
+		return octeon_i2c_hlc_test_ready(i2c) ? 0 : -ETIMEDOUT;
+	}
+
 	i2c->hlc_int_en(i2c);
 	time_left = wait_event_interruptible_timeout(i2c->queue,
 					octeon_i2c_hlc_test_ready(i2c),
 					i2c->adap.timeout);
 	i2c->hlc_int_dis(i2c);
-	if (!time_left) {
+	if (!time_left)
 		octeon_i2c_hlc_int_clear(i2c);
+
+	if (time_left <= 0 && i2c->broken_irq_check &&
+	    octeon_i2c_hlc_test_ready(i2c)) {
+		dev_err(i2c->dev, "broken irq connection detected, switching to polling mode.\n");
+			i2c->broken_irq_mode = true;
+			return 0;
+	}
+
+	if (!time_left) {
 		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
 		return -ETIMEDOUT;
 	}
-
 	if (time_left < 0) {
 		dev_dbg(i2c->dev, "%s: wait interrupted\n", __func__);
 		return time_left;
@@ -1154,6 +1202,9 @@ static int octeon_i2c_probe(struct platform_device *pdev)
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
